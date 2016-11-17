# TODO: Namespace, SRP
def render_template_file(template_file, target_path)
  yield if block_given?

  app_stage_template_path = "#{fetch(:app_folder)}/templates/#{fetch(:stage)}/#{template_file}"
  app_template_path = "#{fetch(:app_folder)}/templates/#{template_file}"

  template_path = File.expand_path("../../templates/#{template_file}", __FILE__)
  if File.exists?(app_stage_template_path)
    template_path = app_stage_template_path
  elsif File.exists?(app_template_path)
    template_path = app_template_path
  end

  template = File.read(template_path)

  compiled_file = ERB.new(template).result(binding)
  io = StringIO.new(compiled_file)

  upload! io, target_path
end

def ask_to_rewrite_file(file, host)
  if test "[ -f #{file} ]"
    info t(:file_already_exists, file: file, host: host)
    ask :rewrite, 'y/N'
    fetch(:rewrite).downcase == 'y'
  else
    true
  end
end

# TODO: namespace it

##
# Render partial files for templates
#
# Trying to find partial templates in three locations, according to priority:
# - Partial for project (`example_project`) with stage (`staging`):
#   `config/deploy/example_project/templates/staging/template.erb`
# - Partial for project (`example_project`) for all stages:
#   `config/deploy/example_project/templates/template.erb`
# - Default partial for all projects:
#   `templates/template.erb`

def render_partial(template_path)
  ERB.new(partial_template(template_path)).result(binding)
end

def partial_template(template_path)
  if File.exist?(partial_project_stage_path(template_path))
    File.read(partial_project_stage_path(template_path))
  elsif File.exist?(partial_project_path(template_path))
    File.read(partial_project_path(template_path))
  else
    File.read(partial_default_path(template_path))
  end
end

def partial_project_stage_path(template_file)
  "#{fetch(:app_folder)}/templates/#{fetch(:stage)}/#{template_file}.erb"
end

def partial_project_path(template_file)
  "#{fetch(:app_folder)}/templates/#{template_file}.erb"
end

def partial_default_path(template_file)
  "templates/#{template_file}.erb"
end
