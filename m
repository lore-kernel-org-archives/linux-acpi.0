From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
Date: Wed, 04 Dec 2013 22:25:16 +0800
Message-ID: <529F3B4C.1080400@linaro.org>
References: <1386088891-2917-1-git-send-email-hanjun.guo@linaro.org> <1386088891-2917-2-git-send-email-hanjun.guo@linaro.org> <20131203170407.GA16025@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:41144 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab3LDOZc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 09:25:32 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so22421758pdj.39
        for <linux-acpi@vger.kernel.org>; Wed, 04 Dec 2013 06:25:31 -0800 (PST)
In-Reply-To: <20131203170407.GA16025@e106331-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Jon Masters <jonathan@jonmasters.org>, "patches@linaro.org" <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro>

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 01:04, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 04:41:30PM +0000, Hanjun Guo wrote:
>> ACPI GTDT (Generic Timer Description Table) contains information for
>> arch timer initialization, this patch use this table to probe arm ti=
mer.
>>
>> GTDT table is used for ARM/ARM64 only, please refer to chapter 5.2.2=
4
>> of ACPI 5.0 spec for detailed inforamtion
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>   drivers/clocksource/arm_arch_timer.c |  129 ++++++++++++++++++++++=
++++++++----
>>   include/clocksource/arm_arch_timer.h |    7 +-
>>   2 files changed, 120 insertions(+), 16 deletions(-)
>  =20
> [...]
>
>> +#ifdef CONFIG_ACPI
>> +void __init arch_timer_acpi_init(void)
>> +{
>> +	struct acpi_table_gtdt *gtdt;
>> +	acpi_size tbl_size;
>> +	int trigger, polarity;
>> +	void __iomem *base =3D NULL;
>> +
>> +	if (acpi_disabled)
>> +		return;
>> +
>> +	if (arch_timers_present & ARCH_CP15_TIMER) {
>> +		pr_warn("arch_timer: already initialized, skipping\n");
>> +		return;
>> +	}
>> +
>> +	if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_GTDT, 0,
>> +			(struct acpi_table_header **)&gtdt, &tbl_size))) {
>> +		pr_err("arch_timer: GTDT table not defined\n");
>> +		return;
>> +	}
>> +
>> +	arch_timers_present |=3D ARCH_CP15_TIMER;
>> +
>> +	/*
>> +	 * Get the timer frequency. Since there is no frequency info
>> +	 * in the GTDT table, so we should read it from CNTFREG register
>> +	 * or hard code here to wait for the new ACPI spec available.
>> +	 */
> If the core's CNTFRQ register does not hold the correct value, that i=
s a
> horrendous firmware bug. The clock-frequency property in the DT is a
> horrific workaround for buggy firmware.
>
> We should not duplicate it in ACPI; people should be strongly encoura=
ged
> to fix their firmware to do what it is supposed to do.
>
> Rely on CNTFRQ only. If it is wrong, then bail out. Let's not create =
a
> fertile environment for buggy firmware.

Great, this can make things much simple, and the information which cont=
ains
in ACPI GTDT table can be sufficient for timer initialization.


>> +	if (!gtdt->address) {
>> +		arch_timer_rate =3D arch_timer_get_cntfrq();
>> +	} else {
>> +		base =3D ioremap(gtdt->address, CNTFRQ);
>> +		if (!base) {
>> +			pr_warn("arch_timer: unable to map arch timer base address\n");
>> +			return;
>> +		}
>> +
>> +		arch_timer_rate =3D readl_relaxed(base + CNTFRQ);
>> +		iounmap(base);
>> +	}
>> +
>> +	if (!arch_timer_rate) {
>> +		/* Hard code here to set frequence ? */
>> +		pr_warn("arch_timer: Could not get frequency from GTDT table or C=
NTFREG\n");
>> +	}
>> +
>> +	if (gtdt->secure_pl1_interrupt) {
>> +		trigger =3D (gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUPT_MODE) ?
>> +			ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =3D
>> +			(gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[0] =3D acpi_register_gsi(NULL,
>> +				gtdt->secure_pl1_interrupt, trigger, polarity);
>> +	}
> This pattern looks like it can be factored out. I don't see why the
> driver needs to have such intimate knowledge of the interrrupt.
>
>> +	if (gtdt->non_secure_pl1_interrupt) {
>> +		trigger =3D
>> +			(gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +			? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =3D
>> +		(gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[1] =3D acpi_register_gsi(NULL,
>> +			gtdt->non_secure_pl1_interrupt, trigger, polarity);
>> +	}
>> +	if (gtdt->virtual_timer_interrupt) {
>> +		trigger =3D (gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_MODE=
)
>> +			? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =3D
>> +		(gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[2] =3D acpi_register_gsi(NULL,
>> +			gtdt->virtual_timer_interrupt, trigger, polarity);
>> +	}
>> +	if (gtdt->non_secure_pl2_interrupt) {
>> +		trigger =3D
>> +			(gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_MODE)
>> +			? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
>> +		polarity =3D
>> +		(gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_POLARITY)
>> +			? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +		arch_timer_ppi[3] =3D acpi_register_gsi(NULL,
>> +			gtdt->non_secure_pl2_interrupt, trigger, polarity);
>> +	}
> Please factor out the interrupt parsing.

Ok, will try to factor it out in next version.

Thanks for the comments.

Hanjun



--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
