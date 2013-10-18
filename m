From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH v3 9/9] EDAC, GHES: Update ghes error record info
Date: Fri, 18 Oct 2013 04:23:44 -0400
Message-ID: <1382084624-10857-10-git-send-email-gong.chen@linux.intel.com>
References: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382084624-10857-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, joe@perches.com, naveen.n.rao@linux.vnet.ibm.com, m.chehab@samsung.com
Cc: arozansk@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

In latest UEFI spec(by now it's 2.4) there are some new
fields for memory error reporting. Add these new fields for
ghes_edac interface.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 drivers/edac/ghes_edac.c | 11 +++++++++++
 include/linux/edac.h     |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 0ad797b..d5a98a4 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -314,6 +314,8 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 		p += sprintf(p, "card:%d ", mem_err->card);
 	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE)
 		p += sprintf(p, "module:%d ", mem_err->module);
+	if (mem_err->validation_bits & CPER_MEM_VALID_RANK_NUMBER)
+		p += sprintf(p, "rank:%d ", mem_err->rank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
 		p += sprintf(p, "bank:%d ", mem_err->bank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
@@ -322,6 +324,15 @@ void ghes_edac_report_mem_error(struct ghes *ghes, int sev,
 		p += sprintf(p, "col:%d ", mem_err->column);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
 		p += sprintf(p, "bit_pos:%d ", mem_err->bit_pos);
+	if (mem_err->validation_bits & CPER_MEM_VALID_MODULE_HANDLE) {
+		const char *bank = NULL, *device = NULL;
+		dmi_memdev_name(mem_err->mem_dev_handle, &bank, &device);
+		if (bank != NULL && device != NULL)
+			p += sprintf(p, "DIMM location:%s %s ", bank, device);
+		else
+			p += sprintf(p, "DIMM DMI handle: 0x%.4x ",
+				     mem_err->mem_dev_handle);
+	}
 	if (p > e->location)
 		*(p - 1) = '\0';
 
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 5c6d7fb..dbdffe8 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -51,7 +51,7 @@ static inline void opstate_init(void)
 #define EDAC_MC_LABEL_LEN	31
 
 /* Maximum size of the location string */
-#define LOCATION_SIZE 80
+#define LOCATION_SIZE 256
 
 /* Defines the maximum number of labels that can be reported */
 #define EDAC_MAX_LABELS		8
-- 
1.8.4.rc3
