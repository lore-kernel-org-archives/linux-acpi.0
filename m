From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: trivial patch for kernel 2.4.19
Date: 08 Oct 2002 03:05:22 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034060724.1479.29.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zP9UpCn+lw/0PwppE6oG"
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


--=-zP9UpCn+lw/0PwppE6oG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

this patch is not acpi related but  should be applied when use
acpi-patch again kernel 2.4.19.

thanks
S=E9rgio


thats all :-) =20



--=-zP9UpCn+lw/0PwppE6oG
Content-Disposition: attachment; filename=test13
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=test13; charset=ISO-8859-1

--- linux-2.4.19orig/arch/i386/kernel/setup.c	Sun Oct  6 21:39:55 2002
+++ linux-2.4.19acpi/arch/i386/kernel/setup.c	Sun Oct  6 22:05:22 2002
@@ -742,6 +742,12 @@
 } /* setup_memory_region */
=20
=20
+/* Probe for the CPUID instruction */
+static int __init have_cpuid_p(void)
+{
+	return flag_is_changeable_p(X86_EFLAGS_ID);
+}
+
 int __init amd_adv_spec_cache_feature(void)
 {
 	char vendor_id[16];
@@ -2626,12 +2632,6 @@
 }
=20
=20
-/* Probe for the CPUID instruction */
-static int __init have_cpuid_p(void)
-{
-	return flag_is_changeable_p(X86_EFLAGS_ID);
-}
-
 /*
  * Cyrix CPUs without cpuid or with cpuid not yet enabled can be detected
  * by the fact that they preserve the flags across the division of 5/2.

--=-zP9UpCn+lw/0PwppE6oG--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
