From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: [PATCH] warning: implicit declaration of function
	mp_config_ioapic_for_sci
Date: 09 Oct 2002 01:14:13 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034140205.1666.23.camel@darkstar.portugal>
References: <1034060159.1541.24.camel@darkstar.portugal>
	<20021008125912.Q18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Z33VmDmuHdnS4e0TsVXP"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021008125912.Q18545-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-Z33VmDmuHdnS4e0TsVXP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

First of all thanks for replying to this email and for the information.

so I remade the patch, and (I think) now is a good patch, because is not
need declared the mp_config_ioapic_for_sci function.


On Tue, 2002-10-08 at 07:59, Matthew Wilcox wrote:=20
> On Tue, Oct 08, 2002 at 02:55:57AM -0400, S=E9rgio Monteiro Basto wrote:
> > +++ linux-2.4.19acpi/include/asm-i386/mpspec.h	Sun Oct  6 21:34:06 2002
>                                ^^^^^^^^
> > +#ifdef CONFIG_X86
> > +extern void mp_config_ioapic_for_sci(int irq);
> > +#endif /*CONFIG_X86*/
>=20
> you really don't need to encase this in CONFIG_X86.  if it's in asm-i386
> and some other cpu type is including this file, things are already
> hideously wrong.
>=20
> --=20
> Revolutions do not require corporate support.
>=20

--=-Z33VmDmuHdnS4e0TsVXP
Content-Disposition: attachment; filename=acpi_explicit2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=acpi_explicit2.diff; charset=ISO-8859-1

--- linux-2.4.19orig/drivers/acpi/bus.c	Sun Oct  6 21:39:56 2002
+++ linux-2.4.19acpi/drivers/acpi/bus.c	Wed Oct  9 01:00:12 2002
@@ -1883,10 +1883,14 @@
=20
 #ifdef CONFIG_X86
         /* Ensure the SCI is set to level-triggered, active-low */
+#ifdef CONFIG_X86_IO_APIC
         if (acpi_ioapic)
          	mp_config_ioapic_for_sci(acpi_fadt.sci_int);
 	else
                 eisa_set_level_irq(acpi_fadt.sci_int);
+#else
+	eisa_set_level_irq(acpi_fadt.sci_int);
+#endif
 #endif
=20
 	status =3D acpi_enable_subsystem(ACPI_FULL_INITIALIZATION);

--=-Z33VmDmuHdnS4e0TsVXP--




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
