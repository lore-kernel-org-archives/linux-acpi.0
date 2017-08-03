From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH] acpi: apei: fix GHES estatus iteration
Date: Thu,  3 Aug 2017 15:32:25 -0600
Message-ID: <1501795945-5331-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, james.morse@arm.com, bp@suse.de, shiju.jose@huawei.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, austinwc@codeaurora.org
Cc: Tyler Baicar <tbaicar@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

Currently iterating through the GHES estatus blocks does not
take into account the new generic data v3 structure size. This
can result in garbage non-standard trace events to be triggered
since the loop will not properly iterate through the estatus
blocks and not properly terminate.

Update the GHES estatus iteration to properly increment through
the estatus blocks similar to how the CPER estatus printing
iterates through them.

Fixes: bbcc2e7b642e ("ras: acpi/apei: cper: add support for generic data v3 structure")
Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Tested-by: Austin Christ <austinwc@codeaurora.org>
---
 drivers/acpi/apei/apei-internal.h | 5 -----
 drivers/acpi/apei/ghes.c          | 8 +++++++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 6e9f14c..cb41260 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -120,11 +120,6 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
 struct dentry;
 struct dentry *apei_get_debugfs_dir(void);
 
-#define apei_estatus_for_each_section(estatus, section)			\
-	for (section = (struct acpi_hest_generic_data *)(estatus + 1);	\
-	     (void *)section - (void *)estatus < estatus->data_length;	\
-	     section = (void *)(section+1) + section->error_data_length)
-
 static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 {
 	if (estatus->raw_data_length)
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6a6895a..dba1771 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -466,9 +466,13 @@ static void ghes_do_proc(struct ghes *ghes,
 	guid_t *sec_type;
 	guid_t *fru_id = &NULL_UUID_LE;
 	char *fru_text = "";
+	unsigned int data_len;
 
 	sev = ghes_severity(estatus->error_severity);
-	apei_estatus_for_each_section(estatus, gdata) {
+	data_len = estatus->data_length;
+	gdata = (struct acpi_hest_generic_data *)(estatus + 1);
+
+	while (data_len >= acpi_hest_get_size(gdata)) {
 		sec_type = (guid_t *)gdata->section_type;
 		sec_sev = ghes_severity(gdata->error_severity);
 		if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
@@ -528,6 +532,8 @@ static void ghes_do_proc(struct ghes *ghes,
 					       sec_sev, err,
 					       gdata->error_data_length);
 		}
+		data_len -= acpi_hest_get_record_size(gdata);
+		gdata = acpi_hest_get_next(gdata);
 	}
 }
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
