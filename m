From: Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 3/4] edac: Add new memory type for non-volatile DIMMs
Date: Thu, 30 Nov 2017 12:40:41 -0800
Message-ID: <862104c26398781e4937c3fca3994cbe75d820ff.1512070562.git.tony.luck@intel.com>
References: <cover.1512070562.git.tony.luck@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35880 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751023AbdK3Ukn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Nov 2017 15:40:43 -0500
In-Reply-To: <cover.1512070562.git.tony.luck@intel.com>
In-Reply-To: <cover.1512070562.git.tony.luck@intel.com>
References: <cover.1512070562.git.tony.luck@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-edac@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, Jean Delvare <jdelvare@suse.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, Lv Zheng <lv.zheng@intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, Aristeu Rozanski <aris@redhat.com>

There are now non-volatile versions of DIMMs. Add a new entry to
"enum mem_type" and update places that use it with new strings.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/edac_mc.c       | 1 +
 drivers/edac/edac_mc_sysfs.c | 3 ++-
 include/linux/edac.h         | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 480072139b7a..8178e74decbf 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -215,6 +215,7 @@ const char * const edac_mem_types[] = {
 	[MEM_LRDDR3]	= "Load-Reduced DDR3 RAM",
 	[MEM_DDR4]	= "Unbuffered DDR4 RAM",
 	[MEM_RDDR4]	= "Registered DDR4 RAM",
+	[MEM_NVDIMM]	= "Non-volatile RAM",
 };
 EXPORT_SYMBOL_GPL(edac_mem_types);
 
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index e4fcfa84fbd3..53cbb3518efc 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -110,7 +110,8 @@ static const char * const mem_types[] = {
 	[MEM_DDR3] = "Unbuffered-DDR3",
 	[MEM_RDDR3] = "Registered-DDR3",
 	[MEM_DDR4] = "Unbuffered-DDR4",
-	[MEM_RDDR4] = "Registered-DDR4"
+	[MEM_RDDR4] = "Registered-DDR4",
+	[MEM_NVDIMM] = "Non-volatile RAM",
 };
 
 static const char * const dev_types[] = {
diff --git a/include/linux/edac.h b/include/linux/edac.h
index cd75c173fd00..bffb97828ed6 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -186,6 +186,7 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_RDDR4:		Registered DDR4 RAM
  *			This is a variant of the DDR4 memories.
  * @MEM_LRDDR4:		Load-Reduced DDR4 memory.
+ * @MEM_NVDIMM:		Non-volatile RAM
  */
 enum mem_type {
 	MEM_EMPTY = 0,
@@ -209,6 +210,7 @@ enum mem_type {
 	MEM_DDR4,
 	MEM_RDDR4,
 	MEM_LRDDR4,
+	MEM_NVDIMM,
 };
 
 #define MEM_FLAG_EMPTY		BIT(MEM_EMPTY)
@@ -231,6 +233,7 @@ enum mem_type {
 #define MEM_FLAG_DDR4           BIT(MEM_DDR4)
 #define MEM_FLAG_RDDR4          BIT(MEM_RDDR4)
 #define MEM_FLAG_LRDDR4         BIT(MEM_LRDDR4)
+#define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
 
 /**
  * enum edac-type - Error Detection and Correction capabilities and mode
-- 
2.14.1

