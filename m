From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 4/4] ACPI PCI slot detection driver
Date: Wed, 12 Mar 2008 13:08:41 +0900
Message-ID: <47D75749.5060203@jp.fujitsu.com>
References: <20080229002341.GA21420@ldl.fc.hp.com> <20080301144307.GD24386@parisc-linux.org> <20080304054927.GA15566@suse.de> <200803041018.29035.jbarnes@virtuousgeek.org> <20080304193036.GB5534@suse.de> <20080304230937.GD3694@ldl.fc.hp.com> <47CDF339.3060304@jp.fujitsu.com> <20080305202052.GN3694@ldl.fc.hp.com> <47D684D0.6060200@jp.fujitsu.com> <20080311132800.GC21482@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:47061 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYCLEK3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Mar 2008 00:10:29 -0400
In-Reply-To: <20080311132800.GC21482@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Gary Hade <garyhade@us.ibm.com>, warthog19@eaglescrag.net, kristen.c.accardi@intel.com, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Hi,

Matthew Wilcox wrote:
> On Tue, Mar 11, 2008 at 10:10:40PM +0900, Kenji Kaneshige wrote:
>> 1) I checked ACPI spec again and again, but I could not find any
>>    reason to add Fujitsu servers to quirks list. So I'd like you to
>>    add HP servers to the quirks list. I'll send the following patches
>>    followed by this e-mail.
> 
> Alex pointed out that IBM interprets the spec the same way that HP does.
> Are there any other machines that follow the spec the same way that
> Fujitsu does?
> 

I don't know.

>> 2) The ACPI PCI slot detection driver would change the slot names of
>>    some hotplug drivers (at least I checked shpchp and pciehp). And
>>    the name of slots are depending on the order of driver loading.
>>    For example, on my system which has several SHPCHP slots and
>>    PCIEHP slots, the name of PCIEHP slots are changed as
>>    follows. Please note that PCIEHP based slots are 0034_0027 and
>>    0032_0026, and others are SHPCHP based slots.
>>
>>    - Without ACPI PCI slot detection driver
>>      # ls /sys/bus/pci/slots/
>>      0009_0016  0014_0018  0019_0020  0021_0022  0034_0027
>>      0011_0017  0016_0019  0021_0021  0032_0026
>>
>>    - With ACPI PCI slot detection driver
>>      # ls /sys/bus/pci/slots/
>>      0009_0016  0014_0018  0019_0020  0021_0022  27
>>      0011_0017  0016_0019  0021_0021  26
> 
> I hadn't realised that patch got in to put the bus name in as a
> uniquifier.  I thought we'd rejected it because the problem only
> occurred on one box with bad firmware.
>

Maybe I've told you before :-)

I also don't like to put bus into the names of those directories,
because I think the names of those directories are used as physical
slot identifier, not logical identifier, and neither PCI-to-PCI
Bridge Architecture spec, PCI Hot-Plug spec, SHPC spec nor PCI
Express spec allow putting bus number into physical slot identifier.

Removing bus number from the names of those directories would fix
the problem in a short term. But I think it is only a band-aid
because all of those specifications allow using chassis number
in the physical slot identifier. If any hotplug driver will put
chassis number into slot names, the same problem will happen.

I think it's the right direction to use combination of chassis and
slot number as a slot name if we try to unify slot names among
drivers, though there will be some challenges as follows.

- how to handle the names of vendor specific hotplug drivers?
- SHPC spec allows vendor specific names, IIRC. how to handle it?
- and so on.

>>    - Unify slot names among all hotplug drivers
> 
> That is the plan.  I'm not sure why the shpc slots aren't renamed in
> this revision of the patch -- maybe Alex dropped that part?
> 

Maybe the reason is very simple. The SHPCHP driver was loaded first,
and then ACPI PCI slot detection driver was loaded. Both are loaded
automatically at boot time. If we changed the order, we would get
another result.

Thanks,
Kenji Kaneshige

