From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 10/17] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
Date: Mon, 08 Sep 2014 21:10:57 +0800
Message-ID: <540DAAE1.9040201@linaro.org>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-11-git-send-email-hanjun.guo@linaro.org> <20140903162739.GF1824@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57881 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbaIHNLO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2014 09:11:14 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so1799521pad.28
        for <linux-acpi@vger.kernel.org>; Mon, 08 Sep 2014 06:11:14 -0700 (PDT)
In-Reply-To: <20140903162739.GF1824@e102568-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 2014=E5=B9=B409=E6=9C=8804=E6=97=A5 00:27, Lorenzo Pieralisi wrote:
> Hi Hanjun,

Hi Lorenzo,

Sorry for the late reply, some comments below.

>
> On Mon, Sep 01, 2014 at 03:57:48PM +0100, Hanjun Guo wrote:
>> Introduce a new function map_gicc_mpidr() to allow MPIDRs to be obta=
ined
>> from the GICC Structure introduced by ACPI 5.1.
>>
>> MPIDR is the CPU hardware ID as local APIC ID on x86 platform, so we=
 use
>> MPIDR not the GIC CPU interface ID to identify CPUs.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/arm64/include/asm/acpi.h |   32 ++++++++++++++++++++++++++++++=
++
>>  arch/arm64/kernel/acpi.c      |    1 -
>>  drivers/acpi/processor_core.c |   37 ++++++++++++++++++++++++++++++=
+++++++
>>  3 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/=
acpi.h
>> index e013dbb..a867467 100644
>> --- a/arch/arm64/include/asm/acpi.h
>> +++ b/arch/arm64/include/asm/acpi.h
>> @@ -12,6 +12,8 @@
>>  #ifndef _ASM_ACPI_H
>>  #define _ASM_ACPI_H
>> =20
>> +#include <asm/smp_plat.h>
>> +
>>  /* Basic configuration for ACPI */
>>  #ifdef	CONFIG_ACPI
>>  #define acpi_strict 1	/* No out-of-spec workarounds on ARM64 */
>> @@ -38,6 +40,36 @@ static inline void disable_acpi(void)
>>  	acpi_noirq =3D 1;
>>  }
>> =20
>> +/* MPIDR value provided in GICC structure is 64 bits, but
>> + * the acpi processor driver use the 32 bits cpu hardware
>> + * ID (apic_id on intel platform) everywhere, it is pretty
>> + * hard to modify the acpi processor driver to accept the
>> + * 64 bits MPIDR value, at the same time, only 32 bits of
>> + * the MPIDR is used in the 64 bits MPIDR, just pack the
>> + * Affx fields into a single 32 bit identifier to accommodate
>> + * the acpi processor drivers.
>> + */
> I have comments on the code in this patch, but they are not the most
> important point. What I am really worried about, it is that as ARM,
> I do not want to know what an apic_id is. This code is *supposed* to =
be
> generic and yet it is chock-full of x86 specific stuff and you are
> trying to make ARM HW concepts fit with x86 ones, and I am not happy
> with that.

apic_id actually represents unique cpu hardware id in MADT to identify
a CPU for x86 and ia64, it was introduced before ACPI supports ARM
platform, when ARM was introduced to ACPI, it needs some updates as
you said.

>
> To be clearer, why does not this look-up of:
>
> logical-cpu-index -> physical-cpu-index
>
> is not carried out using the acpi_id ? Every architecture will have t=
o
> add arch specific code to carry out the reverse look-up:
>
> acpi_id -> apic_id (x86)
> acpi_id -> mpidr_el1 (arm64)
>
> and the code would end up being split in a nice way. On top of that, =
I wonder
> why ACPI structures like eg struct acpi_processor contain x86 specifi=
c
> data (ie apic_id). I know it is a HW identifier as the MPIDR_EL1 is o=
n
> arm64, but I do not want to deal with that in generic ACPI code becau=
se
> that's not generic at ALL.

As I said above, apic_id is cpu hardware id in MADT, its name is
x86 specific now, but meaning behind the name is not x86 specific,
we can rename it as physid or cpu_hw_id, and then will be generic.

Rafael, is it ok to you to rename apic_id to physid or cpu_hw_id in
ACPI core for the reason above?

>
> What if another architecture wants to use ACPI ? Are we going to map =
its
> HW CPU identifier to an apic_id only because that's what x86 requires=
 ?
>
> I am sorry I do not like that. I understand it is easier to map ARM c=
ode
> to existing ACPI structures but I feel we will run into issues very s=
oon
> because of that.
>
> Is it that complex to remove the apic_id dependency in *generic* ACPI
> code and replace it with functions that hook into arch specific code =
to
> carry out the logical to physical cpu mappings ?

