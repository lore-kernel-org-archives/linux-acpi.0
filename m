From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Make CONFIG_ACPI_BOOT work again
Date: Thu, 1 Aug 2002 12:42:04 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020801104204.GA146@elf.ucw.cz>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

This patch makes CONFIG_ACPI_BOOT functional again. Please apply,

								Pavel

--- clean/arch/i386/kernel/acpi.c	Mon Jun  3 11:43:27 2002
+++ linux-swsusp/arch/i386/kernel/acpi.c	Mon Jun 10 23:03:24 2002
@@ -53,11 +53,9 @@
                               Boot-time Configuration
    -------------------------------------------------------------------------- */
 
-#ifdef CONFIG_ACPI_BOOT
-
 enum acpi_irq_model_id		acpi_irq_model;
 
-
+#ifdef CONFIG_ACPI_BOOT
 /*
  * Use reserved fixmap pages for physical-to-virtual mappings of ACPI tables.
  * Note that the same range is used for each table, so tables that need to
--- clean/include/linux/acpi.h	Mon Jun  3 11:43:38 2002
+++ linux-swsusp/include/linux/acpi.h	Mon Jun 10 23:03:25 2002
@@ -39,7 +39,7 @@
 #include <asm/acpi.h>
 
 
-#ifdef CONFIG_ACPI_BOOT
+#ifdef CONFIG_ACPI
 
 enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_PIC = 0,

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
