Facter.add(:is_puppetmaster) do
  setcode do
	distid = Facter.value(:hostname)
	 case distid
	   when 'node1'
		  true
		else
		  false
		end
	end
end