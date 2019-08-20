require 'rho'
require 'rho/rhocontroller'
require 'rexml/document'
require 'cgi'

class ParserController < Rho::RhoController
    def index
    end

    def parse
        begin
            @xml_string = @params['xmldata']
            @xml_escaped = ::CGI::escapeHTML(@xml_string)
            @doc = REXML::Document.new( @xml_string )            
            render :action => :result
        rescue Exception => e
            @error = ::CGI::escapeHTML(e.to_s + "\n#{e.backtrace}")
            render :action => :error
        end        
    end

    def parse_url
        @from_network = Rho::Network.get( { url: @params['url'] }, 
            ->(p) { Rho::WebView.navigate( url_for( :action => :parse, :query => { 'xmldata' => p['body'] } ) ) } 
        )

        render :string => 'Loading'
    end
end