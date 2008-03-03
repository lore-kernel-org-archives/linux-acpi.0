From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/4] Remove path attribute from sgi_hotplug
Date: Mon, 03 Mar 2008 13:54:00 -0500
Message-ID: <47CC4948.7020307@redhat.com>
References: <20080229002341.GA21420@ldl.fc.hp.com> <20080229002640.GB21420@ldl.fc.hp.com> <200803031048.20762.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34375 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752106AbYCCSyk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Mar 2008 13:54:40 -0500
In-Reply-To: <200803031048.20762.jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Alex Chiang <achiang@hp.com>, Gary Hade <garyhade@us.ibm.com>, kaneshige.kenji@jp.fujitsu.com, warthog19@eaglescrag.net, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, kristen.c.accardi@intel.com, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org


>> -	bss_hotplug_slot->name = kmalloc(SN_SLOT_NAME_SIZE, GFP_KERNEL);
>> -	if (!bss_hotplug_slot->name) {
>> -		kfree(bss_hotplug_slot->private);
>> -		return -ENOMEM;
>> -	}
>> +	bss_hotplug_slot->name = slot->physical_path;
>>
>>  	slot->device_num = device;
>>  	slot->pci_bus = pci_bus;
>> -	sprintf(bss_hotplug_slot->name, "%04x:%02x:%02x",
>> -		pci_domain_nr(pci_bus),
>> -		((u16)pcibus_info->pbi_buscommon.bs_persist_busnum),
>> -		device + 1);
>>
>>     
>   
Ugh ... it has been a while since I've looked at or owned this code ;) 
-- but I do seem to recall that on SGI boxes the slot's name was 
different from the physical path of the device (ie, what was stamped on 
the back of the PCI hotplug chassis was different from Linux' PCI name) 
-- OTOH, I haven't recently looked at what slot->physical_path has been 
initialized to, so they might now be one-and-the-same ....

P.
