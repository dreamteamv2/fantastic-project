require'roda'
require'yaml'

module CodePraise
    # Configuration  for  the  App
    classApp  <  Roda
      CONFIG  =  YAML.safe_load(File.read('config/secrets.yml'))
      GH_TOKEN  =  CONFIG['GH_TOKEN']
    end
end