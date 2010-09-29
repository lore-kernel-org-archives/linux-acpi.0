From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/16] ACPI: Fix typos
Date: Tue, 28 Sep 2010 23:44:39 -0400
Message-ID: <58f87ed0d45141a90167f34c0959d607160a26df.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:57984 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab0I2Dpe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:34 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H002QAP3HPZ13@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:19 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, Len Brown <len.brown@intel.com>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exutils.c    |    2 +-
 drivers/acpi/acpica/rsutils.c    |    2 +-
 drivers/acpi/apei/Kconfig        |    2 +-
 drivers/acpi/apei/erst-dbg.c     |    2 +-
 drivers/acpi/apei/erst.c         |    2 +-
 drivers/acpi/bus.c               |    4 ++--
 drivers/acpi/processor_perflib.c |    4 ++--
 include/acpi/acpixf.h            |    2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/acpica/exutils.c b/drivers/acpi/acpica/exutils.c
index 74c24d5..4093522 100644
--- a/drivers/acpi/acpica/exutils.c
+++ b/drivers/acpi/acpica/exutils.c
@@ -109,7 +109,7 @@ void acpi_ex_enter_interpreter(void)
  *
  * DESCRIPTION: Reacquire the interpreter execution region from within the
  *              interpreter code. Failure to enter the interpreter region is a
- *              fatal system error. Used in  conjuction with
+ *              fatal system error. Used in  conjunction with
  *              relinquish_interpreter
  *
  ******************************************************************************/
diff --git a/drivers/acpi/acpica/rsutils.c b/drivers/acpi/acpica/rsutils.c
index 22cfcfb..491191e 100644
--- a/drivers/acpi/acpica/rsutils.c
+++ b/drivers/acpi/acpica/rsutils.c
@@ -149,7 +149,7 @@ acpi_rs_move_data(void *destination, void *source, u16 item_count, u8 move_type)
 
 			/*
 			 * 16-, 32-, and 64-bit cases must use the move macros that perform
-			 * endian conversion and/or accomodate hardware that cannot perform
+			 * endian conversion and/or accommodate hardware that cannot perform
 			 * misaligned memory transfers
 			 */
 		case ACPI_RSC_MOVE16:
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 907e350..fca34cc 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -34,6 +34,6 @@ config ACPI_APEI_ERST_DEBUG
 	depends on ACPI_APEI
 	help
 	  ERST is a way provided by APEI to save and retrieve hardware
-	  error infomation to and from a persistent store. Enable this
+	  error information to and from a persistent store. Enable this
 	  if you want to debugging and testing the ERST kernel support
 	  and firmware implementation.
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 5281ddd..98ffa29 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -2,7 +2,7 @@
  * APEI Error Record Serialization Table debug support
  *
  * ERST is a way provided by APEI to save and retrieve hardware error
- * infomation to and from a persistent store. This file provide the
+ * information to and from a persistent store. This file provide the
  * debugging/testing support for ERST kernel support and firmware
  * implementation.
  *
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 18645f4..a4904f1 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -2,7 +2,7 @@
  * APEI Error Record Serialization Table support
  *
  * ERST is a way provided by APEI to save and retrieve hardware error
- * infomation to and from a persistent store.
+ * information to and from a persistent store.
  *
  * For more information about ERST, please refer to ACPI Specification
  * version 4.0, section 17.4.
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5c221ab..cc17b35 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -55,7 +55,7 @@ EXPORT_SYMBOL(acpi_root_dir);
 static int set_power_nocheck(const struct dmi_system_id *id)
 {
 	printk(KERN_NOTICE PREFIX "%s detected - "
-		"disable power check in power transistion\n", id->ident);
+		"disable power check in power transition\n", id->ident);
 	acpi_power_nocheck = 1;
 	return 0;
 }
@@ -1027,7 +1027,7 @@ static int __init acpi_init(void)
 
 	/*
 	 * If the laptop falls into the DMI check table, the power state check
-	 * will be disabled in the course of device power transistion.
+	 * will be disabled in the course of device power transition.
 	 */
 	dmi_check_system(power_nocheck_dmi_table);
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index ba1bd26..3a73a93 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -447,8 +447,8 @@ int acpi_processor_notify_smm(struct module *calling_module)
 	if (!try_module_get(calling_module))
 		return -EINVAL;
 
-	/* is_done is set to negative if an error occured,
-	 * and to postitive if _no_ error occured, but SMM
+	/* is_done is set to negative if an error occurred,
+	 * and to postitive if _no_ error occurred, but SMM
 	 * was already notified. This avoids double notification
 	 * which might lead to unexpected results...
 	 */
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index c0786d4..984cdc6 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -55,7 +55,7 @@
 extern u8 acpi_gbl_permanent_mmap;
 
 /*
- * Globals that are publically available, allowing for
+ * Globals that are publicly available, allowing for
  * run time configuration
  */
 extern u32 acpi_dbg_level;
-- 
1.7.3.2.g9027fa

