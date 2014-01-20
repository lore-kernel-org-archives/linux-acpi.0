From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 03/20] ARM64 / ACPI: Introduce the skeleton of _PDC related
 for ARM64
Date: Mon, 20 Jan 2014 17:20:38 +0800
Message-ID: <52DCEA66.90903@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-4-git-send-email-hanjun.guo@linaro.org> <52D93D4E.5020605@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:55567 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbaATJWl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jan 2014 04:22:41 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so4474195pad.28
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jan 2014 01:22:41 -0800 (PST)
In-Reply-To: <52D93D4E.5020605@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <Sudeep.Holla@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles>

On 2014-1-17 22:25, Sudeep Holla wrote:
> On 17/01/14 12:24, Hanjun Guo wrote:
>> The _PDC (Processor Driver Capabilities) object provides OSPM a
>> mechanism to convey to the platform the capabilities supported
>> by OSPM for processor power management.
>>
>> OSPM evaluates _PDC prior to evaluating any other processor
>> power management objects returning configuration information.
>>
>> This patch introduces the skeleton of _PDC related file to make
>> ACPI core can be compiled on ARM64.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h      |   32 ++++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/processor.h |    2 ++
>>  arch/arm64/kernel/process.c        |    3 +++
>>  3 files changed, 37 insertions(+)
>>  create mode 100644 arch/arm64/include/asm/acpi.h
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> new file mode 100644
>> index 0000000..cf19dc6
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + *  Copyright (C) 2013, Al Stone <al.stone@linaro.org>
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + *
>> + *  This program is free software; you can redistribute it and/or modify
>> + *  it under the terms of the GNU General Public License as published by
>> + *  the Free Software Foundation; either version 2 of the License, or
>> + *  (at your option) any later version.
>> + *
>> + *  This program is distributed in the hope that it will be useful,
>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *  GNU General Public License for more details.
>> + *
>> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> + */
>> +
>> +#ifndef _ASM_ARM64_ACPI_H
>> +#define _ASM_ARM64_ACPI_H
>> +
>> +static inline bool arch_has_acpi_pdc(void)
>> +{
>> +	return false;	/* always false for now */
>> +}
>> +
>> +static inline void arch_acpi_set_pdc_bits(u32 *buf)
>> +{
>> +	return;
>> +}
>> +
>> +#endif /*_ASM_ARM64_ACPI_H*/
>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>> index 45b20cd..50ce951 100644
>> --- a/arch/arm64/include/asm/processor.h
>> +++ b/arch/arm64/include/asm/processor.h
>> @@ -162,6 +162,8 @@ static inline void spin_lock_prefetch(const void *x)
>>  
>>  #define HAVE_ARCH_PICK_MMAP_LAYOUT
>>  
>> +extern unsigned long    boot_option_idle_override;
>> +
>>  #endif
>>  
>>  #endif /* __ASM_PROCESSOR_H */
>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> index de17c89..13d3d7f 100644
>> --- a/arch/arm64/kernel/process.c
>> +++ b/arch/arm64/kernel/process.c
>> @@ -89,6 +89,9 @@ void arch_cpu_idle_prepare(void)
>>  	local_fiq_enable();
>>  }
>>  
>> +unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
>> +EXPORT_SYMBOL(boot_option_idle_override);
>> +
> 
> This is what I mentioned in other email. Do we really foresee use of this in
> ARM64 or it's just added to avoid build issues ?

Just avoid build issues, can not foresee use of this in ARM64 :)

Thanks
Hanjun

