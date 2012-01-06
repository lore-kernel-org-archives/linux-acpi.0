From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] pnpacpi: Call acpi_register_gsi for possible resources too
Date: Thu, 5 Jan 2012 17:10:35 -0700
Message-ID: <CAErSpo5A=jBa7Le3wwf+k+q3vrfBBDS3UK1R6F2QQ5C2-BoOXg@mail.gmail.com>
References: <20120103080715.GA26099@petr-dev3.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38838 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932235Ab2AFAK7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 5 Jan 2012 19:10:59 -0500
Received: by lahd3 with SMTP id d3so348258lah.19
        for <linux-acpi@vger.kernel.org>; Thu, 05 Jan 2012 16:10:57 -0800 (PST)
In-Reply-To: <20120103080715.GA26099@petr-dev3.eng.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Petr Vandrovec <petr@vmware.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, Jan 3, 2012 at 1:07 AM, Petr Vandrovec <petr@vmware.com> wrote:
> ...
> There are two more problems I've discovered during testing:
>
> 1. I had to restrict I/O base to 0x500-0xBF8 (from original
> 0x100-0xFFFF), as otherwise kernel happilly enables one of serial por=
ts
> at 0x170, although IDE already occupied that port - it seems that res=
ources
> occupied by IDE are reported only after libata loads, and as libata l=
oads
> after serial port driver, pnpacpi does not seem to notice that 0x170 =
is
> in use, rather than available for allocation, enables device there,
> and then system gets very confused.

I think this is a consequence of the fact that the PNP & ACPI cores
don't reserve resources used by devices.  The only reservation happens
when a driver claims the device.  If a driver is loaded late or not at
all, problems like this can occur.  This is different from PCI, where
the core *does* reserve device resources independent of drivers.  I
think this is a PNP/ACPI bug, but it's not completely trivial to fix.

> 2. pnpacpi lacks support for both hot-add and hot-remove. =A0So seria=
l
> ports cannot be neither added nor removed while system runs. =A0I gue=
ss
> that's the next task.

Right.  I'd be thrilled if you fixed this :)

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0Thanks,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0Petr Vandrovec
>
>
>
> From: Petr Vandrovec <petr@vmware.com>
>
> Convert interrupt numbers from GSI to IRQ for _PRS
>
> pnpacpi calls acpi_register_gsi only when interrupt resource is read
> via _CRS method - either when device is discovered (if it was already
> enabled when pnpacpi initializes), or when someone calls 'get' method
> on the device. =A0What is missing from this list is invoking acpi_reg=
ister_gsi
> when someone issues _SRS method to enable device.

That's exactly the problem.

>=A0And if nobody
> issues acpi_register_gsi, then device may not work if it is only devi=
ce
> using GSI selected by the kernel.
>
> As whole kernel thinks in terms of IRQs, rather than GSIs, it seems t=
hat
> correct place where to call acpi_register_gsi is when possible resour=
ces
> are retrieved from _PRS, rather than just before _SRS invocation, so
> that is what I did.

I don't think this is the correct solution though.
acpi_register_gsi() programs IOAPIC entries, and we should only do
that for an IRQ that we're actually *using*, not one that is merely a
possible choice.

Maybe somewhere in the _SRS path would work.  Currently, I think Linux
only calls _SRS when it *changes* something, but the ACPI spec (v4.0a,
sec 6.2) has a hint that maybe we should *always* call it before using
a device:

    When OSPM enumerates a device, it calls _PRS to determine the resou=
rce
    requirements of the device. It may also call _CRS to find the
current resource
    settings for the device. Using this information, the Plug and Play =
system
    determines what resources the device should consume and sets those
    resources by calling the device=92s _SRS control method.

It'd be cool if we could figure out whether Windows does that.  Maybe
somebody with good virtualization and ACPI expertise :)

There's also a bunch of ugliness around the fact that we never
*unregister* GSIs for PNP devices, so I expect some things are broken
there, too.

Bjorn

> I've enabled checking to make sure we are not selecting mismatching
> level/edge configuration (with dev_warn, same way _CRS warns). =A0But=
 it
