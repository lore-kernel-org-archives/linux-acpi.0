From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 01/19] ARM64 / ACPI: Get RSDP and ACPI boot-time tables
Date: Tue, 29 Jul 2014 21:08:40 +0800
Message-ID: <53D79CD8.9050709@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-2-git-send-email-hanjun.guo@linaro.org> <53D69678.20002@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44611 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaG2NJ4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jul 2014 09:09:56 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so11649189pdj.14
        for <linux-acpi@vger.kernel.org>; Tue, 29 Jul 2014 06:09:56 -0700 (PDT)
In-Reply-To: <53D69678.20002@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Stone <al.stone@linaro.org>

On 2014-7-29 2:29, Sudeep Holla wrote:
[...]
>> +
>> +/*
>> + * We never plan to use RSDT on arm/arm64 as its deprecated in spec but this
>> + * variable is still required by the ACPI core
>> + */
>> +u32 acpi_rsdt_forced;
> 
> This looks like yet another stray variable not used anywhere including
> core ACPI

It will be used by ACPICA to get the RSDP in acpi_tb_parse_root_table()
in tbutils.c.

> 
>> +
>> +int acpi_noirq;                        /* skip ACPI IRQ initialization */
>> +int acpi_strict;
>> +int acpi_disabled;
>> +EXPORT_SYMBOL(acpi_disabled);
>> +
>> +int acpi_pci_disabled;         /* skip ACPI PCI scan and IRQ initialization */
>> +EXPORT_SYMBOL(acpi_pci_disabled);
>> +
>> +/*
>> + * __acpi_map_table() will be called before page_init(), so early_ioremap()
>> + * or early_memremap() should be called here to for ACPI table mapping.
>> + */
>> +char *__init __acpi_map_table(unsigned long phys, unsigned long size)
>> +{
>> +       if (!phys || !size)
>> +               return NULL;
>> +
>> +       return early_memremap(phys, size);
>> +}
>> +
>> +void __init __acpi_unmap_table(char *map, unsigned long size)
>> +{
>> +       if (!map || !size)
>> +               return;
>> +
>> +       early_iounmap(map, size);
> 
> Why not early_memunmap for consistency ?

ok.

> Also now there's generic implementation of early mappings does it make
> sense to move this also to acpi core ?

Good point, how about clean it up after this patch set is merged?

Thanks
Hanjun


