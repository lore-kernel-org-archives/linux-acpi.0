From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] add acpi_interrupt_to_irq
Date: Wed, 21 Jan 2004 15:54:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401211554.16535.bjorn.helgaas@hp.com>
References: <7F740D512C7C1046AB53446D37200173618863@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <7F740D512C7C1046AB53446D37200173618863-exJ48ZlmiLrcnAH0NVKmOFDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 21 January 2004 3:42 pm, Nakajima, Jun wrote:
> One notes. In x86, although you assumed interrupt == IRQ, that's not the
> case with so called "vector-based PCI interrupt handling" in support of
> MSI (which is 2.6.1). With this, do_IRQ(irq, ...) will get the vector
> number instead of IRQ, which is same as IPF. 

My patch was against 2.6.1, which doesn't include the "vector-based
PCI interrupt handling", so I didn't change the behavior on x86.

> I think we can use the common code for that configuration at least in
> ACPI. If you look at 2.6.1-mm5, for example, we also have
> acpi_irq_to_vector(), which is doing the same thing as IPF does.

I agree that in 2.6.1-mm5, which does have the vector-based stuff,
the x86 acpi_irq_to_vector() needs to be smarter.

The whole point of my patch was to make "acpi_irq_to_vector()"
be a standard platform interface, so each platform can do what
it needs, without cluttering ACPI with #ifdefs.

Any feedback on these questions from my previous mail:

	(a) do you want the #ifdefs in ACPI (as in 2.6.1-mm5),
	    or in the platform-specific code (as in my patch)?

	(b) is "acpi_interrupt_to_irq" a better name than
	    "acpi_irq_to_vector"?

	(c) is acpi_os_install_interrupt_handler() saving the
	    wrong value in acpi_irq_irq?

Bjorn

> > -----Original Message-----
> > From: linux-ia64-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-ia64-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Bjorn Helgaas
> > Sent: Wednesday, January 21, 2004 12:18 PM
> > To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-ia64@vger.kernel.org
> > Cc: Brown, Len; Nakajima, Jun
> > Subject: Re: [ACPI] [PATCH] add acpi_interrupt_to_irq
> > 
> > On Wednesday 21 January 2004 9:39 am, Bjorn Helgaas wrote:
> > > There's also something fishy in this area that neither the -mm5
> > > code nor my patch addresses.  In the
> acpi_os_install_interrupt_handler()
> > > fragment above, we do the "acpi interrupt->irq" conversion and save
> > > the resulting irq in acpi_irq_irq.  The only place acpi_irq_irq is
> > > used is in acpi_os_terminate(), where it is passed to
> acpi_os_remove_
> > > interupt_handler(), where we apply the "acpi interrupt->irq"
> conversion
> > > AGAIN.  This seems wrong.
> > 
> > OK, I think I understand what's wrong there.  acpi_irq_irq needs to
> > be the PRE-CONVERSION interrupt, like this:
> > 
> >     acpi_status
> >     acpi_os_install_interrupt_handler(u32 interrupt, OSD_HANDLER
> handler,
> > void *context)
> >     {
> > 	unsigned int irq;
> > 
> > 	interrupt = acpi_fadt.sci_int;
> > 	irq = acpi_irq_to_vector(interrupt);
> > 	...
> >         acpi_irq_irq = interrupt;
> > 	...
> > 	if (request_irq(irq, ...))
> > 
> > Then acpi_os_terminate() will pass the pre-conversion value to
> > acpi_os_remove_interrupt_handler(), which will apply
> acpi_irq_to_vector()
> > and everything will match.
> > 
> > I'll make a note to clean this up after the previous issues in the
> > area are straightened out.
> > 
> > Bjorn
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-ia64"
> in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Bjorn Helgaas - bjorn.helgaas at hp.com
Linux and Open Source Lab
Hewlett-Packard Company



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
