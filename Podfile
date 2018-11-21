# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

def testing_pods
    pod 'Quick', '~> 1'
    pod 'Nimble', '~> 7'
    pod 'Nimble-Snapshots', '~> 6'
    pod 'iOSSnapshotTestCase', '~> 4'
    pod 'Mockingjay'
end

target 'SuperheroesMovies' do
  use_frameworks!

  target 'SuperheroesMoviesTests' do  
    use_frameworks!

    testing_pods
  end
end
