From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: ACPI hotplug panic with current git head
Date: Wed, 28 Jan 2009 21:05:50 +0900
Message-ID: <49804A1E.9030503@jp.fujitsu.com>
References: <1231604250.3642.33.camel@localhost.localdomain>	 <alpine.LFD.2.00.0901121604380.5859@localhost.localdomain>	 <1231807693.27151.21.camel@localhost.localdomain>	 <1232046108.5966.57.camel@localhost.localdomain>	 <alpine.LFD.2.00.0901151421110.4737@localhost.localdomain>	 <1232049269.5966.64.camel@localhost.localdomain>	 <1232050347.5966.66.camel@localhost.localdomain>	 <4970242C.4010404@jp.fujitsu.com>	 <1232115546.3224.5.camel@localhost.localdomain>	 <4973D2EE.3060203@jp.fujitsu.com>	 <1232328216.3247.68.camel@localhost.localdomain>	 <4973EF64.2050404@jp.fujitsu.com> <1232558780.736.24.camel@localhost.localdomain> <497D1BD7.9000609@jp.fujitsu.com> <498045D1.60005@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <498045D1.60005@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, "Barnes, Jesse" <jesse.barnes@intel.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, shaohua.li@intel.com, Grant Grundler <grundler@parisc-linux.org>
List-Id: linux-acpi@vger.kernel.org

Kenji Kaneshige wrote:
> Kenji Kaneshige wrote:
>> James Bottomley wrote:
>>> On Mon, 2009-01-19 at 12:11 +0900, Kenji Kaneshige wrote:
>>>> I'm sending the debug patch against 2.6.29-rc1 below. I'm also
>>>> sending it as an attachment. It also contains the code to prevent
>>>> the kernel panic from you. Please note that you will see two
>>>> WARN_ON(1) messages with the patch. Those are shown by my debug
>>>> patch.
>>>>
>>>> Could you try it and send me the whole dmsg output?
>>> Actually, the machine is now running -rc2, so the patch doesn't quite
>>> apply: 
>>>
>>> jejb@sparkweed> patch -p1 < ~/tmp.diff
>>> patching file include/linux/pci-acpi.h
>>> patching file drivers/pci/hotplug/acpiphp_glue.c
>>> Hunk #1 FAILED at 266.
>>> Hunk #2 succeeded at 467 (offset 2 lines).
>>> Hunk #3 succeeded at 489 (offset 2 lines).
>>> Hunk #4 succeeded at 518 (offset 2 lines).
>>> Hunk #5 succeeded at 556 (offset 2 lines).
>>>
>>> Looks like the rejection is in the NULL check piece, so I've already
>>> actually sent you the information it would produce.
>>>
>>> The dmesg output is pretty big, below.
>>>
>> Thank you very much, James.
>>
>> Thanks to you, I found the root cause of the
>> problem. The acpi_pci_get_bridge_handle() function assumes
>> pci_bus->self is NULL on the root bus. But it is not true
>> and pci_bus->self can have a non-NULL value on some
>> platfroms (like yours). So it must check pci_bus->parent
>> instead.
>>
>> I found some other code that has the same wrong assumption.
>> I'll make a fix for them and send it soon.
>>
> 
> I made several patches to fix the wrong assumption described
> above. It is very difficult for me to check all the code that
> refers pci_bus->self. So I checked include/linux/pci-acpi.h and
> the code under drivers/pci/ only. And I made patches for the code
> like below:
> 
>  - The code that clearly chooses host bridge operation or
>    PCI-to-PCI bridge operation based on pci_bus->self.
> 
>  - The code that might cause endless loop if pci_bus->self is
>    not NULL on the PCI root bus.
> 
> The patches are
> 
>  - [PATCH 1/8] PCI/ACPI: fix wrong assumption in acpi_pci_get_bridge_handle
>  - [PATCH 2/8] PCI/ACPI: fix wrong assumption in acpi_find_root_bridge_handle
>  - [PATCH 3/8] PCI hotplug: fix wrong assumption in acpi_get_hp_params_from_firmware
>  - [PATCH 4/8] PCI hotplug: fix wrong assumption in acpi_get_hp_hw_control_from_firmware
>  - [PATCH 5/8] PCI: fix wrong assumption in pci_find_upstream_pcie_bridge
>  - [PATCH 6/8] PCI: fix wrong assumption in pci_read_bridge_bases
>  - [PATCH 7/8] PCI: fix wrong assumption in pci_get_interrupt_pin
>  - [PATCH 8/8] PCI: fix wrong assumption in pci_common_swizzle
> 

Those patches are against 2.6.29-rc2.

Thanks,
Kenji Kaneshige
