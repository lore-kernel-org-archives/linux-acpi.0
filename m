From: Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/6] btt: refactor map entry operations with macros
Date: Fri, 14 Jul 2017 16:11:44 -0600
Message-ID: <20170714221148.11232-3-vishal.l.verma@intel.com>
References: <20170714221148.11232-1-vishal.l.verma@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:17627 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdGNWN3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Jul 2017 18:13:29 -0400
In-Reply-To: <20170714221148.11232-1-vishal.l.verma@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Jeff Moyer <jmoyer@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Toshi Kani <toshi.kani@hpe.com>, Vishal Verma <vishal.l.verma@intel.com>

Add helpers for converting a raw map entry to just the block number, or
either of the 'e' or 'z' flags in preparation for actually using the
error flag to mark blocks with media errors.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/nvdimm/btt.c | 8 ++++----
 drivers/nvdimm/btt.h | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 52aa96f..3aa6bc0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -106,7 +106,7 @@ static int btt_map_write(struct arena_info *arena, u32 lba, u32 mapping,
 	 * This 'mapping' is supposed to be just the LBA mapping, without
 	 * any flags set, so strip the flag bits.
 	 */
-	mapping &= MAP_LBA_MASK;
+	mapping = ent_lba(mapping);
 
 	ze = (z_flag << 1) + e_flag;
 	switch (ze) {
@@ -155,10 +155,10 @@ static int btt_map_read(struct arena_info *arena, u32 lba, u32 *mapping,
 
 	raw_mapping = le32_to_cpu(in);
 
-	z_flag = (raw_mapping & MAP_TRIM_MASK) >> MAP_TRIM_SHIFT;
-	e_flag = (raw_mapping & MAP_ERR_MASK) >> MAP_ERR_SHIFT;
+	z_flag = ent_z_flag(raw_mapping);
+	e_flag = ent_e_flag(raw_mapping);
 	ze = (z_flag << 1) + e_flag;
-	postmap = raw_mapping & MAP_LBA_MASK;
+	postmap = ent_lba(raw_mapping);
 
 	/* Reuse the {z,e}_flag variables for *trim and *error */
 	z_flag = 0;
diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index 888e862..09fabf5 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -38,6 +38,10 @@
 #define IB_FLAG_ERROR 0x00000001
 #define IB_FLAG_ERROR_MASK 0x00000001
 
+#define ent_lba(ent) (ent & MAP_LBA_MASK)
+#define ent_e_flag(ent) (!!(ent & MAP_ERR_MASK))
+#define ent_z_flag(ent) (!!(ent & MAP_TRIM_MASK))
+
 enum btt_init_state {
 	INIT_UNCHECKED = 0,
 	INIT_NOTFOUND,
-- 
2.9.3

