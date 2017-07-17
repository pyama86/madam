def __main__(argv)
  argv.shift
  case argv[0]
  when "version"
    puts "v#{Madam::VERSION}"
  when "apply"
    Madam::Cli.apply(argv[1])
  when "show"
    Madam::Cli.show
  else
    puts <<-USAGE
madam - set up ipvs service
commands:
    apply   - set up ipvs configurations from json
    show    - show current configurations
    version - show version
    USAGE
  end
end
