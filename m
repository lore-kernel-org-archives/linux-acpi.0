From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: ACPI blacklisting code in 2 places
Date: Wed, 1 Oct 2003 12:14:47 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031001101447.GA3425@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

Currently, acpi blacklisting code has 3 (!) components:

drivers/acpi/blacklist.c
arch/i386/kernel/dmi_scan.c -- code based on bios date
arch/i386/kernel/dmi_scan.c -- code based bios name

. Thats messy. For example drivers/acpi/blacklist.c knows my toshiba
bios is okay (it knows it contains non-fatal errors), but BIOS date
code overrides it, and simulates user doing acpi=off. So system tells
me I have non-fatal errors and then behaves like I passed
acpi=off. Ouch.

Part 1: include acpi.h to dmi_scan.c; dmi_scan and acpi layer both
want to have function called acpi_disable, rename dmi_scan's one. (It
matches rest of file better, anyway).

Please apply,
								Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/dmi_scan.c	2003-09-28 22:05:29.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/dmi_scan.c	2003-10-01 11:55:21.000000000 +0200
@@ -10,6 +10,7 @@
 #include <linux/pm.h>
 #include <asm/system.h>
 #include <linux/bootmem.h>
+#include <linux/acpi.h>
 
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
@@ -506,7 +507,7 @@
 
 extern int acpi_disabled, acpi_force;
 
-static __init __attribute__((unused)) int acpi_disable(struct dmi_blacklist *d) 
+static __init __attribute__((unused)) int disable_acpi(struct dmi_blacklist *d) 
 { 
 	if (!acpi_force) { 
 		printk(KERN_NOTICE "%s detected: acpi off\n",d->ident); 
@@ -880,7 +881,7 @@
 	 *	Boxes that need ACPI disabled
 	 */
 
-	{ acpi_disable, "IBM Thinkpad", {
+	{ disable_acpi, "IBM Thinkpad", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "2629H1G"),
 			NO_MATCH, NO_MATCH }},

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
