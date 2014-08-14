Pod::Spec.new do |s|
  s.name             = "UITextFieldWithLimit"
  s.version          = "0.1.1"
  s.summary          = "This subclass of the UITextField, adds a text length limit."
  s.homepage         = "https://github.com/azu/UITextFieldWithLimit"
  s.screenshots      = "http://gyazo.com/469ee2f88953cda723db1ea9744d8ff8.gif"
  s.license          = 'MIT'
  s.author           = {"azu" => "azuciao@gmail.com"}
  s.source           = {:git => "https://github.com/azu/UITextFieldWithLimit.git", :tag => s.version.to_s}
  s.social_media_url = 'https://twitter.com/azu_re'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
end
