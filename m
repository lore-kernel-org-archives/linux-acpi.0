From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: RE: ACPI vs. ISA IRQs
Date: 05 Nov 2003 01:51:51 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068015110.6057.50.camel@dhcppc4>
References: <F760B14C9561B941B89469F59BA3A8470255EF8A@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A8470255EF8A-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Diefenbaugh, Paul S" <paul.s.diefenbaugh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Re-reading my message I realize I wrote it backwards with the
unimportant part first.

Forget the IRQ sharing/performance part -- that is just a nice-to-have. 
Yes, if you want fast interrupts, you wouldn't be using the PIC in the
first place.

The unsolved issue is what happens when an ISA device needs to claim an
IRQ that ACPI has routed PCI to.  Declining to re-route active PCI link
devices and/or piling up all the PCI devices on the same IRQ make this
problem less frequent, but it doesn't make it go away.

The patch I just sent out should be able to manually cope with the issue
-- though the user has to know enough to figure out what IRQ is at issue
and to use the cmdline flag.

I think the automatic fix would require ACPI to re-program the link
device off an IRQ that is later requested by an ISA device...

-Len

On Tue, 2003-11-04 at 18:28, Grover, Andrew wrote:
> > From: Brown, Len 
> > Assumption: sharing interrupts is bad.
> 
> It's not ideal, but it's not bad. PCI was designed to allow shared irqs.
> IIRC we originally distributed IRQs, but we changed for exactly the
> reason you describe below - ISA. (Paul correct me if I'm wrong.) And,
> this is the default behavior on Windows (my T20 has 7 devices on irq 11)
> to better support docking.
> 
> Sharing works OK as long as everyone doesn't take too long in their
> ISRs, so that would be where I'd look first to make fixes, rather than
> disturbing IRQ assignment. Plus, this problem goes away when IOAPIC
> becomes the norm, doesn't it?
> 
> my 2c -- Andy
> 
> > 
> > Plan:
> > ACPI should attempt to distribute interrupts across
> > the available IRQs.
> > 
> > This mostly applies to PIC mode, where PCI
> > IRQ Link Devices are available to route PCI
> > interrupts to open IRQs on the PIC.
> > (In IO-APIC mode, we generally get no choice
> >  which IO-APIC pins devices are attached to)
> > 
> > We have acpi_irq_penalty[] (disabled at the moment)
> > in pci_link.c hard-coded to tell ACPI to avoid some IRQs
> > that are commonly used by ISA devices.
> > 
> > But if,say, a sound-blaster card requests exclusive access
> > to an IRQ that we didn't happen to reserve, and we happened
> > to set a PCI link device to that IRQ, then sound doesn't
> > work.
> > 
> > How to fix?
> > 
> > We can manually reserve IRQs to over-ride acpi_irq_penalty[],
> > say "acpi_irq_used=5,10" to tell ACPI not to use IRQs that
> > it thought by default were available.
> > 
> > Conversely, we could us, say, "acpi_irq_free=3,15" to tell
> > ACPI that some IRQs it assumed were reserved for ISA are
> > actually available for PCI.
> > 
> > I don't know of an automatic way to handle this.
> > Seems that the ISA devices use Plug-and-Play methods
> > to request IRQs, but there is no mechanism for such
> > an event to boot a PIRQ off an IRQ if ACPI has put it there.
> > Also, if such a mechanism existed, it wouldn't work
> > if PNP were not available to ask for an IRQ.
> > 
> > thoughts?
> > 
> > thanks,
> > -Len
> > 
> > ref:
> > http://bugzilla.kernel.org/show_bug.cgi?id=430
> > http://bugzilla.kernel.org/show_bug.cgi?id=1139
> > http://bugzilla.kernel.org/show_bug.cgi?id=1391
> > 
> > 
> > 
> > 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?   SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
