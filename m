From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 10/20] ARM64 / ACPI: Enumerate possible/present CPU set
 and map logical cpu id to APIC id
Date: Sat, 25 Jan 2014 00:02:28 +0800
Message-ID: <52E28E94.2020403@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-11-git-send-email-hanjun.guo@linaro.org> <20140122155331.GD24288@e102568-lin.cambridge.arm.com> <52E27AA8.8040105@linaro.org> <20140124153557.GB23274@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140124153557.GB23274@e102568-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Charles Garcia-Tobin <Charles>
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B401=E6=9C=8824=E6=97=A5 23:35, Lorenzo Pieralisi wrote:
> On Fri, Jan 24, 2014 at 02:37:28PM +0000, Hanjun Guo wrote:
>> Hi Lorenzo,
>>
>> On 2014?01?22? 23:53, Lorenzo Pieralisi wrote:
>>> On Fri, Jan 17, 2014 at 12:25:04PM +0000, Hanjun Guo wrote:
>>>
>>> [...]
>>>
>>>> +/* map logic cpu id to physical GIC id */
>>>> +extern int arm_cpu_to_apicid[NR_CPUS];
>>>> +#define cpu_physical_id(cpu) arm_cpu_to_apicid[cpu]
>>> Sudeep already commented on this, please update it accordingly.
>> Actually after some careful review of the ACPI code, I can't
>> update it as MPIDR here.
>>
>> MPIDR can be the ACPI uid and NOT the GIC id, the mapping
>> of them are something like this in ACPI driver now:
>>
>> logic cpu id <---> APIC Id (GIC ID) <---> ACPI uid (MPIDR on ARM)
>> but not logic cpu id <---> ACPI uid directly, you can refer to
>> the code of processor_core.c
>>
>> So here I can only map GIC id to logical cpu id.
> On ARM platforms GIC CPU IF id is probeable, you do not need to parse
> it (ie it is not information that you will find in DT). Please have a=
 look
> at drivers/irqchip/irq-gic.c.
>
> We have to understand what's really required and when in ACPI, or to =
put it
> differently, why cpu_physical_id(cpu) is required and at what time at
> boot, I will have a look on my side too.

Me too :)

>
>>>> +
>>>>    #else	/* !CONFIG_ACPI */
>>>>    #define acpi_disabled 1		/* ACPI sometimes enabled on ARM */
>>>>    #define acpi_noirq 1		/* ACPI sometimes enabled on ARM */
>>>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-=
core.c
>>>> index 8ba3e6f..1d9b789 100644
>>>> --- a/drivers/acpi/plat/arm-core.c
>>>> +++ b/drivers/acpi/plat/arm-core.c
>>>> @@ -31,6 +31,7 @@
>>>>    #include <linux/smp.h>
>>>>   =20
>>>>    #include <asm/pgtable.h>
>>>> +#include <asm/cputype.h>
>>>>   =20
>>>>    /*
>>>>     * We never plan to use RSDT on arm/arm64 as its deprecated in =
spec but this
>>>> @@ -52,6 +53,13 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>>>>     */
>>>>    static u64 acpi_lapic_addr __initdata;
>>> Is this variable actually needed ?
>> Yes, needed for GIC initialization.
>>
>>>>   =20
>>>> +/* available_cpus here means enabled cpu in MADT */
>>>> +static int available_cpus;
>>> Ditto.
>>>
>>>> +
>>>> +/* Map logic cpu id to physical GIC id (physical CPU id). */
>>>> +int arm_cpu_to_apicid[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D -1 };
>>>> +static int boot_cpu_apic_id =3D -1;
>>> Do we need all these variables ? I think we should reuse cpu_logica=
l_map
>>> data structures for that, it looks suspiciously familiar.
>> MPIDR is the different part. if we use MPIDR as GIC id, i think
>> we can reuse cpu_logical_map, but Sudeep suggested not
>> use MPIDR as GIC id.
> It is not about *reusing* cpu_logical_map, it is about setting it up
> properly. cpu_logical_map must be initialized by ACPI for the spin ta=
ble
> method to work properly (and PSCI too).
>
> And yes, cpu_physical_id(cpu) is expected to be the GIC CPU IF id on
> ARM, at least it looks like, I had a look too. But this does not chan=
ge
> anything as far as cpu_logical_map is concerned, it must contain a li=
st
> of MPIDRs in the system and must be retrieved via ACPI, not DT CPU no=
des
> when ACPI is used for booting.
>
> I will have a further look, since this discrepancy is annoying.

