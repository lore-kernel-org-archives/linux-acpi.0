From: youquan_song@linux.intel.com
Subject: [PATCH]  ACPI: Check _PSS invalidation when BIOS report _PSS with
     all 0x80000000
Date: Thu, 20 Nov 2008 19:08:36 -0800 (PST)
Message-ID: <3606.172.16.183.72.1227236916.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:55611 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752418AbYKUDIi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Nov 2008 22:08:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, len.brown@intel.com, linux-kernel@vger.kernel.org

Subject: Check _PSS invalidation when BIOS report _PSS with 0x80000000

When cpu frequencey scaling disable,some BIOS report _PSS with all
0x80000000.
If kernel treat this case as valid, the kernel will boot crash when load
cpufreq govenors.

So in order to cover more buggy BIOSs, the patch just check _PSS core
frequencey invalidtion.

Signed-off-by: Youquan, Song <youquan.song@intel.com>
Signed-off-by: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
---

--- linux-2.6-tip-orignal/drivers/acpi/processor_perflib.c	2008-11-20
12:25:05.000000000 -0500
+++ linux-2.6-tip/drivers/acpi/processor_perflib.c	2008-11-20
12:23:57.000000000 -0500
@@ -50,6 +50,7 @@
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
+#define ACPI_PROCESSOR_PSS_INVALID	0x80000000
 ACPI_MODULE_NAME("processor_perflib");

 static DEFINE_MUTEX(performance_mutex);
@@ -324,6 +325,14 @@
 			kfree(pr->performance->states);
 			goto end;
 		}
+
+		if (px->core_frequency == ACPI_PROCESSOR_PSS_INVALID) {
+			printk(KERN_ERR PREFIX
+				    "P-states disabled in the BIOS\n");
+			result = -EFAULT;
+			kfree(pr->performance->states);
+			goto end;
+		}
 	}

       end:
