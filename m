From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH/RFC 2/2]ACPI PNP driver
Date: Wed, 22 Sep 2004 12:52:08 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409221252.08427.bjorn.helgaas@hp.com>
References: <1095827699.18437.139.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1095827699.18437.139.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 21 September 2004 10:35 pm, Li Shaohua wrote:
> This patch provides an ACPI based PNP driver. It is based on Matthieu
> Castet's original work. With this patch, legacy device drivers (floppy
> ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
> directly use ACPI can be removed, since now we have unified PNP
> interface for legacy devices.

I know next to nothing about PNP (I thought it went out with
ISA/EISA/MCA, to be honest :)), so bear with me if I'm
asking stupid questions ...

PNP currently depends on ISA.  ia64 doesn't set ISA.  So if you
pull ACPI support out of serial/floppy/etc, those devices will
stop working on ia64.  Are you planning to remove the ISA
dependency?

I just added ACPI support to i8042 (PS/2 kbd & mouse).  I don't
see any PNP support there.  What is your vision for the future
of i8042?  Replace my ACPI stuff with PNP stuff?

Does PNP support hot-plug?  There are definitely ACPI devices
for which we want to support hot-plug, such as serial ports built
into a hot-pluggable cell.  (A "cell" is what HP calls a unit
of CPUs, memory, and I/O, that can be plugged together into a
NUMA machine.)

> + if(strlen(acpi_device_name(device)))
> +  strncpy(dev->name, acpi_device_name(device), PNP_NAME_LEN);
> + else
> +  strncpy(dev->name, acpi_device_bid(device), PNP_NAME_LEN);

You could use sizeof(dev->name) instead of PNP_NAME_LEN.
Inconsistent spacing ("if (...)" vs "if(...)" here and elsewhere.

> +config PNPACPI
> + bool "Plug and Play ACPI support (EXPERIMENTAL)"
> + depends on PNP && X86 && ACPI_BUS && !PNPBIOS && EXPERIMENTAL

Why does this depend on X86?  (Thinking about ia64 again :-)).

> +#define valid_IRQ(i) (((i) != 0) && ((i) != 2) && ((i) < 16))
> ...
> + case ACPI_RSTYPE_IRQ:
> +  if ((res->data.irq.number_of_interrupts > 0) &&
> +   valid_IRQ(res->data.irq.interrupts[0])) {

Why the valid_IRQ() check?  It certainly doesn't make any sense
on ia64.

> +   pnpacpi_parse_allocated_irqresource(res_table, 
> +    acpi_register_gsi(res->data.irq.interrupts[0],
> +     res->data.irq.edge_level,
> +     res->data.irq.active_high_low));

The nice thing about doing acpi_register_gsi() here is that
drivers don't have to remember to do it.  The bad thing is that
it gets done always, even if the driver decides not to claim the
device.

Is there a hook in PNP where we could unregister the GSI (for
example, if the ACPI device is removed)?  We don't currently
have an interface to unregister them, but Kenji Kaneshige is
hard at work adding it.

> +static void pnpacpi_parse_irq_option(struct pnp_option *option,
> + struct acpi_resource_irq *p)
> ...
> + if (p->number_of_interrupts <= 0)

p->number_of_interrupts is u32, so can't be < 0.

> ...
> + for(i = 0; i < p->number_of_interrupts; i++)
> +  irq->map |= 1 << p->interrupts[i];

This doesn't work in general, because p->interrupts[i] is a
u32 GSI, while irq->map is a short.  Is there some reason you
are assured that these GSIs are small enough for the mask to
fit?

It feels like a potential bug that we populate the pnp_irq map
with all the interrupts, but we only acpi_register_gsi() the
first one.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