Thank you for doing this, I will look that too.

>
> [...]
>
>>>> +
>>>> +	available_cpus++;
>>>> +
>>> Is available_cpus !=3D num_possible_cpus() ? It does not look like =
hence
>>> available_cpus can go.
>> No, possible cpus include available cpus and disabled cpus
>> this is useful for ACPI based CPU hot-plug features.
>>
>>>> +	/* allocate a logic cpu id for the new comer */
>>>> +	if (boot_cpu_apic_id =3D=3D id) {
>>>> +		/*
>>>> +		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
>>>> +		 * for BSP, no need to allocte again.
>>>> +		 */
>>>> +		cpu =3D 0;
>>>> +	} else {
>>>> +		cpu =3D cpumask_next_zero(-1, cpu_present_mask);
>>>> +	}
>>>> +
>>>> +	/* map the logic cpu id to APIC id */
>>>> +	arm_cpu_to_apicid[cpu] =3D id;
>>>> +
>>>> +	set_cpu_present(cpu, true);
>>>> +	set_cpu_possible(cpu, true);
>>> This is getting nasty. Before adding this patch and previous ones w=
e
>>> need to put in place a method for the kernel to make a definite cho=
ice between
>>> ACPI and DT and stick to that. We can't initialize the logical map =
twice
>>> (which will happen if your DT has valid cpu nodes and a chosen node=
 pointing
>>> to proper ACPI tables) or even having some entries initialized from=
 DT and
>>> others by ACPI. It is a big fat no-no, please update the series acc=
ordingly.
>> really good catch here :)
>> so the problem here is that should we use both ACPI and DT in one sy=
stem?

I think Mark had a clear answer about this :) (Answer for my self)

>>
>>
>>>> +
>>>> +	return cpu;
>>>> +}
>>>> +
>>>>    static int __init
>>>>    acpi_parse_gic(struct acpi_subtable_header *header, const unsig=
ned long end)
>>>>    {
>>>> @@ -144,6 +201,16 @@ acpi_parse_gic(struct acpi_subtable_header *h=
eader, const unsigned long end)
>>>>   =20
>>>>    	acpi_table_print_madt_entry(header);
>>>>   =20
>>>> +	/*
>>>> +	 * We need to register disabled CPU as well to permit
>>>> +	 * counting disabled CPUs. This allows us to size
>>>> +	 * cpus_possible_map more accurately, to permit
>>>> +	 * to not preallocating memory for all NR_CPUS
>>>> +	 * when we use CPU hotplug.
>>>> +	 */
>>>> +	acpi_register_gic_cpu_interface(processor->gic_id,
>>>> +			processor->flags & ACPI_MADT_ENABLED);
>>>> +
>>>>    	return 0;
>>>>    }
>>>>   =20
>>>> @@ -186,6 +253,19 @@ static int __init acpi_parse_madt_gic_entries=
(void)
>>>>    		return count;
>>>>    	}
>>>>   =20
>>>> +#ifdef CONFIG_SMP
>>>> +	if (available_cpus =3D=3D 0) {
>>>> +		pr_info(PREFIX "Found 0 CPUs; assuming 1\n");
>>>> +		arm_cpu_to_apicid[available_cpus] =3D
>>>> +			read_cpuid_mpidr() & MPIDR_HWID_BITMASK;
>>>> +		available_cpus =3D 1;	/* We've got at least one of these */
>>>> +	}
>>> I'd rather check the MADT for at least the boot cpu to present, if =
it is
>>> not ACPI tables are horribly buggy and the kernel should barf on th=
at.
>>>
>>>> +#endif
>>>> +
>>>> +	/* Make boot-up look pretty */
>>>> +	pr_info("%d CPUs available, %d CPUs total\n", available_cpus,
>>>> +		total_cpus);
>>> Ok, now, how can we use the "disabled" CPUs =3D=3D (total_cpus - av=
ailable_cpus) ?
>> For cpus can be hot-added later when system is running.
> I do not see any usage in the patchset and certainly those variables =
are
> not used in this patch, apart from printing messages whose usefulness=
 is
> debatable. If, as you say, you are using those variables for somethin=
g
> else, please add code in the patch where they are introduced for it t=
o be
> self-contained and to simplify the review.

ah, yes. although my ACPI based CPU hot-plug patch is ready, but need
this patch set goes in first and then send them out.

I agree with you, will try to update this patch.

Thanks
Hanjun
