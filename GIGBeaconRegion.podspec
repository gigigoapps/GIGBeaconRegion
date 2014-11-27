Pod::Spec.new do |s|
  s.name             = "GIGBeaconRegion"
  s.version          = "0.1.0"
  s.summary          = "CLBeaconRegion subclass that can range beacons with any proximity UDID"
  s.homepage         = "https://github.com/gigigoapps/GIGBeaconRegion"
  s.license          = 'MIT'
  s.author           = { "alexruperez" => "alejandro.ruperez@gigigo.com" }
  s.source           = { :git => "https://github.com/gigigoapps/GIGBeaconRegion.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gigigoapps'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'

  s.frameworks = 'CoreLocation'
end
