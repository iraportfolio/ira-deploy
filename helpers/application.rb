def application
  fetch(:application).gsub(/[^\d\w]/, '_')
end
