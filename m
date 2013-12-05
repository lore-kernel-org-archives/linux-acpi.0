From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [RFC part3 PATCH 1/2] clocksource / arch_timer: Use ACPI GTDT
 table to initialize arch timer
Date: Thu, 05 Dec 2013 21:26:44 +0800
Message-ID: <52A07F14.4020600@linaro.org>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org> <1386069328-22502-2-git-send-email-hanjun.guo@linaro.org> <CAL_JsqJYUasvVDZjkuFwEiMxWhXNEzhhSP2ni1KKDeQQjmnzjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJYUasvVDZjkuFwEiMxWhXNEzhhSP2ni1KKDeQQjmnzjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, linux-acpi@vger.kernel.org, Linaro Patches <patches@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, linaro-acpi@lists.linaro.org, Olof Johansson <olof@lixom.net>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Grant Likely <grant.likely@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B412=E6=9C=8804=E6=97=A5 23:33, Rob Herring wrote:
> On Tue, Dec 3, 2013 at 5:15 AM, Hanjun Guo <hanjun.guo@linaro.org> wr=
ote:
[...]
>> +#ifdef CONFIG_ACPI
>> +void __init arch_timer_acpi_init(void)
>> +{
>> +       struct acpi_table_gtdt *gtdt;
>> +       acpi_size tbl_size;
>> +       int trigger, polarity;
>> +       void __iomem *base =3D NULL;
>> +
>> +       if (acpi_disabled)
> Wouldn't the core ACPI code never call this function if ACPI is disab=
led?

You inspired me for patches to remove some redundant if (acpi_disabled)
check for the current ACPI code, but this function will be called even
ACPI is disabled.

>> +               return;
>> +
>> +       if (arch_timers_present & ARCH_CP15_TIMER) {
>> +               pr_warn("arch_timer: already initialized, skipping\n=
");
>> +               return;
>> +       }
>> +
>> +       if (ACPI_FAILURE(acpi_get_table_with_size(ACPI_SIG_GTDT, 0,
>> +                       (struct acpi_table_header **)&gtdt, &tbl_siz=
e))) {
>> +               pr_err("arch_timer: GTDT table not defined\n");
>> +               return;
>> +       }
>> +
>> +       arch_timers_present |=3D ARCH_CP15_TIMER;
> So you have marked the timer as initialized, but then may fail on
> error later on here.
>
>> +
>> +       /*
>> +        * Get the timer frequency. Since there is no frequency info
>> +        * in the GTDT table, so we should read it from CNTFREG regi=
ster
>> +        * or hard code here to wait for the new ACPI spec available=
=2E
>> +        */
>> +       if (!gtdt->address) {
>> +               arch_timer_rate =3D arch_timer_get_cntfrq();
>> +       } else {
>> +               base =3D ioremap(gtdt->address, CNTFRQ);
>> +               if (!base) {
>> +                       pr_warn("arch_timer: unable to map arch time=
r base address\n");
>> +                       return;
>> +               }
>> +
>> +               arch_timer_rate =3D readl_relaxed(base + CNTFRQ);
>> +               iounmap(base);
> This is for memory mapped timer? If so, then isn't setting
> ARCH_CP15_TIMER the wrong thing to do?

I'm trying to do that but it is wrong as you said, I will remove above =
code
and only keep

arch_timer_rate =3D arch_timer_get_cntfrq() here.

>> +       }
>> +
>> +       if (!arch_timer_rate) {
>> +               /* Hard code here to set frequence ? */
>> +               pr_warn("arch_timer: Could not get frequency from GT=
DT table or CNTFREG\n");
>> +       }
>> +
>> +       if (gtdt->secure_pl1_interrupt) {
> Really, I think the kernel should just ignore the secure interrupt.
> The DT code has the same issue, but that doesn't affect the code size=
=2E
>
>> +               trigger =3D (gtdt->secure_pl1_flags & ACPI_GTDT_INTE=
RRUPT_MODE) ?
>> +                       ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
> Why not use the already defined linux irq trigger types here and make
> acpi_register_gsi use them?
>
>> +               polarity =3D
>> +                       (gtdt->secure_pl1_flags & ACPI_GTDT_INTERRUP=
T_POLARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[0] =3D acpi_register_gsi(NULL,
>> +                               gtdt->secure_pl1_interrupt, trigger,=
 polarity);
>> +       }
>> +       if (gtdt->non_secure_pl1_interrupt) {
>> +               trigger =3D
>> +                       (gtdt->non_secure_pl1_flags & ACPI_GTDT_INTE=
RRUPT_MODE)
>> +                       ? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE=
;
>> +               polarity =3D
>> +               (gtdt->non_secure_pl1_flags & ACPI_GTDT_INTERRUPT_PO=
LARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[1] =3D acpi_register_gsi(NULL,
>> +                       gtdt->non_secure_pl1_interrupt, trigger, pol=
arity);
>> +       }
>> +       if (gtdt->virtual_timer_interrupt) {
>> +               trigger =3D (gtdt->virtual_timer_flags & ACPI_GTDT_I=
NTERRUPT_MODE)
>> +                       ? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE=
;
>> +               polarity =3D
>> +               (gtdt->virtual_timer_flags & ACPI_GTDT_INTERRUPT_POL=
ARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[2] =3D acpi_register_gsi(NULL,
>> +                       gtdt->virtual_timer_interrupt, trigger, pola=
rity);
>> +       }
>> +       if (gtdt->non_secure_pl2_interrupt) {
>> +               trigger =3D
>> +                       (gtdt->non_secure_pl2_flags & ACPI_GTDT_INTE=
RRUPT_MODE)
>> +                       ? ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE=
;
>> +               polarity =3D
>> +               (gtdt->non_secure_pl2_flags & ACPI_GTDT_INTERRUPT_PO=
LARITY)
>> +                       ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>> +               arch_timer_ppi[3] =3D acpi_register_gsi(NULL,
>> +                       gtdt->non_secure_pl2_interrupt, trigger, pol=
arity);
>> +       }
>> +
>> +       early_acpi_os_unmap_memory(gtdt, tbl_size);
> Who did the mapping? acpi_get_table_with_size? I think the core code
> should handle the mapping and unmapping of ACPI tables. We don't want
> to have to duplicate this in every initialization function. This seem=
s
> error prone.

Yes, you are right, I will use the ACPI core function acpi_table_parse(=
)
to fix it, thanks for you guidance.

Hanjun
