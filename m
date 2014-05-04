From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 part1 01/11] ACPI / processor: Rework _PDC related
 stuff to make it more arch-independent
Date: Sun, 04 May 2014 16:56:28 +0800
Message-ID: <536600BC.3060205@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>	<1398432017-8506-2-git-send-email-hanjun.guo@linaro.org> <20140429093637.75573C4095B@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20140429093637.75573C4095B@trevor.secretlab.ca>
Sender: linux-ia64-owner@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-ia64@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Hi Grant,

On 2014-4-29 17:36, Grant Likely wrote:
> On Fri, 25 Apr 2014 21:20:07 +0800, Hanjun Guo <hanjun.guo@linaro.org=
> wrote:
>> _PDC related stuff in processor_core.c is little bit X86/IA64
>> dependent, macros of ACPI_PDC_* are _PDC bit definitions for
>> Intel processors, if we use these macros in processor_core.c,
>> we will meet compile error when ACPI is enabled on ARM64.
>>
>> This patch reworks the code to make it more arch-independent,
>> moving Intel related _PDC bits into architecture directory,
>> no functional change.
>>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: linux-ia64@vger.kernel.org
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> ---
>>  arch/ia64/include/asm/acpi.h  |    5 +----
>>  arch/ia64/kernel/acpi.c       |   15 +++++++++++++++
>>  arch/x86/include/asm/acpi.h   |   19 +------------------
>>  arch/x86/kernel/acpi/cstate.c |   27 +++++++++++++++++++++++++++
>>  drivers/acpi/processor_core.c |   19 +------------------
>>  5 files changed, 45 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/ia64/include/asm/acpi.h b/arch/ia64/include/asm/ac=
pi.h
>> index d651102..d2b8b9d 100644
>> --- a/arch/ia64/include/asm/acpi.h
>> +++ b/arch/ia64/include/asm/acpi.h
>> @@ -152,10 +152,7 @@ extern int __initdata nid_to_pxm_map[MAX_NUMNOD=
ES];
>>  #endif
>> =20
>>  static inline bool arch_has_acpi_pdc(void) { return true; }
>> -static inline void arch_acpi_set_pdc_bits(u32 *buf)
>> -{
>> -	buf[2] |=3D ACPI_PDC_EST_CAPABILITY_SMP;
>> -}
>> +extern void arch_acpi_set_pdc_bits(u32 *buf);
>> =20
>>  #define acpi_unlazy_tlb(x)
>> =20
>> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
>> index 0d407b3..23e9b40 100644
>> --- a/arch/ia64/kernel/acpi.c
>> +++ b/arch/ia64/kernel/acpi.c
>> @@ -996,3 +996,18 @@ EXPORT_SYMBOL(acpi_unregister_ioapic);
>>   * TBD when when IA64 starts to support suspend...
>>   */
>>  int acpi_suspend_lowlevel(void) { return 0; }
>> +
>> +void arch_acpi_set_pdc_bits(u32 *buf)
>> +{
>> +	/* Enable coordination with firmware's _TSD info */
>> +	buf[2] |=3D ACPI_PDC_SMP_T_SWCOORD | ACPI_PDC_EST_CAPABILITY_SMP;
>> +
>> +	if (boot_option_idle_override =3D=3D IDLE_NOMWAIT) {
>> +		/*
>> +		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
>> +		 * mode will be disabled in the parameter of _PDC object.
>> +		 * Of course C1_FFH access mode will also be disabled.
>> +		 */
>> +		buf[2] &=3D ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
>> +	}
>> +}
>=20
> The commit text makes no comment about why this function is being mov=
ed
> from a static inline to an extern in the acpi.c file. I assume it is
> because it needs access to the boot_option_idle_override global
> variable, but it isn't immediately obvious, and should be described i=
n
> the commit text.

Ok, we will update the commit text as you suggested.

>=20
> Otherwise, the patch looks sane.
>=20
> Reviewed-by: Grant Likely <grant.likely@linaro.org>

Thanks=EF=BC=81

Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
