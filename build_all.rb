#!/usr/bin/env ruby

require 'fileutils'
require 'erb'

build_matrix =
 [ 
   ['debug', 'debug', 'arm'],
   ['release', 'production', 'arm'],
   ['debug', 'debug', 'aarch64'],
   ['release', 'production', 'aarch64']
 ]

 build_template = File.read('build.yml.erb')

  FileUtils::rm_r('artefacts') if File.directory?('artefacts')
  FileUtils::mkdir('artefacts')

  build_matrix.each{ |m|
    FileUtils.rm_r('bin') if File.directory?('bin')
    
    build_type = m[0]
    build_task = m[1]
    abi = m[2]

    erb = ERB.new( build_template )

    File.write( 'build.yml', erb.result(binding) )

    `rake device:android:#{build_task}`

    Dir[ "bin/target/android/*.apk" ].each { |f|
      newname = "#{File.basename(f)}-#{build_type}-#{abi}.apk"

      FileUtils.cp(f,"artefacts/#{newname}")
    }
  }
