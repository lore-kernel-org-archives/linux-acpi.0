From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] add acpi_interrupt_to_irq
Date: Thu, 22 Jan 2004 19:36:17 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D3720017361886A@scsmsx402.sc.intel.com>
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

> What does "vector" mean? =20
For MSI, vector means the (external) interrupt vector, i.e. the index in
the IDT for MSI on x86. So acpi_irq_to_vector() is correct in that case.
ACPI looks at IRQ or GSI (Global system interrupt) vector (yes, it's
confusing). SOMETHING should be irq or gsi, as David suggested.

Since MSI does not require IRQ (but external interrupt vector), the way
we did for x86 was to use the vector to unify IRQ and vector. So
request_irq() actually gets the interrupt vector number, instead of irq.
That's the reason I preferred acpi_irq_to_vector() in that code with MSI
configured.

Jun
> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]
> Sent: Thursday, January 22, 2004 8:38 AM
> To: Nakajima, Jun; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-
> ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Brown, Len
> Subject: Re: [ACPI] [PATCH] add acpi_interrupt_to_irq
>=20
> On Wednesday 21 January 2004 8:36 pm, Nakajima, Jun wrote:
>=20
> > > 	(b) is "acpi_interrupt_to_irq" a better name than
> > > 	    "acpi_irq_to_vector"?
> >
> > I don't know what people imagine by "interrupt", but to me it
implies an
> > "event".
>=20
> Are you saying that you think "acpi_irq_to_vector" is the right name?
> What does "vector" mean?  The return value of that function is in
> fact a Linux IRQ, and is passed to request_irq() and free_irq().  So
> I think the correct name is "acpi_SOMETHING_to_irq".  If you don't
> like "interrupt", you can propose something else.  I just think it's
> misleading for the name to contain "to_vector", when it's really
> doing "to_irq".
>=20



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
