From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH v4 14/18] ARM64 / ACPI: Add GICv2 specific ACPI boot support
Date: Wed, 17 Sep 2014 09:40:08 +0200
Message-ID: <54193AD8.3090301@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org> <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org> <20140915150136.GF5415@arm.com> <541710D5.3030001@redhat.com> <20140915164253.GI5415@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:59726 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbaIQHjd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Sep 2014 03:39:33 -0400
Received: by mail-wi0-f174.google.com with SMTP id n3so653232wiv.7
        for <linux-acpi@vger.kernel.org>; Wed, 17 Sep 2014 00:39:32 -0700 (PDT)
In-Reply-To: <20140915164253.GI5415@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Jon Masters <jcm@redhat.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, linux

On 15.09.2014 18:42, Catalin Marinas wrote:
> On Mon, Sep 15, 2014 at 05:16:21PM +0100, Jon Masters wrote:
>> On 09/15/2014 11:01 AM, Catalin Marinas wrote:
>>> On Fri, Sep 12, 2014 at 03:00:12PM +0100, Hanjun Guo wrote:
>>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>>> index 5b3546b..9869377 100644
>>>> --- a/arch/arm64/kernel/acpi.c
>>>> +++ b/arch/arm64/kernel/acpi.c
>>>> @@ -23,6 +23,7 @@
>>>>   #include <linux/irqdomain.h>
>>>>   #include <linux/bootmem.h>
>>>>   #include <linux/smp.h>
>>>> +#include <linux/irqchip/arm-gic-acpi.h>
>>>>
>>>>   #include <asm/cputype.h>
>>>>   #include <asm/cpu_ops.h>
>>>> @@ -312,6 +313,28 @@ void __init acpi_boot_table_init(void)
>>>>   		pr_err("Can't find FADT or error happened during parsing FADT\n");
>>>>   }
>>>>
>>>> +void __init acpi_gic_init(void)
>>>> +{
>>>> +	struct acpi_table_header *table;
>>>> +	acpi_status status;
>>>> +	acpi_size tbl_size;
>>>> +	int err;
>>>> +
>>>> +	status = acpi_get_table_with_size(ACPI_SIG_MADT, 0, &table, &tbl_size);
>>>> +	if (ACPI_FAILURE(status)) {
>>>> +		const char *msg = acpi_format_exception(status);
>>>> +
>>>> +		pr_err("Failed to get MADT table, %s\n", msg);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	err = gic_v2_acpi_init(table);
>>>> +	if (err)
>>>> +		pr_err("Failed to initialize GIC IRQ controller");
>>>> +
>>>> +	early_acpi_os_unmap_memory((char *)table, tbl_size);
>>>> +}
>>>
>>> Maybe this was discussed already but why does this function need to live
>>> under arch/arm64? Isn't the driver code more appropriate?

There will be another call here for GICv3 so this function will merge 
common logic for them. As Jon pointed out, we are planning to add ACPI 
flag which indicates GICv3 or GICv2(m) IRQ controller in advance.

>>
>> Well there's two halves to this, right? There's the MADT parsing/setup,
>> which is architecture specific, and then there's the GIC irqchip
>> initialization which lives under drivers.
>
> I think it gets worse, this function is called from irqchip_init(). I
> would have been slightly happier if it was called from the arm64
> init_IRQ(). But putting an ARM specific GIC initialisation call in a
> generic irqchip_init() just looks weird. Can we do anything better here?

Yes this was discussed, please have a look at: 
https://lkml.org/lkml/2014/9/1/555
We had this in init_IRQ() in previous patch set, then we got feedback 
irqchip_init() is more appropriate. We can move it back to init_IRQ() 
and I am sold on this.

Tomasz
