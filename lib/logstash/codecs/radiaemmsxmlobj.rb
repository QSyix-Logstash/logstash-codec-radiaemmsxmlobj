# encoding: utf-8
require "logstash/codecs/base"
require "logstash/namespace"

# This codec will compose a message formatted as Radia Messaing Server objxml format.
# This message is set as event's message field. Only supports Encode method.
#
# This is only intended to be used as an example.
#
# output {
#   stdout {  
#     codec => radiaemmsxmlobj {
#       rmpversion => "2.0"
#       objname => "TESTOBJ"
#       mapping => [ "EVTTIMESTAMP", "%{@timestamp}", "EVTVERSION", "%{@version}", "EVTHOST", "%{host}", "EVTMESSAGE", "%{message}" ]
#     }
#   }
# }
#
class LogStash::Codecs::Radiaemmsxmlobj < LogStash::Codecs::Base

  # The codec name
  config_name "radiaemmsxmlobj"

  # rmp version
  config :rmpversion, :validate => :string, :default => "2.0"

  # objname version
  config :objname, :validate => :string, :default => "TESTOBJ"

  config :mapping, :validate => :hash

  def register
    require "nokogiri"

  end # def register

  def decode(data)
   
  end # def decode

  # Encode a single event, this returns the raw data to be returned as a String
  def encode_sync(event)
    if @mapping
      evt = Hash.new
      @mapping.each do |k,v|
        evt[k] = event.sprintf(v)
      end
    else
      evt = event.to_hash
    end

    r = evt2xmledmobj(evt)

    event.set('message', r.to_s)

    event.get("message").to_s + NL
  end # def encode_sync

  def evt2xmledmobj(hash)

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.RMP('VERSION' => @rmpversion ) {
        xml.OBJECT('NAME' => @objname.upcase) {
          xml.HEAP() {
            hash.collect do |key, value|
              xml.FIELD('NAME' => key.upcase, 'VALUE' => value) { }
            end
            }
          }
        }
    end
    return builder.to_xml
  end # def evt2xmledmobj

end # class LogStash::Codecs::Radiaemmsxmlobj
