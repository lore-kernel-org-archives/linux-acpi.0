From: Mattia Dongili <malattia@linux.it>
Subject: Re: ACPI patches for 2.6.22 merge window
Date: Tue, 1 May 2007 11:19:53 +0900
Message-ID: <20070501021953.GC2923@inferi.kami.home>
References: <11778223052751-git-send-email-len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:50505 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754047AbXEACUB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Apr 2007 22:20:01 -0400
Content-Disposition: inline
In-Reply-To: <11778223052751-git-send-email-len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Sun, Apr 29, 2007 at 12:50:00AM -0400, Len Brown wrote:
...
> If I've missed something that you think is appropriate
> for 2.6.22 (I'm sure there are several) please let me know.

It's me who actually forgot to submit a trivial patch for 2.6.22,
appended below.

mattia
---
Subject: rename SONY_LAPTOP_OLD to a more meaningful SONYPI_COMPAT

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
Index: linux-2.6/drivers/misc/Kconfig
===================================================================
--- linux-2.6.orig/drivers/misc/Kconfig	2007-04-30 12:18:58.534918327 +0900
+++ linux-2.6/drivers/misc/Kconfig	2007-04-30 12:19:24.036371572 +0900
@@ -121,7 +121,7 @@ config SONY_LAPTOP
 
 	  Read <file:Documentation/sony-laptop.txt> for more information.
 
-config SONY_LAPTOP_OLD
+config SONYPI_COMPAT
 	bool "Sonypi compatibility"
 	depends on SONY_LAPTOP
 	  ---help---
Index: linux-2.6/drivers/misc/sony-laptop.c
===================================================================
--- linux-2.6.orig/drivers/misc/sony-laptop.c	2007-04-30 12:18:55.534747357 +0900
+++ linux-2.6/drivers/misc/sony-laptop.c	2007-04-30 12:19:35.537026957 +0900
@@ -63,7 +63,7 @@
 #include <asm/uaccess.h>
 #include <linux/sonypi.h>
 #include <linux/sony-laptop.h>
-#ifdef CONFIG_SONY_LAPTOP_OLD
+#ifdef CONFIG_SONYPI_COMPAT
 #include <linux/poll.h>
 #include <linux/miscdevice.h>
 #endif
@@ -114,7 +114,7 @@ MODULE_PARM_DESC(camera,
 		 "set this to 1 to enable Motion Eye camera controls "
 		 "(only use it if you have a C1VE or C1VN model)");
 
-#ifdef CONFIG_SONY_LAPTOP_OLD
+#ifdef CONFIG_SONYPI_COMPAT
 static int minor = -1;
 module_param(minor, int, 0);
 MODULE_PARM_DESC(minor,
@@ -1504,7 +1504,7 @@ static struct attribute_group spic_attri
 };
 
 /******** SONYPI compatibility **********/
-#ifdef CONFIG_SONY_LAPTOP_OLD
+#ifdef CONFIG_SONYPI_COMPAT
 
 /* battery / brightness / temperature  addresses */
 #define SONYPI_BAT_FLAGS	0x81
@@ -1798,7 +1798,7 @@ static void sonypi_compat_exit(void)
 static int sonypi_compat_init(void) { return 0; }
 static void sonypi_compat_exit(void) { }
 static void sonypi_compat_report_event(u8 event) { }
-#endif /* CONFIG_SONY_LAPTOP_OLD */
+#endif /* CONFIG_SONYPI_COMPAT */
 
 /*
  * ACPI callbacks
