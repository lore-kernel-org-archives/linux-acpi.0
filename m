From: "Cagle, John (ISS-Houston)" <john.cagle-VXdhtT5mjnY@public.gmane.org>
Subject: RE: mpparse.c APIC/ACPI support
Date: Tue, 4 Mar 2003 11:34:58 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD10476BFF9@cceexc19.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, info-IGm5bqYn3xwb1SvskN2V4Q@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: alan-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Grover, Andrew [mailto:andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]=20
>=20
> > From: Cagle, John (ISS-Houston) [mailto:john.cagle-VXdhtT5mjnY@public.gmane.org]
> > I'm glad you got your system working with ACPI again.  Regarding
> > Windows, I've heard that it may|will remap just about=20
> > everything to its
> > liking, so it doesn't surprise me that it's different.
> >=20
> > I'm not an expert on APICs, but it seems that the
> > mp_config_acpi_legacy_irqs() routine shouldn't blindly set
> > IRQs 0..15 to
> > ISA conforming mode (edge triggered).  I know for a fact that many
> > systems will have PCI devices using/sharing these IRQs, which will
> > require the IRQ to be level-triggered.
>=20
> In theory, ACPI comes through later and changes the irqs < 15=20
> with possible PCI devices by calling io_apic_set_pci_routing.
>
> So *in theory* it should work ok. Obviously something is not right.

How does ACPI, when it comes through later, know which irq's < 15 are
for PCI devices?

Thanks,
John


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
