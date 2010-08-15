From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/20] ACPI, APEI, Rename CPER and GHES severity constants
Date: Sun, 15 Aug 2010 01:23:13 -0400
Message-ID: <ad4ecef2f13c790f95b55320f2925c205d8f971f.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:40668 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab0HOFXe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:34 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L760080PHN870R2@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:34 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Ying <ying.huang@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Huang Ying <ying.huang@intel.com>

The abbreviation of severity should be SEV instead of SER, so the CPER
severity constants are renamed accordingly. GHES severity constants
are renamed in the same way too.

Signed-off-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/mcheck/mce-apei.c |    4 ++--
 drivers/acpi/apei/ghes.c              |   32 ++++++++++++++++----------------
 include/linux/cper.h                  |    8 ++++----
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cpu/mcheck/mce-apei.c
index 745b54f..8209472 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
@@ -80,7 +80,7 @@ int apei_write_mce(struct mce *m)
 	rcd.hdr.revision = CPER_RECORD_REV;
 	rcd.hdr.signature_end = CPER_SIG_END;
 	rcd.hdr.section_count = 1;
-	rcd.hdr.error_severity = CPER_SER_FATAL;
+	rcd.hdr.error_severity = CPER_SEV_FATAL;
 	/* timestamp, platform_id, partition_id are all invalid */
 	rcd.hdr.validation_bits = 0;
 	rcd.hdr.record_length = sizeof(rcd);
@@ -96,7 +96,7 @@ int apei_write_mce(struct mce *m)
 	rcd.sec_hdr.validation_bits = 0;
 	rcd.sec_hdr.flags = CPER_SEC_PRIMARY;
 	rcd.sec_hdr.section_type = CPER_SECTION_TYPE_MCE;
-	rcd.sec_hdr.section_severity = CPER_SER_FATAL;
+	rcd.sec_hdr.section_severity = CPER_SEV_FATAL;
 
 	memcpy(&rcd.mce, m, sizeof(*m));
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fd0cc01..c76aff6 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -132,26 +132,26 @@ static void ghes_fini(struct ghes *ghes)
 }
 
 enum {
-	GHES_SER_NO = 0x0,
-	GHES_SER_CORRECTED = 0x1,
-	GHES_SER_RECOVERABLE = 0x2,
-	GHES_SER_PANIC = 0x3,
+	GHES_SEV_NO = 0x0,
+	GHES_SEV_CORRECTED = 0x1,
+	GHES_SEV_RECOVERABLE = 0x2,
+	GHES_SEV_PANIC = 0x3,
 };
 
 static inline int ghes_severity(int severity)
 {
 	switch (severity) {
-	case CPER_SER_INFORMATIONAL:
-		return GHES_SER_NO;
-	case CPER_SER_CORRECTED:
-		return GHES_SER_CORRECTED;
-	case CPER_SER_RECOVERABLE:
-		return GHES_SER_RECOVERABLE;
-	case CPER_SER_FATAL:
-		return GHES_SER_PANIC;
+	case CPER_SEV_INFORMATIONAL:
+		return GHES_SEV_NO;
+	case CPER_SEV_CORRECTED:
+		return GHES_SEV_CORRECTED;
+	case CPER_SEV_RECOVERABLE:
+		return GHES_SEV_RECOVERABLE;
+	case CPER_SEV_FATAL:
+		return GHES_SEV_PANIC;
 	default:
 		/* Unkown, go panic */
-		return GHES_SER_PANIC;
+		return GHES_SEV_PANIC;
 	}
 }
 
@@ -237,16 +237,16 @@ static void ghes_clear_estatus(struct ghes *ghes)
 
 static void ghes_do_proc(struct ghes *ghes)
 {
-	int ser, processed = 0;
+	int sev, processed = 0;
 	struct acpi_hest_generic_data *gdata;
 
-	ser = ghes_severity(ghes->estatus->error_severity);
+	sev = ghes_severity(ghes->estatus->error_severity);
 	apei_estatus_for_each_section(ghes->estatus, gdata) {
 #ifdef CONFIG_X86_MCE
 		if (!uuid_le_cmp(*(uuid_le *)gdata->section_type,
 				 CPER_SEC_PLATFORM_MEM)) {
 			apei_mce_report_mem_error(
-				ser == GHES_SER_CORRECTED,
+				sev == GHES_SEV_CORRECTED,
 				(struct cper_sec_mem_err *)(gdata+1));
 			processed = 1;
 		}
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4b38f90..bf972f8 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -39,10 +39,10 @@
  * Severity difinition for error_severity in struct cper_record_header
  * and section_severity in struct cper_section_descriptor
  */
-#define CPER_SER_RECOVERABLE			0x0
-#define CPER_SER_FATAL				0x1
-#define CPER_SER_CORRECTED			0x2
-#define CPER_SER_INFORMATIONAL			0x3
+#define CPER_SEV_RECOVERABLE			0x0
+#define CPER_SEV_FATAL				0x1
+#define CPER_SEV_CORRECTED			0x2
+#define CPER_SEV_INFORMATIONAL			0x3
 
 /*
  * Validation bits difinition for validation_bits in struct
-- 
1.7.2.1.95.g3d045

