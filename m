From: Wang Long <long.wanglong@huawei.com>
Subject: [PATCH 1/2] apei/*.c: use pr_warn instead of pr_warning
Date: Mon, 15 Jun 2015 09:57:29 +0000
Message-ID: <1434362250-217135-1-git-send-email-long.wanglong@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:41271 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbbFOJ54 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jun 2015 05:57:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com
Cc: tony.luck@intel.com, bp@suse.de, gong.chen@linux.intel.com, long.wanglong@huawei.com, tomasz.nowicki@linaro.org, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, wanglong@laoqinren.net, peifeiyue@huawei.com

This patch can avoid the following WARNING when run
checkpatch.pl:
	WARNING: Prefer pr_warn(... to pr_warning(...
	#21: FILE: drivers/acpi/apei/erst-dbg.c:134:
	+		pr_warning("Record (ID: 0x%llx) length is too long: %zd\n",

Signed-off-by: Wang Long <long.wanglong@huawei.com>
---
 drivers/acpi/apei/apei-base.c | 12 ++++++------
 drivers/acpi/apei/einj.c      |  6 +++---
 drivers/acpi/apei/erst-dbg.c  |  2 +-
 drivers/acpi/apei/ghes.c      | 14 +++++++-------
 drivers/acpi/apei/hest.c      |  6 +++---
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index a85ac07..5e85af3 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -182,7 +182,7 @@ rewind:
 		if (ip == ctx->ip) {
 			if (entry->instruction >= ctx->instructions ||
 			    !ctx->ins_table[entry->instruction].run) {
-				pr_warning(FW_WARN APEI_PFX
+				pr_warn(FW_WARN APEI_PFX
 			"Invalid action table, unknown instruction type: %d\n",
 					   entry->instruction);
 				return -EINVAL;
@@ -223,7 +223,7 @@ static int apei_exec_for_each_entry(struct apei_exec_context *ctx,
 		if (end)
 			*end = i;
 		if (ins >= ctx->instructions || !ins_table[ins].run) {
-			pr_warning(FW_WARN APEI_PFX
+			pr_warn(FW_WARN APEI_PFX
 			"Invalid action table, unknown instruction type: %d\n",
 				   ins);
 			return -EINVAL;
@@ -589,7 +589,7 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	space_id = reg->space_id;
 	*paddr = get_unaligned(&reg->address);
 	if (!*paddr) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid physical address in GAR [0x%llx/%u/%u/%u/%u]\n",
 			   *paddr, bit_width, bit_offset, access_size_code,
 			   space_id);
@@ -597,7 +597,7 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	}
 
 	if (access_size_code < 1 || access_size_code > 4) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid access size code in GAR [0x%llx/%u/%u/%u/%u]\n",
 			   *paddr, bit_width, bit_offset, access_size_code,
 			   space_id);
@@ -614,7 +614,7 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 		*access_bit_width = 64;
 
 	if ((bit_width + bit_offset) > *access_bit_width) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
 			   *paddr, bit_width, bit_offset, access_size_code,
 			   space_id);
@@ -623,7 +623,7 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 
 	if (space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
 	    space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid address space type in GAR [0x%llx/%u/%u/%u/%u]\n",
 			   *paddr, bit_width, bit_offset, access_size_code,
 			   space_id);
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index a095d4f..ff3daca 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -183,7 +183,7 @@ static int einj_get_available_error_type(u32 *type)
 static int einj_timedout(u64 *t)
 {
 	if ((s64)*t < SPIN_UNIT) {
-		pr_warning(FW_WARN EINJ_PFX
+		pr_warn(FW_WARN EINJ_PFX
 			   "Firmware does not respond in time\n");
 		return 1;
 	}
@@ -325,7 +325,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	}
 	rc = einj_check_trigger_header(trigger_tab);
 	if (rc) {
-		pr_warning(FW_BUG EINJ_PFX
+		pr_warn(FW_BUG EINJ_PFX
 			   "The trigger error action table is invalid\n");
 		goto out_rel_header;
 	}
@@ -707,7 +707,7 @@ static int __init einj_init(void)
 
 	rc = einj_check_table(einj_tab);
 	if (rc) {
-		pr_warning(FW_BUG EINJ_PFX "EINJ table is invalid\n");
+		pr_warn(FW_BUG EINJ_PFX "EINJ table is invalid\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 04ab5c9..3a57ffb 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -130,7 +130,7 @@ retry:
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
-		pr_warning(ERST_DBG_PFX
+		pr_warn(ERST_DBG_PFX
 			   "Record (ID: 0x%llx) length is too long: %zd\n",
 			   id, len);
 		rc = -EIO;
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e82d097..1d4dd1c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -249,7 +249,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		goto err_free;
 	error_block_length = generic->error_block_length;
 	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
-		pr_warning(FW_WARN GHES_PFX
+		pr_warn(FW_WARN GHES_PFX
 			   "Error status block length is too long: %u for "
 			   "generic hardware error source: %d.\n",
 			   error_block_length, generic->header.source_id);
@@ -340,7 +340,7 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 	rc = apei_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
 		if (!silent && printk_ratelimit())
-			pr_warning(FW_WARN GHES_PFX
+			pr_warn(FW_WARN GHES_PFX
 "Failed to read error status block address for hardware error source: %d.\n",
 				   g->header.source_id);
 		return -EIO;
@@ -373,7 +373,7 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 
 err_read_block:
 	if (rc && !silent && printk_ratelimit())
-		pr_warning(FW_WARN GHES_PFX
+		pr_warn(FW_WARN GHES_PFX
 			   "Failed to read error status block!\n");
 	return rc;
 }
@@ -666,7 +666,7 @@ static void ghes_add_timer(struct ghes *ghes)
 	unsigned long expire;
 
 	if (!g->notify.poll_interval) {
-		pr_warning(FW_WARN GHES_PFX "Poll interval is 0 for generic hardware error source: %d, disabled.\n",
+		pr_warn(FW_WARN GHES_PFX "Poll interval is 0 for generic hardware error source: %d, disabled.\n",
 			   g->header.source_id);
 		return;
 	}
@@ -966,11 +966,11 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		}
 		break;
 	case ACPI_HEST_NOTIFY_LOCAL:
-		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
+		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
 			   generic->header.source_id);
 		goto err;
 	default:
-		pr_warning(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
+		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
 			   generic->notify.type, generic->header.source_id);
 		goto err;
 	}
@@ -978,7 +978,7 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	rc = -EIO;
 	if (generic->error_block_length <
 	    sizeof(struct acpi_hest_generic_status)) {
-		pr_warning(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
+		pr_warn(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
 			   generic->error_block_length,
 			   generic->header.source_id);
 		goto err;
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 06e9b41..56f47fb 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -96,7 +96,7 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 	for (i = 0; i < hest_tab->error_source_count; i++) {
 		len = hest_esrc_len(hest_hdr);
 		if (!len) {
-			pr_warning(FW_WARN HEST_PFX
+			pr_warn(FW_WARN HEST_PFX
 				   "Unknown or unused hardware error source "
 				   "type: %d for hardware error source: %d.\n",
 				   hest_hdr->type, hest_hdr->source_id);
@@ -104,7 +104,7 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 		}
 		if ((void *)hest_hdr + len >
 		    (void *)hest_tab + hest_tab->header.length) {
-			pr_warning(FW_BUG HEST_PFX
+			pr_warn(FW_BUG HEST_PFX
 		"Table contents overflow for hardware error source: %d.\n",
 				hest_hdr->source_id);
 			return -EINVAL;
@@ -160,7 +160,7 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 		ghes_dev = ghes_arr->ghes_devs[i];
 		hdr = *(struct acpi_hest_header **)ghes_dev->dev.platform_data;
 		if (hdr->source_id == hest_hdr->source_id) {
-			pr_warning(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
+			pr_warn(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
 				   hdr->source_id);
 			return -EIO;
 		}
-- 
1.8.3.4