> may be too noisy, as on almost all systems I could check we get warni=
ngs
> that IRQ 9 is used by ACPI as level/low, while resource descriptors
> list it as edge/high (together with other IRQs in 3-15 range).
>
> Signed-off-by: Petr Vandrovec <petr@vmware.com>
>
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsp=
arser.c
> index 5be4a39..3243bf4 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -518,6 +518,47 @@ static __init void pnpacpi_parse_dma_option(stru=
ct pnp_dev *dev,
> =A0 =A0 =A0 =A0pnp_register_dma_resource(dev, option_flags, map, flag=
s);
> =A0}
>
> +static __init void pnpacpi_gsi_option_to_irq(struct pnp_dev *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0pnp_irq_mask_t *map,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0u32 gsi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int triggering,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int polarity)
> +{
> + =A0 =A0 =A0 int p, t;
> + =A0 =A0 =A0 int irq;
> +
> + =A0 =A0 =A0 /* GSI 0 is ignored. */
> + =A0 =A0 =A0 if (!gsi)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In IO-APIC mode, accept interrupt only if its trig=
ger/polarity
> + =A0 =A0 =A0 =A0* matches with one already selected.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!acpi_get_override_irq(gsi, &t, &p)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 t =3D t ? ACPI_LEVEL_SENSITIVE : ACPI_E=
DGE_SENSITIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE=
_HIGH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (triggering !=3D t || polarity !=3D =
p) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&dev->dev, "IR=
Q %d status %s, %s does not match override %s, %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gsi,=
 triggering ? "edge" : "level",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pola=
rity ? "low" : "high",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t ? =
"edge":"level", p ? "low":"high");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 irq =3D acpi_register_gsi(&dev->dev, gsi, triggering, p=
olarity);
> + =A0 =A0 =A0 if (irq < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "ignoring IRQ %d opt=
ion "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"(cannot be mapped to platform IRQ)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
gsi);
> + =A0 =A0 =A0 else if (irq < PNP_IRQ_NR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(irq, map->bits);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "ignoring IRQ %d (GS=
I %d) option "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"(too large for %d entry bitmap)\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
irq, gsi, PNP_IRQ_NR);
> +}
> +
> =A0static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0unsigned int option_flags,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0struct acpi_resource_irq *p)
> @@ -528,8 +569,8 @@ static __init void pnpacpi_parse_irq_option(struc=
t pnp_dev *dev,
>
> =A0 =A0 =A0 =A0bitmap_zero(map.bits, PNP_IRQ_NR);
> =A0 =A0 =A0 =A0for (i =3D 0; i < p->interrupt_count; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->interrupts[i])
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(p->interrupts=
[i], map.bits);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pnpacpi_gsi_option_to_irq(dev, &map, p-=
>interrupts[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 p->triggering, p->polarity);
>
> =A0 =A0 =A0 =A0flags =3D irq_flags(p->triggering, p->polarity, p->sha=
rable);
> =A0 =A0 =A0 =A0pnp_register_irq_resource(dev, option_flags, &map, fla=
gs);
> @@ -544,16 +585,9 @@ static __init void pnpacpi_parse_ext_irq_option(=
struct pnp_dev *dev,
> =A0 =A0 =A0 =A0unsigned char flags;
>
> =A0 =A0 =A0 =A0bitmap_zero(map.bits, PNP_IRQ_NR);
> - =A0 =A0 =A0 for (i =3D 0; i < p->interrupt_count; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->interrupts[i]) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->interrupts[i] < =
PNP_IRQ_NR)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_b=
it(p->interrupts[i], map.bits);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(&dev->dev, "ignoring IRQ %d option "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "(too large for %d entry bitmap)\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 p->interrupts[i], PNP_IRQ_NR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 for (i =3D 0; i < p->interrupt_count; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pnpacpi_gsi_option_to_irq(dev, &map, p-=
>interrupts[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 p->triggering, p->polarity);
>
> =A0 =A0 =A0 =A0flags =3D irq_flags(p->triggering, p->polarity, p->sha=
rable);
> =A0 =A0 =A0 =A0pnp_register_irq_resource(dev, option_flags, &map, fla=
gs);
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
