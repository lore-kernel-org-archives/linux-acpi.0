From: Andrew de Quincey <adq_dvb-fmPXVN3awWJAJAzL26g0SA@public.gmane.org>
Subject: Re: ACPI ignoring IRQ flags in PRT
Date: Sun, 13 Jul 2003 20:49:13 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307132049.13913.adq_dvb@lidskialf.net>
References: <200307131452.39000.adq_dvb@lidskialf.net> <20030713142321.GC20424@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030713142321.GC20424-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sunday 13 July 2003 15:23, Matthew Wilcox wrote:
> On Sun, Jul 13, 2003 at 02:52:38PM +0100, Andrew de Quincey wrote:
> > Hi, from my understanding of the ACPI spec, each IRQ as specified in the
> > _PRT has additional flags associated with it (e.g. specifying the
> > polarity, level etc) that should be used for this IRQ.
> >
> > The Linux ACPI code seems to be ignoring these, and hardcodes them to the
> > values that cause problems for me. Is there a reason, or has that code
> > just not been written yet?
>
> you can't mean the _PRT.  the _PRT describes PCI interrupts, and those
> have their polarity and trigger specified by the PCI spec.  i suspect you
> mean someting else, but i'm not sure what.  can't be the SCI interrupt
> since that's defined to be level, low, sharable.
>
> some of the ia64 acpi code pays attention to polarity and edge vs level.
> now that we know this is an issue on x86, maybe some more people will be
> interested in thinking about how to fix this properly.  here's what we
> currently have on ia64:
>
> int acpi_register_irq (u32 gsi, u32 polarity, u32 trigger);

My first thoughts are:

Need to modify io_apic.c/io_apic_set_pci_routing() in the i386 architecture so 
it takes the polarity and trigger.

In i386, the actual PRT parsing and calls to io_apic_set_pci_routing() is done 
by mpparse.c/mp_parse_prt(), so that has to change... possibly not the API 
though.

I'm going to have a look into developing a prototype patch for this this 
evening.

As for Jurriaan's problem, I think it _may_ be a slightly different issue... 
so it is probably best to sort this on a board I have access to, then see if 
it needs more development iterations....



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
