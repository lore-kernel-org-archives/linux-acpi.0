From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: [PATCH] warning: implicit declaration of function
 mp_config_ioapic_for_sci
Date: 08 Oct 2002 02:55:57 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034060159.1541.24.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eRzbfuuCTfc5EIaSVimy"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-eRzbfuuCTfc5EIaSVimy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


bus.c:1887: warning: implicit declaration of function
`mp_config_ioapic_for_sci'

A trivial patch


--=-eRzbfuuCTfc5EIaSVimy
Content-Disposition: attachment; filename=acpi_explicit.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=acpi_explicit.diff; charset=ISO-8859-1

--- linux-2.4.19acpi/include/asm-i386/mpspec.h.orig	Sun Oct  6 21:27:06 200=
2
+++ linux-2.4.19acpi/include/asm-i386/mpspec.h	Sun Oct  6 21:34:06 2002
@@ -228,9 +228,11 @@
 extern void mp_register_ioapic (u8 id, u32 address, u32 irq_base);
 extern void mp_override_legacy_irq (u8 bus_irq, u8 polarity, u8 trigger, u=
32 global_irq);
 extern void mp_config_acpi_legacy_irqs (void);
-extern void mp_config_ioapic_for_sci(int irq);
 extern void mp_parse_prt (void);
 #endif /*CONFIG_X86_IO_APIC*/
+#ifdef CONFIG_X86
+extern void mp_config_ioapic_for_sci(int irq);
+#endif /*CONFIG_X86*/
=20
 #endif /*CONFIG_ACPI_BOOT*/
=20

--=-eRzbfuuCTfc5EIaSVimy--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
