From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/9] ACPI processor: Debug interface used for error message cleanup
Date: Wed, 30 Jul 2008 22:22:16 +0200
Message-ID: <1217449342-20312-4-git-send-email-trenn@suse.de>
References: <1217449342-20312-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49433 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756398AbYG3UWZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Jul 2008 16:22:25 -0400
In-Reply-To: <1217449342-20312-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/processor_perflib.c    |   21 ++++++++++-----------
 drivers/acpi/processor_throttling.c |   17 ++++++-----------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index b474996..f643068 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -512,14 +512,13 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 	}
 
 	psd = buffer.pointer;
-	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
-		result = -EFAULT;
-		goto end;
-	}
-
-	if (psd->package.count != 1) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+	if (!psd || (psd->type != ACPI_TYPE_PACKAGE)
+	    || psd->package.count != 1) {
+		/*
+		 * ToDo: Mark it as BIOS bug as soon as there is an interface
+		 *        for it
+		 */
+		printk(KERN_ERR "Invalid _PSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -532,19 +531,19 @@ static int acpi_processor_get_psd(struct acpi_processor	*pr)
 	status = acpi_extract_package(&(psd->package.elements[0]),
 		&format, &state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _PSD data\n"));
+		ACPI_ERROR((DB_INFO, status, "Invalid _PSD data\n"));
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->num_entries != ACPI_PSD_REV0_ENTRIES) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:num_entries\n"));
+		printk(KERN_ERR "Unknown _PSD:num_entries\n");
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->revision != ACPI_PSD_REV0_REVISION) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _PSD:revision\n"));
+		printk(KERN_ERR "Unknown _PSD:revision\n"));
 		result = -EFAULT;
 		goto end;
 	}
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 0622ace..95de498 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -527,14 +527,9 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	}
 
 	tsd = buffer.pointer;
-	if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
-		result = -EFAULT;
-		goto end;
-	}
-
-	if (tsd->package.count != 1) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+	if (!tsd || (tsd->type != ACPI_TYPE_PACKAGE)
+	    || tsd->package.count != 1) {
+		printk(KERN_INFO "Invalid _TSD data\n");
 		result = -EFAULT;
 		goto end;
 	}
@@ -547,19 +542,19 @@ static int acpi_processor_get_tsd(struct acpi_processor *pr)
 	status = acpi_extract_package(&(tsd->package.elements[0]),
 				      &format, &state);
 	if (ACPI_FAILURE(status)) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _TSD data\n"));
+		ACPI_ERROR(DB_INFO, status, "Invalid _TSD data\n"));
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->num_entries != ACPI_TSD_REV0_ENTRIES) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:num_entries\n"));
+		printk(KERN_ERR "Unknown _TSD:num_entries\n"));
 		result = -EFAULT;
 		goto end;
 	}
 
 	if (pdomain->revision != ACPI_TSD_REV0_REVISION) {
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unknown _TSD:revision\n"));
+		printk(KERN_ERR "Unknown _TSD:revision\n"));
 		result = -EFAULT;
 		goto end;
 	}
-- 
1.5.4.5

