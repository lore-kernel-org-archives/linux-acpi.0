From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH/RFC 2/2]ACPI PNP driver
Date: Fri, 24 Sep 2004 10:15:51 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095991340.2628.27.camel@sli10-desk.sh.intel.com>
References: <200409221252.08427.bjorn.helgaas@hp.com>
	 <1095907272.15681.17.camel@sli10-desk.sh.intel.com>
	 <200409230856.14991.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200409230856.14991.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Andrew Grover <andy.grover-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthieu <castet.matthieu-GANU6spQydw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-09-23 at 22:56, Bjorn Helgaas wrote:
> On Wednesday 22 September 2004 8:41 pm, Li Shaohua wrote:
> > On Thu, 2004-09-23 at 02:52, Bjorn Helgaas wrote:
> > > On Tuesday 21 September 2004 10:35 pm, Li Shaohua wrote:
> > > > +#define valid_IRQ(i) (((i) != 0) && ((i) != 2) && ((i) < 16))
> > > > ...
> > > > + case ACPI_RSTYPE_IRQ:
> > > > +  if ((res->data.irq.number_of_interrupts > 0) &&
> > > > +   valid_IRQ(res->data.irq.interrupts[0])) {
> > > 
> > > Why the valid_IRQ() check?  It certainly doesn't make any sense
> > > on ia64.
> > I checked the IA32 systems and Tiger4, and I haven't saw any PNP device
> > with irq >= 16. I don't know the HP specific system, could you please
> > show me a light?
> 
> res->data.irq.interrupts[0] is an ACPI GSI.  I'm not aware of
> anything in the spec that prevents use of an arbitrary 32-bit
> value.  For example, the HP rx2600 and zx6000 use the following
> values for built-in serial ports:
> 
>  rx2600: GSI 34 (edge, high) -> CPU 0 (0x0000) vector 49
>  rx2600: ttyS0 at MMIO 0xff5e0000 (irq = 49) is a 16550A
>  rx2600: GSI 35 (edge, high) -> CPU 1 (0x0100) vector 59
>  rx2600: ttyS1 at MMIO 0xff5e2000 (irq = 59) is a 16550A
> 
>  zx6000: GSI 45 (edge, high) -> CPU 0 (0x0000) vector 49
>  zx6000: ttyS0 at MMIO 0xff5e0000 (irq = 49) is a 16550A
>  zx6000: GSI 46 (edge, high) -> CPU 0 (0x0000) vector 50
>  zx6000: ttyS1 at MMIO 0xff5e2000 (irq = 50) is a 16550A
Thanks Bjorn. PNP layer isn't designed for irq >= 16, but it should be
not difficult to support it.
PS. After some hack, 8250_pnp driver actually works in a Tiger4 system. 

> 
> > > It feels like a potential bug that we populate the pnp_irq map
> > > with all the interrupts, but we only acpi_register_gsi() the
> > > first one.
> > It doesn't matter. A device only uses one IRQ. pnp_irq map presents the
> > possible IRQs for device if it needs dynamically configure.
> 
> Oh, I see.  Then it sounds like we need places to unregister the
> old GSI and register the new one if the configuration is dynamically
> changed.
I agree. We can unregister the GSI when the PNP layer detach the driver.
There is a 'disable_device' routine, we can add it there.

Thanks,
Shaohua



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
