From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v9 13/21] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Tue, 10 Mar 2015 19:33:21 +0800
Message-ID: <54FED681.8030609@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-14-git-send-email-hanjun.guo@linaro.org> <20150305184925.GF4932@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:37777 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbCJLdb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2015 07:33:31 -0400
Received: by paceu11 with SMTP id eu11so1128907pac.4
        for <linux-acpi@vger.kernel.org>; Tue, 10 Mar 2015 04:33:30 -0700 (PDT)
In-Reply-To: <20150305184925.GF4932@quad.lixom.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

Hi Olof,

On 2015=E5=B9=B403=E6=9C=8806=E6=97=A5 02:49, Olof Johansson wrote:
> Hi,
>
> On Wed, Feb 25, 2015 at 04:39:53PM +0800, Hanjun Guo wrote:
>> MADT contains the information for MPIDR which is essential for
>> SMP initialization, parse the GIC cpu interface structures to
>> get the MPIDR value and map it to cpu_logical_map(), and add
>> enabled cpu with valid MPIDR into cpu_possible_map.
>>
>> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
>> Parking protocol, but the Parking protocol is only specified for
>> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
>> before some updates for the ACPI spec or the Parking protocol spec.
>>
>> Parking protocol patches for SMP boot will be sent to upstream when
>> the new version of Parking protocol is ready.
>>
>> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> Tested-by: Yijing Wang <wangyijing@huawei.com>
>> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
>> Tested-by: Jon Masters <jcm@redhat.com>
>> Tested-by: Timur Tabi <timur@codeaurora.org>
>> Tested-by: Robert Richter <rrichter@cavium.com>
>> Acked-by: Robert Richter <rrichter@cavium.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>
> Some nits below. Up to you if you fix incrementally or respin, but I'=
d like to
> see them fixed for consistency's sake.
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
>> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/s=
mp.h
>> index 780f82c..bf22650 100644
>> --- a/arch/arm64/include/asm/smp.h
>> +++ b/arch/arm64/include/asm/smp.h
>> @@ -39,9 +39,10 @@ extern void show_ipi_list(struct seq_file *p, int=
 prec);
>>   extern void handle_IPI(int ipinr, struct pt_regs *regs);
>>
>>   /*
>> - * Setup the set of possible CPUs (via set_cpu_possible)
>> + * Discover the set of possible CPUs and determine their
>> + * SMP operations.
>>    */
>> -extern void smp_init_cpus(void);
>> +extern void of_smp_init_cpus(void);
>
> This is inconsistent naming, we use dt some places, of elsewhere.

Do you mean dt_smp_init_cpus() here?

>
>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>> index bdcc9fc..0f35d87 100644
>> --- a/arch/arm64/kernel/acpi.c
>> +++ b/arch/arm64/kernel/acpi.c
>> @@ -25,6 +25,10 @@
>>   #include <linux/of_fdt.h>
>>   #include <linux/smp.h>
>>
>> +#include <asm/cputype.h>
>> +#include <asm/cpu_ops.h>
>> +#include <asm/smp_plat.h>
>> +
>>   int acpi_noirq =3D 1;		/* skip ACPI IRQ initialization */
>>   int acpi_disabled =3D 1;
>>   EXPORT_SYMBOL(acpi_disabled);
>> @@ -32,6 +36,12 @@ EXPORT_SYMBOL(acpi_disabled);
>>   int acpi_pci_disabled =3D 1;	/* skip ACPI PCI scan and IRQ initial=
ization */
>>   EXPORT_SYMBOL(acpi_pci_disabled);
>>
[...]
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 97fa7f3..b278311 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -393,13 +393,16 @@ void __init setup_arch(char **cmdline_p)
>>   	if (acpi_disabled) {
>>   		unflatten_device_tree();
>>   		psci_dt_init();
>> +		cpu_read_bootcpu_ops();
>> +#ifdef CONFIG_SMP
>> +		of_smp_init_cpus();
>> +#endif
>>   	} else {
>>   		psci_acpi_init();
>> +		acpi_init_cpus();
>>   	}
>>
>> -	cpu_read_bootcpu_ops();
>>   #ifdef CONFIG_SMP
>> -	smp_init_cpus();
>>   	smp_build_mpidr_hash();
>>   #endif
>
> I'd rather do without another ifdef above and provide a stub for that=
 function,
> but again it might make sense to just keep a small smp_init_cpus() ju=
st as with
> the psci setup.
>
> The cpu_read_bootcpu_ops() should be pushed down to the dt implementa=
tion to
> keep the paths more common between acpi and dt.

the declaration of of_smp_init_cpus() is in asm/smp.h, unfortunately
the way asm/smp.h is handled is generally a mess, it only be compiled
in SMP build:

#ifndef CONFIG_SMP
# error "<asm/smp.h> included in non-SMP build"
#endif

so I think we need more cleanup before provide a stub function.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
