From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part2 PATCH 2/9] ARM64 / ACPI: Prefill cpu possible/present
 maps and map logical cpu id to APIC id
Date: Wed, 04 Dec 2013 22:21:11 +0800
Message-ID: <529F3A57.7010306@linaro.org>
References: <1386088753-2850-1-git-send-email-hanjun.guo@linaro.org> <1386088753-2850-3-git-send-email-hanjun.guo@linaro.org> <20131203165755.37b07796@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:45855 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab3LDOVb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 09:21:31 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so23375137pbc.26
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 06:21:31 -0800 (PST)
In-Reply-To: <20131203165755.37b07796@alan.etchedpixels.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 00:57, One Thousand Gnomes wrote=
:
>> diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-co=
re.c
>> index 45ff625..8527ecc 100644
>> --- a/drivers/acpi/plat/arm-core.c
>> +++ b/drivers/acpi/plat/arm-core.c
>> @@ -58,6 +58,13 @@ EXPORT_SYMBOL(acpi_pci_disabled);
>>    */
>>   static u64 acpi_lapic_addr __initdata;
>>  =20
>> +/* available_cpus here means enabled cpu in MADT */
>> +int available_cpus;
>> +
>> +/* Map logic cpu id to physical GIC id. */
>> +int arm_cpu_to_apicid[NR_CPUS] =3D { [0 ... NR_CPUS-1] =3D -1 };
>> +int boot_cpu_apic_id =3D -1;
>> +
> static ?
>
> Really shouldn't be leaking names like "available_cpus" out of ACPI i=
nto
> the global namespace

Ok, will update in next version.


>> +#ifdef CONFIG_SMP
>> +	if (available_cpus =3D=3D 0) {
>> +		pr_info(PREFIX "Found 0 CPUs; assuming 1\n");
>> +		/* FIXME: should be the real GIC id read from hardware */
>> +		arm_cpu_to_apicid[available_cpus] =3D 0;
>> +		available_cpus =3D 1;	/* We've got at least one of these */
>> +	}
>> +#endif
> Isn't this true uniprocessor (by definition in fact)

This code is intend to handle some buggy firmware I think.


>> + */
>> +void __init prefill_possible_map(void)
> leaking more unprefixed names into the global namespace

prefill_possible_map() will be called in setup_arch() in setup.c,
and should be gloabl, is this incorrect?
Look forward to your advice

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
