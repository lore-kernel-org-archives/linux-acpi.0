From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v2 09/18] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Tue, 19 Aug 2014 16:37:34 +0800
Message-ID: <53F30CCE.9040705@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org> <1407166105-17675-10-git-send-email-hanjun.guo@linaro.org> <20140818142740.GU20043@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49126 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbaHSIjM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Aug 2014 04:39:12 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so8952369pdj.26
        for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2014 01:39:07 -0700 (PDT)
In-Reply-To: <20140818142740.GU20043@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2014-8-18 22:27, Catalin Marinas wrote:
> On Mon, Aug 04, 2014 at 04:28:16PM +0100, Hanjun Guo wrote:
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
>> index 022f4ad..a81898d 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -12,6 +12,8 @@
>>  #ifndef _ASM_ACPI_H
>>  #define _ASM_ACPI_H
>>  
>> +#include <asm/smp_plat.h>
>> +
>>  /* Basic configuration for ACPI */
>>  #ifdef	CONFIG_ACPI
>>  /*
>> @@ -59,6 +61,18 @@ static inline void disable_acpi(void)
>>  	acpi_noirq = 1;
>>  }
>>  
>> +u32 pack_mpidr_into_32_bits(u64 mpidr);
> 
> I would define this as a static inline function here.

ok, will update it.

> 
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>> index e32321c..4007313 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -64,6 +64,38 @@ static int map_lsapic_id(struct acpi_subtable_header *entry,
>>  	return 0;
>>  }
>>  
>> +/*
>> + * On ARM platform, MPIDR value is the hardware ID as apic ID
>> + * on Intel platforms
>> + */
>> +static int map_gicc_mpidr(struct acpi_subtable_header *entry,
>> +		int device_declaration, u32 acpi_id, int *mpidr)
>> +{
>> +	struct acpi_madt_generic_interrupt *gicc =
>> +	    container_of(entry, struct acpi_madt_generic_interrupt, header);
>> +
>> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
>> +		return -ENODEV;
>> +
>> +	/* In the GIC interrupt model, logical processors are
>> +	 * required to have a Processor Device object in the DSDT,
>> +	 * so we should check device_declaration here
>> +	 */
>> +	if (device_declaration && (gicc->uid == acpi_id)) {
>> +		/*
>> +		 * Only bits [0:7] Aff0, bits [8:15] Aff1, bits [16:23] Aff2
>> +		 * and bits [32:39] Aff3 are meaningful, so pack the Affx
>> +		 * fields into a single 32 bit identifier to accommodate the
>> +		 * acpi processor drivers.
>> +		 */
>> +		*mpidr = ((gicc->arm_mpidr & 0xff00000000) >> 8)
>> +			 | gicc->arm_mpidr;
> 
> You can use pack_mpidr_into_32_bits().

processor_core.c will be used by x86 and ia64 too, it will cause
compile error on !ARM64 platforms.

Thanks
Hanjun
