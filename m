From: akpm@linux-foundation.org
Subject: [patch 1/2] acpi: check _PSS invalidation when BIOS report _PSS with 0x80000000
Date: Thu, 11 Dec 2008 09:00:11 -0800
Message-ID: <200812111700.mBBH0BQt017390@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41409 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757444AbYLKRAj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Dec 2008 12:00:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com

From: Youquan, Song <youquan.song@intel.com>

When cpu frequencey scaling is disabled, some BIOSes report _PSS with all
0x80000000.  If the kernel treats this case as valid, the kernel will boot
crash when load cpufreq govenors.

So in order to cover more buggy BIOSs, the patch just check _PSS core
frequency invalidation.

Signed-off-by: Youquan, Song <youquan.song@intel.com>
Signed-off-by: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/processor_perflib.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff -puN drivers/acpi/processor_perflib.c~acpi-check-_pss-invalidation-when-bios-report-_pss-with-all-0x80000000 drivers/acpi/processor_perflib.c
--- a/drivers/acpi/processor_perflib.c~acpi-check-_pss-invalidation-when-bios-report-_pss-with-all-0x80000000
+++ a/drivers/acpi/processor_perflib.c
@@ -50,6 +50,7 @@
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
+#define ACPI_PROCESSOR_PSS_INVALID	0x80000000
 ACPI_MODULE_NAME("processor_perflib");
 
 static DEFINE_MUTEX(performance_mutex);
@@ -324,6 +325,14 @@ static int acpi_processor_get_performanc
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
_
