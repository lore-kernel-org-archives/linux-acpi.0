From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: Re: [PATCH] warning: implicit declaration of function
	mp_config_ioapic_for_sci
Date: 10 Oct 2002 00:38:38 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034224720.1836.12.camel@darkstar.portugal>
References: <1034060159.1541.24.camel@darkstar.portugal>
	<20021008125912.Q18545@parcelfarce.linux.theplanet.co.uk>
	<1034140205.1666.23.camel@darkstar.portugal>
	<20021009144232.Z18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GTXWZjbzEttnQzHDfeoq"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20021009144232.Z18545-+pPCBgu9SkPzIGdyhVEDUDl5KyyQGfY2kSSpQ9I8OhVaa/9Udqfwiw@public.gmane.org>
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


--=-GTXWZjbzEttnQzHDfeoq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-10-09 at 09:42, Matthew Wilcox wrote:
> (could someone fix the indenting here?  it's a mess!)
sorry 3rd time ..., please ignore and delete, my last message again.
thanks
S=E9rgio Basto

--=-GTXWZjbzEttnQzHDfeoq
Content-Disposition: attachment; filename=acpi_explicit4.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=acpi_explicit4.diff; charset=ISO-8859-1

--- linux-2.4.19orig/drivers/acpi/bus.c	Sun Oct  6 21:39:56 2002
+++ linux-2.4.19acpi/drivers/acpi/bus.c	Thu Oct 10 00:32:24 2002
@@ -1882,12 +1882,15 @@
 	}
=20
 #ifdef CONFIG_X86
-        /* Ensure the SCI is set to level-triggered, active-low */
-        if (acpi_ioapic)
-         	mp_config_ioapic_for_sci(acpi_fadt.sci_int);
+	/* Ensure the SCI is set to level-triggered, active-low */
+#ifdef CONFIG_X86_IO_APIC
+	if (acpi_ioapic)
+		mp_config_ioapic_for_sci(acpi_fadt.sci_int);
 	else
-                eisa_set_level_irq(acpi_fadt.sci_int);
-#endif
+#else
+		eisa_set_level_irq(acpi_fadt.sci_int);
+#endif /* CONFIG_X86_IO_APIC */
+#endif /* CONFIG_X86 */
=20
 	status =3D acpi_enable_subsystem(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {

--=-GTXWZjbzEttnQzHDfeoq--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
