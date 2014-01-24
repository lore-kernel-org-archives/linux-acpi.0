From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 11/20] ARM64 / ACPI: Get the enable method for SMP initialization
Date: Fri, 24 Jan 2014 22:57:33 +0800
Message-ID: <52E27F5D.6070302@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-12-git-send-email-hanjun.guo@linaro.org> <20140123175031.GJ27520@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:44045 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbaAXO5n (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jan 2014 09:57:43 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so3336646pbc.4
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jan 2014 06:57:42 -0800 (PST)
In-Reply-To: <20140123175031.GJ27520@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

Hi Catalin,

On 2014=E5=B9=B401=E6=9C=8824=E6=97=A5 01:50, Catalin Marinas wrote:
> On Fri, Jan 17, 2014 at 12:25:05PM +0000, Hanjun Guo wrote:
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -48,6 +48,7 @@
>>   #include <asm/sections.h>
>>   #include <asm/tlbflush.h>
>>   #include <asm/ptrace.h>
>> +#include <asm/acpi.h>
>>  =20
>>   /*
>>    * as from 2.5, kernels no longer have an init_tasks structure
>> @@ -280,7 +281,7 @@ static void (*smp_cross_call)(const struct cpuma=
sk *, unsigned int);
>>    * cpu logical map array containing MPIDR values related to logica=
l
>>    * cpus. Assumes that cpu_logical_map(0) has already been initiali=
zed.
>>    */
>> -void __init smp_init_cpus(void)
>> +static int __init of_smp_init_cpus(void)
>>   {
>>   	struct device_node *dn =3D NULL;
>>   	unsigned int i, cpu =3D 1;
>> @@ -364,6 +365,10 @@ next:
>>   		cpu++;
>>   	}
>>  =20
>> +	/* No device tree or no CPU node in DT */
>> +	if (cpu =3D=3D 1 && !bootcpu_valid)
>> +		return -ENODEV;
>> +
>>   	/* sanity check */
>>   	if (cpu > NR_CPUS)
>>   		pr_warning("no. of cores (%d) greater than configured maximum of=
 %d - clipping\n",
>> @@ -371,7 +376,7 @@ next:
>>  =20
>>   	if (!bootcpu_valid) {
>>   		pr_err("DT missing boot CPU MPIDR, not enabling secondaries\n");
>> -		return;
>> +		return -EINVAL;
>>   	}
>>  =20
>>   	/*
>> @@ -381,6 +386,39 @@ next:
>>   	for (i =3D 0; i < NR_CPUS; i++)
>>   		if (cpu_logical_map(i) !=3D INVALID_HWID)
>>   			set_cpu_possible(i, true);
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * In ACPI mode, the cpu possible map was enumerated before SMP
>> + * initialization when MADT table was parsed, so we can get the
>> + * possible map here to initialize CPUs.
>> + */
>> +static void __init acpi_smp_init_cpus(void)
>> +{
>> +	int cpu;
>> +	const char *enable_method;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		enable_method =3D acpi_get_enable_method(cpu);
>> +		if (!enable_method)
>> +			continue;
>> +
>> +		cpu_ops[cpu] =3D cpu_get_ops(enable_method);
>> +		if (!cpu_ops[cpu])
>> +			continue;
>> +
>> +		cpu_ops[cpu]->cpu_init(NULL, cpu);
>> +	}
>> +}
>> +
>> +void __init smp_init_cpus(void)
>> +{
>> +	if (!of_smp_init_cpus())
>> +		return;
>> +
>> +	acpi_smp_init_cpus();
>>   }
> With DT we initialise the cpu_ops[0] via cpu_read_bootcpu_ops() calle=
d
> from setup_arch(). This is needed because with PSCI we use cpu_ops fo=
r
> power management even if it's a UP system. Do you get a some kernel
> warning about device node for the boot cpu not found?

Thanks for pointing this out, actually we didn't find a dts file with
spin-table method for SMP initialization, and this patch is not fully
tested (only spin-table method is supported in ACPI now), we are
working on that and get this patch fully tested.

I will review the code carefully in your comments, and update
the code accordingly.

>
>> --- a/drivers/acpi/plat/arm-core.c
>> +++ b/drivers/acpi/plat/arm-core.c
>> @@ -367,6 +367,32 @@ static void __init acpi_process_madt(void)
>>   }
>>  =20
>>   /*
>> + * To see PCSI is enabled or not.
>> + *
>> + * PSCI is not available for ACPI 5.0, return FALSE for now.
>> + *
>> + * FIXME: should we introduce early_param("psci", func) for test pu=
rpose?
>> + */
>> +static bool acpi_psci_smp_available(int cpu)
>> +{
>> +	return FALSE;
>> +}
>> +
>> +static const char *enable_method[] =3D {
>> +	"psci",
>> +	"spin-table",
>> +	NULL
>> +};
>> +
>> +const char *acpi_get_enable_method(int cpu)
>> +{
>> +	if (acpi_psci_smp_available(cpu))
>> +		return enable_method[0];
>> +	else
>> +		return enable_method[1];
>> +}
> You could just use literal strings here, actually even ignoring PSCI
> until available.

Ok.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
