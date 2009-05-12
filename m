From: akpm@linux-foundation.org
Subject: [patch 1/3] acpi: check _PSS invalidation when BIOS report _PSS with 0x80000000
Date: Tue, 12 May 2009 13:35:25 -0700
Message-ID: <200905122054.n4CKsfa3001669@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44194 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612AbZELU6l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 May 2009 16:58:41 -0400
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

On Sun, 15 Mar 2009 23:22:37 -0400 (EDT) Len Brown <lenb@kernel.org> wrote:

> NAK -- per previous discussion on the list.
> 
> This patch is not the right way to address this issue,
> which is reported here, BTW:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=467941

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
@@ -42,6 +42,7 @@
 #define ACPI_PROCESSOR_CLASS		"processor"
 #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
 #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
+#define ACPI_PROCESSOR_PSS_INVALID	0x80000000
 ACPI_MODULE_NAME("processor_perflib");
 
 static DEFINE_MUTEX(performance_mutex);
@@ -316,6 +317,14 @@ static int acpi_processor_get_performanc
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
