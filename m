From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Fri, 27 Mar 2015 03:48:50 +0800
Message-ID: <551462A2.4070308@linaro.org>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org> <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org> <20150325171735.GI14585@localhost> <20150326151510.GI2805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150326151510.GI2805@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, "msalter@redhat.com" <msalter@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Sudeep Holla <Sudeep.Holl>
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B403=E6=9C=8826=E6=97=A5 23:15, Will Deacon wrote:
> On Wed, Mar 25, 2015 at 05:17:35PM +0000, Catalin Marinas wrote:
>> On Tue, Mar 24, 2015 at 10:02:45PM +0800, Hanjun Guo wrote:
>>> +/**
>>> + * acpi_map_gic_cpu_interface - generates a logical cpu number
>>> + * and map to MPIDR represented by GICC structure
>>> + * @mpidr: CPU's hardware id to register, MPIDR represented in MAD=
T
>>> + * @enabled: this cpu is enabled or not
>>> + *
>>> + * Returns the logical cpu number which maps to MPIDR
>>> + */
>>> +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled=
)
>>
>> So here we have an u8 enabled.
>>
>>> +static int __init
>>> +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>>> +				const unsigned long end)
>>> +{
>>> +	struct acpi_madt_generic_interrupt *processor;
>>> +
>>> +	processor =3D (struct acpi_madt_generic_interrupt *)header;
>>> +
>>> +	if (BAD_MADT_ENTRY(processor, end))
>>> +		return -EINVAL;
>>> +
>>> +	acpi_table_print_madt_entry(header);
>>> +
>>> +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITM=
ASK,
>>> +		processor->flags & ACPI_MADT_ENABLED);
>>
>> and here processor->flags is u32. Luckily, ACPI_MADT_ENABLED is 1 an=
d we
>> don't lose any information. So either make the enabled above a bool =
or
>> simply pass the flags with the check in acpi_map_gic_cpu_interface()
>> (personal preference for the latter).
>
> I've applied the following patch on top of the series.
>
> Will
>
> --->8
>
> commit 8ef320319592693f4a6286d80df210fd47b3e356
> Author: Will Deacon <will.deacon@arm.com>
> Date:   Thu Mar 26 15:09:20 2015 +0000
>
>      ARM64 / ACPI: fix usage of acpi_map_gic_cpu_interface
>
>      acpi_parse_gic_cpu_interface calls acpi_map_gic_cpu_interface by=
 both
>      passing a 32-bit value in the u8 enabled parameter and then subs=
equently
>      ignoring its return value.
>
>      Sort it out.
>
>      Reported-by: Catalin Marinas <catalin.marinas@arm.com>
>      Signed-off-by: Will Deacon <will.deacon@arm.com>
>
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index cd60329da8c4..07649e413244 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -103,9 +103,12 @@ void __init __acpi_unmap_table(char *map, unsign=
ed long size)
>    *
>    * Returns the logical cpu number which maps to MPIDR
>    */
> -static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
> +static int __init
> +acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *proce=
ssor)

How about just replace u8 with u32? This function has its purpose to
be lived, on x86/ia64, ACPI core will get the physcal cpu ID via
ACPI handle, then pass it to the arch specific mapping function
to map the physcal cpu ID with logical cpu ID for the new added
CPU, so when ACPI based CPU hot-plug is introduced on ARM64, we
need to go back to that solution.

>   {
>   	int i;
> +	u64 mpidr =3D processor->arm_mpidr & MPIDR_HWID_BITMASK;
> +	bool enabled =3D !!(processor->flags & ACPI_MADT_ENABLED);
>
>   	if (mpidr =3D=3D INVALID_HWID) {
>   		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
> @@ -178,11 +181,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtabl=
e_header *header,
>   		return -EINVAL;
>
>   	acpi_table_print_madt_entry(header);
> -
> -	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMAS=
K,
> -		processor->flags & ACPI_MADT_ENABLED);
> -
> -	return 0;
> +	return acpi_map_gic_cpu_interface(processor);

I don't think we need to return the error value here, in ACPI
core, it will stop the MADT scanning once it returned the error
value, but actually we can skip some disabled GICC (cpu) entries
and find all the enabled ones in MADT, for example,

cpu0 entry, with flag enabled
cpu1 entry, disabled  - if we return the error value, table scanning
                         will stop
cpu2 entry, enabled   - and this cpu will be ignored

Thanks
Hanjun
