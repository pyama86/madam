class IPVS
  class Service
    def sync(comps)
      # 一致するVirtualServerが存在するか？
      cs = comps.find {|c| self.equal?(c) }

      if cs
        self.dests_sync(cs.dests)
      else
        self.add_service
        add_dests(self.dests)
      end
    end

    def dests_sync(comp_dests)
      delete_dests = comp_dests.select { |cd| self.dests.none? {|d| d.equal?(cd) } }
      delete_dests(delete_dests)

      new_dests = self.dests.select {|d| comp_dests.none? {|cd| cd.equal?(d) } }
      add_dests(new_dests)
    end

    def add_dests(dests)
      dests.each do |d|
        id = ::IPVS::Dest.new({"addr" => d.addr, "port" => d.port, "conn" => d.conn})
        self.add_dest(id)
      end
    end

    def delete_dests(dests)
      dests.each do |d|
        id = ::IPVS::Dest.new({"addr" => d.addr, "port" => d.port, "conn" => d.conn})
        self.del_dest(id)
      end
    end

    def i2s_protocol(num)
      num == 0 ? 'TCP' : 'UDP'
    end
  end
end
