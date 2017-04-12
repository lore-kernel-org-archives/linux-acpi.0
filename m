From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH] arm64: acpi: Support PCI devices numa_node property in
 ACPI mode
Date: Wed, 12 Apr 2017 13:27:28 -0400
Message-ID: <855540a9-888d-6419-3add-d8b0dbb43029@codeaurora.org>
References: <0dada57f-4215-4ced-482d-88203857e06d@codeaurora.org>
 <20170412170433.GA7412@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:42322 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdDLR1b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Apr 2017 13:27:31 -0400
In-Reply-To: <20170412170433.GA7412@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lorenzo,

On 4/12/2017 1:04 PM, Lorenzo Pieralisi wrote:
> On Sat, Apr 08, 2017 at 01:17:32PM -0400, Sinan Kaya wrote:
>> On 12/31/1969 7:00 PM, linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Sergey Temerkhanov wrote:
>>>  int pcibus_to_node(struct pci_bus *bus)  {
>>> -	return dev_to_node(&bus->dev);
>>> +	struct pci_config_window *cfg = bus->sysdata;
>>> +	struct acpi_device *adev = NULL;
>>> +	struct device *dev;
>>> +
>>> +	if (!acpi_disabled)
>>> +		adev = to_acpi_device(cfg->parent);
>>> +
>>
>> I see a problem here that NUMA node information is read from the
>> parent device.  PCI bus can have multiple levels of switches and
>> bridges. The NUMA information is only present on the host bridge.
>>
>> This code only works if the endpoint is directly connected to the root
>> port. 
> 
> That's not what this code does. This code retrieves the struct device
> backing the ACPI device representing the PNP0A08 host bridge and its
> dev->numa_node value (that was set in pci_acpi_scan_root()).

pcibus_to_node() gets called from two places. The first place is 
pci_register_host_bridge() like you mentioned. 

The second place is pci_device_add(). pci_device_add() gets called for
every single device that is getting added to the system. 

> 
> I am not a big fan of this. I wonder if we could not make it DT/ACPI
> agnostic by simply setting the numa_node in the pci_bus->dev field,
> and propagate it downstream a PCI hierarcy (as we do with sysdata)
> in pci_alloc_child_bus().

Yeah, that's what I was going to ask next about how other arches solve
this. Common solution to DT/ACPI is preferable as the issue exists in
both places unless DT has some other mechanism hidden behind the scenes.

> 
> This way pcibus_to_node() would become straightforward (ie as it
> is now - provided the above is doable):
> 
> dev_to_node(&bus->dev);
> 
> This is suspiciously similar to the domain number song and dance
> except that the NUMA node now is in the struct pci_bus->dev->numa_node
> instead of struct pci_bus->domain_nr.

I think this looks like the _CCA dance we are doing.

> 
> Lorenzo
> 

Sinan

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
