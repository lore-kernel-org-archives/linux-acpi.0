From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] add acpi_interrupt_to_irq
Date: Fri, 23 Jan 2004 09:35:38 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D3720017361886E@scsmsx402.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Not a problem to me :-) So if we remove the #ifdef (i.e. both
CONFIG_IA64 and CONFIG_PCI_USE_VECTOR) there, I think acpi_gsi_to_irq is
reasonable there. For x86 we'll switch to (the old) acpi_irq_to_vector
if CONFIG_PCI_USE_VECTOR is configured, and don't do anything for the
usual case. But I don't expect Len to replace every irq in ACPI with
gsi, though.

BTW, we need to think how we support MSI (and PCI Express) for IPF; we
already posted a PCI Express patch for x86. Today's IRQ abstraction on
IPF might have some advantage for supporting MSI, which is required for
PCI Express.

Jun

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]
> Sent: Friday, January 23, 2004 8:36 AM
> To: Nakajima, Jun; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-
> ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Brown, Len
> Subject: Re: [ACPI] [PATCH] add acpi_interrupt_to_irq
>=20
> On Thursday 22 January 2004 8:36 pm, Nakajima, Jun wrote:
> > > What does "vector" mean?
> > For MSI, vector means the (external) interrupt vector, i.e. the
index in
> > the IDT for MSI on x86. So acpi_irq_to_vector() is correct in that
case.
> > ACPI looks at IRQ or GSI (Global system interrupt) vector (yes, it's
> > confusing). SOMETHING should be irq or gsi, as David suggested.
> >
> > Since MSI does not require IRQ (but external interrupt vector), the
way
> > we did for x86 was to use the vector to unify IRQ and vector. So
> > request_irq() actually gets the interrupt vector number, instead of
irq.
> > That's the reason I preferred acpi_irq_to_vector() in that code with
MSI
> > configured.
>=20
> Sorry to drag this out even longer...  I promise I'll shut up
> after this :-)
>=20
> But this business about request_irq() getting an MSI interrupt vector
> number, not an irq, is just a detail of the MSI and architecture
> implementation.  Surely ACPI should just use the abstract Linux
> interrupt interface (request_irq(), free_irq(), etc), which uses
> the "irq" terminology, and should remain ignorant of whether MSI
> is even present.
>=20
> Bjorn



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
