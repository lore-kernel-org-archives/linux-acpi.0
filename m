From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: compile warning fix patch 2.4.26pre1
Date: Sun, 29 Feb 2004 02:37:41 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078022260.25125.11.camel@darkstar>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ByXoC2pqy2i+hoGLzi5U"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-ByXoC2pqy2i+hoGLzi5U
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi
compiling 2.4.26-pre1 appears this:

system.c: In function `acpi_power_off':
system.c:98: warning: implicit declaration of function `acpi_system_save_st=
ate'
system.c: At top level:
system.c:178: warning: type mismatch with previous implicit declaration
system.c:98: warning: previous implicit declaration of `acpi_system_save_st=
ate'
system.c:178: warning: `acpi_system_save_state' was previously implicitly d=
eclared to return `int'
system.c: In function `acpi_power_off':
system.c:98: warning: implicit declaration of function `acpi_system_save_st=
ate'
system.c: At top level:
system.c:178: warning: type mismatch with previous implicit declaration
system.c:98: warning: previous implicit declaration of `acpi_system_save_st=
ate'
system.c:178: warning: `acpi_system_save_state' was previously implicitly d=
eclared to return `int'

this could be resolved with this trivial patch=20

Thanks
--=20
S=E9rgio M. B.

--=-ByXoC2pqy2i+hoGLzi5U
Content-Disposition: attachment; filename=compilewarningfix.diff
Content-Type: text/x-patch; name=compilewarningfix.diff; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.25.new/drivers/acpi/system.orig	2004-02-29 02:21:44.000000000 +0000
+++ linux-2.4.25.new/drivers/acpi/system.c	2004-02-29 02:22:12.000000000 +0000
@@ -61,6 +61,7 @@
 static int acpi_system_remove (struct acpi_device *device, int type);
 
 acpi_status acpi_suspend (u32 state);
+acpi_status acpi_system_save_state (u32 state);
 
 static struct acpi_driver acpi_system_driver = {
 	.name =		ACPI_SYSTEM_DRIVER_NAME,

--=-ByXoC2pqy2i+hoGLzi5U--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
