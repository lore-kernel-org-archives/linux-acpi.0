From: "Nakajima, Jun" <jun.nakajima-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] add acpi_interrupt_to_irq
Date: Wed, 21 Jan 2004 19:36:43 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <7F740D512C7C1046AB53446D37200173618864@scsmsx402.sc.intel.com>
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

To be clear, the vector-based PCI interrupt support for MSI is in 2.6.1,
but the particular ACPI code in -mm was a bug fix that we added
recently.

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bjorn.helgaas-VXdhtT5mjnY@public.gmane.org]
> Sent: Wednesday, January 21, 2004 2:54 PM
> To: Nakajima, Jun; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-
>=20
> Any feedback on these questions from my previous mail:
>=20
> 	(a) do you want the #ifdefs in ACPI (as in 2.6.1-mm5),
> 	    or in the platform-specific code (as in my patch)?

I would like to avoid #ifdefs even in -mm5.

>=20
> 	(b) is "acpi_interrupt_to_irq" a better name than
> 	    "acpi_irq_to_vector"?

I don't know what people imagine by "interrupt", but to me it implies an
"event".=20

If we have definitions of acpi_irq_to_vector(irq) for other
architectures (as you basically did), we can remove #ifdef CONFIG_IA64.
For x86, we can switch the definition using CONFIG_PCI_USE_VECTOR.=20

>=20
> 	(c) is acpi_os_install_interrupt_handler() saving the
> 	    wrong value in acpi_irq_irq?
>=20

I think the original IA-64 code was wrong (so CONFIG_PCI_USE_VECTOR will
be wrong there, too).  The value of irq is covered to vector by
acpi_irq_to_vector(irq) in acpi_os_install_interrupt_handler(), then
this value is set to acpi_irq_irq. But
acpi_os_remove_interrupt_handler() is given acpi_irq_irq (i.e. vector),
then it again calls acpi_irq_to_vector() prior to calling
free_irq(irq,,).

Thanks,
Jun



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
