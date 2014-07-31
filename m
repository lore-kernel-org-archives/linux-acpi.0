From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 06/19] ARM64 / ACPI: Parse FADT table to get PSCI flags
 for PSCI init
Date: Thu, 31 Jul 2014 11:53:14 +0800
Message-ID: <53D9BDAA.7080907@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org> <1406206825-15590-7-git-send-email-hanjun.guo@linaro.org> <53D7CE6F.1050407@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:52414 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756039AbaGaDyc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Jul 2014 23:54:32 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2642101pdj.26
        for <linux-acpi@vger.kernel.org>; Wed, 30 Jul 2014 20:54:31 -0700 (PDT)
In-Reply-To: <53D7CE6F.1050407@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@linaro.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2014-7-30 0:40, Sudeep Holla wrote:
[...]
>>
>> +/* 1 to indicate PSCI is implemented */
>> +int acpi_psci_present;
>> +
>> +/* 1 to indicate HVC must be used instead of SMC as the PSCI conduit */
>> +int acpi_psci_use_hvc;
>> +
> 
> These can be boolean but can be removed IMO, see below.
> 
>>   /*
>>    * __acpi_map_table() will be called before page_init(), so early_ioremap()
>>    * or early_memremap() should be called here to for ACPI table mapping.
>> @@ -54,6 +62,33 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
>>       early_iounmap(map, size);
>>   }
>>
>> +static int __init acpi_parse_fadt(struct acpi_table_header *table)
>> +{
>> +    struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
>> +
>> +    /*
>> +     * Revision in table header is the FADT Major version,
>> +     * and there is a minor version of FADT which was introduced
>> +     * by ACPI 5.1, we only deal with ACPI 5.1 or higher version
>> +     * to get arm boot flags, or we will disable ACPI.
>> +     */
>> +    if (table->revision < 5 || fadt->minor_version < 1) {
>> +        pr_info("FADT version is %d.%d, no PSCI support, should be 5.1 or
>> higher\n",
>> +            table->revision, fadt->minor_version);
>> +        acpi_psci_present = 0;
>> +        disable_acpi();
>> +        return -EINVAL;
>> +    }
>> +
>> +    if (acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_COMPLIANT)
>> +        acpi_psci_present = 1;
>> +
>> +    if (acpi_gbl_FADT.arm_boot_flags & ACPI_FADT_PSCI_USE_HVC)
>> +        acpi_psci_use_hvc = 1;
>> +
> 
> Why not make this macros instead of global variables as I suggested in
> previous version. acpi_gbl_FADT is already global and you can avoid
> creating new one especially they are just used on boot/init.

Ok, it makes sense to me, I will update it in next version.

Thanks
Hanjun

