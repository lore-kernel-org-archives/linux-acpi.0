From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V2 11/23] arm64, pci: Remove useless boot time IRQ
 assignment when booting with DT.
Date: Tue, 12 Jan 2016 17:13:13 +0100
Message-ID: <56952619.7010602@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
 <1450278993-12664-12-git-send-email-tn@semihalf.com>
 <20160112135023.GC3601@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37208 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830AbcALQPQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2016 11:15:16 -0500
Received: by mail-wm0-f44.google.com with SMTP id f206so328574069wmf.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Jan 2016 08:15:15 -0800 (PST)
In-Reply-To: <20160112135023.GC3601@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, matt@masarand.com
Cc: bhelgaas@google.com, arnd@arndb.de, will.deacon@arm.com, catalin.marinas@arm.com, rjw@rjwysocki.net, hanjun.guo@linaro.org, okaya@codeaurora.org, jiang.liu@linux.intel.com, Stefano.Stabellini@eu.citrix.com, robert.richter@caviumnetworks.com, mw@semihalf.com, Liviu.Dudau@arm.com, ddaney@caviumnetworks.com, tglx@linutronix.de, wangyijing@huawei.com, Suravee.Suthikulpanit@amd.com, msalter@redhat.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, jchandra@broadcom.com, jcm@redhat.com

On 12.01.2016 14:50, Lorenzo Pieralisi wrote:
> On Wed, Dec 16, 2015 at 04:16:21PM +0100, Tomasz Nowicki wrote:
>> In order to probe PCIe host controller when booting with DT,
>> ARM64 is using drivers which defer IRQ assignment to device
>> enable time. It means that boot time DT specific irq map initialization
>> is always overridden, so lets remove that code.
>>
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   arch/arm64/kernel/pci.c | 10 ----------
>>   1 file changed, 10 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 023b983..f7948f5 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -51,16 +51,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>>   	return pci_enable_resources(dev, mask);
>>   }
>>
>> -/*
>> - * Try to assign the IRQ number from DT when adding a new device
>> - */
>> -int pcibios_add_device(struct pci_dev *dev)
>> -{
>> -	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>> -
>> -	return 0;
>> -}
>> -
>
> Actually, this patch should be part of Matthew's series:
>

Agree.

Matthew can you please add this patch to your series?

Thanks,
Tomasz
