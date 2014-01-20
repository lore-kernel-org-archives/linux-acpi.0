From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 06/20] ARM64 / ACPI: Introduce some PCI functions when
 PCI is enabled
Date: Mon, 20 Jan 2014 22:13:55 +0800
Message-ID: <52DD2F23.2010109@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <201401171504.24525.arnd@arndb.de> <52DCD961.70303@linaro.org> <4387274.ri38HmFxAV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4387274.ri38HmFxAV@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rob Herring <robh@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, patches@linaro.org, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B401=E6=9C=8820=E6=97=A5 16:20, Arnd Bergmann wrote:
> On Monday 20 January 2014 16:08:01 Hanjun Guo wrote:
>>>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-=
core.c
>>>> index 3c8521d..1835b21 100644
>>>> --- a/drivers/acpi/plat/arm-core.c
>>>> +++ b/drivers/acpi/plat/arm-core.c
>>>> @@ -100,6 +100,25 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *ir=
q)
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>>>>  =20
>>>> +int acpi_isa_irq_to_gsi(unsigned isa_irq, u32 *gsi)
>>>> +{
>>>> +    return -1;
>>>> +}
>>>> +
>>>> +int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 g=
si_base)
>>>> +{
>>>> +    /* TBD */
>>>> +    return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL(acpi_register_ioapic);
>>>> +
>>>> +int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
>>>> +{
>>>> +    /* TBD */
>>>> +    return -EINVAL;
>>>> +}
>>>> +EXPORT_SYMBOL(acpi_unregister_ioapic);
>>>> +
>>> My feeling is that these are better handled in the ACPI code by not
>>> calling them on architectures that have no ISA or no IOAPIC support=
=2E
>>>
>>> We have configuration symbols for both, so you don't have to make
>>> it depend on CONFIG_ARM64 or CONFIG_X86.
>> Do you mean introduce a stub function when there is no ISA support?
> Do you anticipate ISA devices on ARM64? I hope not ;-)

me too :)

>
> My guess is that whatever code calls this function should be disabled
> in reduced hw mode.

ok, that would be make sense, will update it in next version.

>
>> acpi_register_ioapic()/acpi_unregister_ioapic() will be used for IOA=
PIC
>> hotplug and GIC distributor is something like IOAPIC on x86, so I th=
ink
>> these two functions can be reserved for future use.
> But GIC is not hotplugged, is it? It still sounds x86 specific to me.

Well, if we want to do physical CPU hotplug on ARM/ARM64 (maybe years=20
later?),
then GIC add/remove is needed because we have to remove GIC
on the SoC too when we remove the physical CPU.

Thanks
Hanjun
