From: Sergei Temerkhanov <s.temerkhanov@gmail.com>
Subject: Re: [PATCH] arm64: acpi: Support PCI devices numa_node property in
 ACPI mode
Date: Fri, 7 Apr 2017 11:31:12 -0700
Message-ID: <CAPEA6daR9+BmyW6G9XOsO18782a-tjJrJKyxcYNHeHonuXRggw@mail.gmail.com>
References: <20170406114711.17261-1-s.temerkhanov@gmail.com> <20170407171812.GA12012@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36308 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755228AbdDGSbN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2017 14:31:13 -0400
Received: by mail-io0-f196.google.com with SMTP id 68so8285233ioh.3
        for <linux-acpi@vger.kernel.org>; Fri, 07 Apr 2017 11:31:13 -0700 (PDT)
In-Reply-To: <20170407171812.GA12012@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 7, 2017 at 10:18 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> Hi Sergey,
>
> On Thu, Apr 06, 2017 at 11:47:11AM +0000, Sergey Temerkhanov wrote:
>> This commit modifies ARM64-specific ACPI PCI support functions to
>> properly set the numa_node property on host bridges and thus on PCI
>> devices. Such support requires _PXM objects to be set in DSDT/SSDT
>> tables describing PCI root bridges
>>
>> Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>
>> ---
>>  arch/arm64/kernel/pci.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
>> index 4f0e3ebfea4b..c45c7a26f984 100644
>> --- a/arch/arm64/kernel/pci.c
>> +++ b/arch/arm64/kernel/pci.c
>> @@ -81,7 +81,16 @@ int raw_pci_write(unsigned int domain, unsigned int bus,
>>
>>  int pcibus_to_node(struct pci_bus *bus)
>>  {
>> -     return dev_to_node(&bus->dev);
>> +     struct pci_config_window *cfg = bus->sysdata;
>
> Well, this implicit cast is a guess (ie it might be a DT sysdata
> and there you can't have a clue on what it really is).

Yes, but it's only accessed when acpi_disabled != 0. I just tried to
save few lines and brackets :-)

Regards,
Sergey

>
>> +     struct acpi_device *adev = NULL;
>> +     struct device *dev;
>> +
>> +     if (!acpi_disabled)
>> +             adev = to_acpi_device(cfg->parent);
>> +
>> +     dev = adev ? &adev->dev : &bus->dev;
>> +
>> +     return dev_to_node(dev);
>>  }
>>  EXPORT_SYMBOL(pcibus_to_node);
>>
>> @@ -186,6 +195,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>>       struct pci_bus *bus, *child;
>>       struct acpi_pci_root_ops *root_ops;
>>
>> +     set_dev_node(&root->device->dev, node);
>
> Ok I suspect this is one of those catch-22 issues with host bridge
> creation/scan code (like domain nr), let me have a look I will send
> you a patch next week when I figure out the call ordering required
> to make this work, I want to make sure we can make this work with
> DT and ACPI alike.
>
> Thanks !
> Lorenzo
>
>> +
>>       ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
>>       if (!ri)
>>               return NULL;
>> --
>> 2.12.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
