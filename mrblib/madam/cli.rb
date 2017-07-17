module Madam
  class Cli
    class << self
      def show
        puts ::IPVS.services.inspect
      end

      def apply(json, ipvs_services=nil)
        new_services = parse(json)
        ipvs_services ||= ::IPVS.services

        # 削除するサービスが存在する場合は削除する
        ipvs_services.reject { |is| new_services.any? {|ns| ns.equal?(is) } }.each do |s|
          s.del_service
        end

        new_services.each do |ns|
          # 同じサービスであり変更がない場合は何もしない
          next if ipvs_services.any? {|i|i.deep_equal?(ns) }

          # 変更がある場合は新規に合わせて変更する
          ns.sync(ipvs_services)
        end
      end

      def parse(json)
        hashs = JSON.parse(json)
        hashs.map do |hash|
          s = ::IPVS::Service.new({
            "protocol" => hash['protocol'] == 0 ? 'TCP' : 'UDP',
            "addr" => hash['virtual_ip'],
            "port" => hash['virtual_port'],
            "sched_name" => "rr"
          })

          s.dests = hash['dests'].map { |d|
            ::IPVS::Dest.new({
              "addr" => d['ip'],
              "weight" => d['weight'] || 1,
              "port" => d['port'],
              "conn" => d['conn'] || 'DR'
            })
          }
          s
        end
      end
    end
  end
end