Yes, I think there is no easy way to fix that, the main reason is
that MPIDR for ARM64 is 64bit, and apic_id for x86 and ia64 is no
more than 32bit.

thanks
Hanjun

>
> I understand this is harder to do, but it will make your life easier
> in the long run. I am thinking of other pieces of code like the
> supposedly generic ACPI CPUidle driver, where we *still* depend on th=
e apic
> to detect idle states, this is not going to fly, I am sorry, we need =
to
> have code that has a chance to be generic from the beginning not as a=
n
> afterthought.
>
> Lorenzo
>
>> +static inline u32 pack_mpidr_into_32_bits(u64 mpidr)
>> +{
>> +	/*
>> +	 * Bits [0:7] Aff0;
>> +	 * Bits [8:15] Aff1;
>> +	 * Bits [16:23] Aff2;
>> +	 * Bits [32:39] Aff3;
>> +	 */
>> +	return (u32) ((mpidr & 0xff00000000) >> 8) | mpidr;
>> +}
>> +
>> +/*
>> + * The ACPI processor driver for ACPI core code needs this macro
>> + * to find out this cpu was already mapped (mapping from CPU hardwa=
re
>> + * ID to CPU logical ID) or not.
>> + *
>> + * cpu_logical_map(cpu) is the mapping of MPIDR and the logical cpu=
,
>> + * and MPIDR is the cpu hardware ID we needed to pack.
>> + */
>> +#define cpu_physical_id(cpu) pack_mpidr_into_32_bits(cpu_logical_ma=
p(cpu))
>> +
>>  /*
>>   * It's used from ACPI core in kdump to boot UP system with SMP ker=
nel,
>>   * with this check the ACPI core will not override the CPU index
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index fbaaf01..35dff11 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -24,7 +24,6 @@
>>  #include <linux/bootmem.h>
>>  #include <linux/smp.h>
>> =20
>> -#include <asm/smp_plat.h>
>>  #include <asm/cputype.h>
>>  #include <asm/cpu_ops.h>
>> =20
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_=
core.c
>> index e32321c..4007313 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -64,6 +64,38 @@ static int map_lsapic_id(struct acpi_subtable_hea=
der *entry,
>>  	return 0;
>>  }
>> =20
>> +/*
>> + * On ARM platform, MPIDR value is the hardware ID as apic ID
>> + * on Intel platforms
>> + */
>> +static int map_gicc_mpidr(struct acpi_subtable_header *entry,
>> +		int device_declaration, u32 acpi_id, int *mpidr)
>> +{
>> +	struct acpi_madt_generic_interrupt *gicc =3D
>> +	    container_of(entry, struct acpi_madt_generic_interrupt, header=
);
>> +
>> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
>> +		return -ENODEV;
>> +
>> +	/* In the GIC interrupt model, logical processors are
>> +	 * required to have a Processor Device object in the DSDT,
>> +	 * so we should check device_declaration here
>> +	 */
>> +	if (device_declaration && (gicc->uid =3D=3D acpi_id)) {
>> +		/*
>> +		 * Only bits [0:7] Aff0, bits [8:15] Aff1, bits [16:23] Aff2
>> +		 * and bits [32:39] Aff3 are meaningful, so pack the Affx
>> +		 * fields into a single 32 bit identifier to accommodate the
>> +		 * acpi processor drivers.
>> +		 */
>> +		*mpidr =3D ((gicc->arm_mpidr & 0xff00000000) >> 8)
>> +			 | gicc->arm_mpidr;
>> +		return 0;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>>  static int map_madt_entry(int type, u32 acpi_id)
>>  {
>>  	unsigned long madt_end, entry;
>> @@ -99,6 +131,9 @@ static int map_madt_entry(int type, u32 acpi_id)
>>  		} else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_SAPIC) {
>>  			if (!map_lsapic_id(header, type, acpi_id, &apic_id))
>>  				break;
>> +		} else if (header->type =3D=3D ACPI_MADT_TYPE_GENERIC_INTERRUPT) =
{
>> +			if (!map_gicc_mpidr(header, type, acpi_id, &apic_id))
>> +				break;
>>  		}
>>  		entry +=3D header->length;
>>  	}
>> @@ -131,6 +166,8 @@ static int map_mat_entry(acpi_handle handle, int=
 type, u32 acpi_id)
>>  		map_lsapic_id(header, type, acpi_id, &apic_id);
>>  	} else if (header->type =3D=3D ACPI_MADT_TYPE_LOCAL_X2APIC) {
>>  		map_x2apic_id(header, type, acpi_id, &apic_id);
>> +	} else if (header->type =3D=3D ACPI_MADT_TYPE_GENERIC_INTERRUPT) {
>> +		map_gicc_mpidr(header, type, acpi_id, &apic_id);
>>  	}
>> =20
>>  exit:
>> --=20
>> 1.7.9.5
>>
>>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
