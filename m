From: Joe Perches <joe@perches.com>
Subject: [PATCH 10/35] drivers/acpi: Convert remaining uses of pr_warning to pr_warn
Date: Thu, 16 Feb 2017 23:11:23 -0800
Message-ID: <454a626e0c01a3fbefa4f559853f47346f60af99.1487314667.git.joe@perches.com>
References: <cover.1487314666.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/acpi

Prior to this patch, there were 20 uses of pr_warning and
45 uses of pr_warn in drivers/acpi

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/acpi/apei/apei-base.c | 32 ++++++++++++++++----------------
 drivers/acpi/apei/einj.c      |  4 ++--
 drivers/acpi/apei/erst-dbg.c  |  4 ++--
 drivers/acpi/apei/ghes.c      | 30 ++++++++++++++----------------
 drivers/acpi/apei/hest.c      | 10 +++++-----
 drivers/acpi/resource.c       |  4 ++--
 6 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
index da370e1d31f4..63b7830c2498 100644
--- a/drivers/acpi/apei/apei-base.c
+++ b/drivers/acpi/apei/apei-base.c
@@ -178,9 +178,9 @@ int __apei_exec_run(struct apei_exec_context *ctx, u8 action,
 		if (ip == ctx->ip) {
 			if (entry->instruction >= ctx->instructions ||
 			    !ctx->ins_table[entry->instruction].run) {
-				pr_warning(FW_WARN APEI_PFX
+				pr_warn(FW_WARN APEI_PFX
 			"Invalid action table, unknown instruction type: %d\n",
-					   entry->instruction);
+					entry->instruction);
 				return -EINVAL;
 			}
 			run = ctx->ins_table[entry->instruction].run;
@@ -219,9 +219,9 @@ static int apei_exec_for_each_entry(struct apei_exec_context *ctx,
 		if (end)
 			*end = i;
 		if (ins >= ctx->instructions || !ins_table[ins].run) {
-			pr_warning(FW_WARN APEI_PFX
+			pr_warn(FW_WARN APEI_PFX
 			"Invalid action table, unknown instruction type: %d\n",
-				   ins);
+				ins);
 			return -EINVAL;
 		}
 		rc = func(ctx, entry, data);
@@ -587,18 +587,18 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 	space_id = reg->space_id;
 	*paddr = get_unaligned(&reg->address);
 	if (!*paddr) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid physical address in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 
 	if (access_size_code < 1 || access_size_code > 4) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid access size code in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 	*access_bit_width = 1UL << (access_size_code + 2);
@@ -612,19 +612,19 @@ static int apei_check_gar(struct acpi_generic_address *reg, u64 *paddr,
 		*access_bit_width = 64;
 
 	if ((bit_width + bit_offset) > *access_bit_width) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid bit width + offset in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 
 	if (space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY &&
 	    space_id != ACPI_ADR_SPACE_SYSTEM_IO) {
-		pr_warning(FW_BUG APEI_PFX
+		pr_warn(FW_BUG APEI_PFX
 			   "Invalid address space type in GAR [0x%llx/%u/%u/%u/%u]\n",
-			   *paddr, bit_width, bit_offset, access_size_code,
-			   space_id);
+			*paddr, bit_width, bit_offset, access_size_code,
+			space_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index ec50c32ea3da..730a594483f4 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -180,7 +180,7 @@ static int einj_get_available_error_type(u32 *type)
 static int einj_timedout(u64 *t)
 {
 	if ((s64)*t < SPIN_UNIT) {
-		pr_warning(FW_WARN "Firmware does not respond in time\n");
+		pr_warn(FW_WARN "Firmware does not respond in time\n");
 		return 1;
 	}
 	*t -= SPIN_UNIT;
@@ -320,7 +320,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
 	}
 	rc = einj_check_trigger_header(trigger_tab);
 	if (rc) {
-		pr_warning(FW_BUG "Invalid trigger error action table.\n");
+		pr_warn(FW_BUG "Invalid trigger error action table.\n");
 		goto out_rel_header;
 	}
 
diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 6330f557a2c8..795db6a8ddaf 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -126,9 +126,9 @@ static ssize_t erst_dbg_read(struct file *filp, char __user *ubuf,
 	if (rc < 0)
 		goto out;
 	if (len > ERST_DBG_RECORD_LEN_MAX) {
-		pr_warning(ERST_DBG_PFX
+		pr_warn(ERST_DBG_PFX
 			   "Record (ID: 0x%llx) length is too long: %zd\n",
-			   id, len);
+			id, len);
 		rc = -EIO;
 		goto out;
 	}
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index e53bef6cf53c..e86b0029b5a1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -254,10 +254,9 @@ static struct ghes *ghes_new(struct acpi_hest_generic *generic)
 		goto err_free;
 	error_block_length = generic->error_block_length;
 	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
-		pr_warning(FW_WARN GHES_PFX
-			   "Error status block length is too long: %u for "
-			   "generic hardware error source: %d.\n",
-			   error_block_length, generic->header.source_id);
+		pr_warn(FW_WARN GHES_PFX
+			   "Error status block length is too long: %u for generic hardware error source: %d.\n",
+			error_block_length, generic->header.source_id);
 		error_block_length = GHES_ESTATUS_MAX_SIZE;
 	}
 	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
@@ -345,9 +344,9 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 	rc = apei_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
 		if (!silent && printk_ratelimit())
-			pr_warning(FW_WARN GHES_PFX
+			pr_warn(FW_WARN GHES_PFX
 "Failed to read error status block address for hardware error source: %d.\n",
-				   g->header.source_id);
+				g->header.source_id);
 		return -EIO;
 	}
 	if (!buf_paddr)
@@ -378,7 +377,7 @@ static int ghes_read_estatus(struct ghes *ghes, int silent)
 
 err_read_block:
 	if (rc && !silent && printk_ratelimit())
-		pr_warning(FW_WARN GHES_PFX
+		pr_warn(FW_WARN GHES_PFX
 			   "Failed to read error status block!\n");
 	return rc;
 }
@@ -671,8 +670,8 @@ static void ghes_add_timer(struct ghes *ghes)
 	unsigned long expire;
 
 	if (!g->notify.poll_interval) {
-		pr_warning(FW_WARN GHES_PFX "Poll interval is 0 for generic hardware error source: %d, disabled.\n",
-			   g->header.source_id);
+		pr_warn(FW_WARN GHES_PFX "Poll interval is 0 for generic hardware error source: %d, disabled.\n",
+			g->header.source_id);
 		return;
 	}
 	expire = jiffies + msecs_to_jiffies(g->notify.poll_interval);
@@ -974,21 +973,20 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		}
 		break;
 	case ACPI_HEST_NOTIFY_LOCAL:
-		pr_warning(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
-			   generic->header.source_id);
+		pr_warn(GHES_PFX "Generic hardware error source: %d notified via local interrupt is not supported!\n",
+			generic->header.source_id);
 		goto err;
 	default:
-		pr_warning(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
-			   generic->notify.type, generic->header.source_id);
+		pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u for generic hardware error source: %d\n",
+			generic->notify.type, generic->header.source_id);
 		goto err;
 	}
 
 	rc = -EIO;
 	if (generic->error_block_length <
 	    sizeof(struct acpi_hest_generic_status)) {
-		pr_warning(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
-			   generic->error_block_length,
-			   generic->header.source_id);
+		pr_warn(FW_BUG GHES_PFX "Invalid error block length: %u for generic hardware error source: %d\n",
+			generic->error_block_length, generic->header.source_id);
 		goto err;
 	}
 	ghes = ghes_new(generic);
diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 8f2a98e23bba..107ca7a32c13 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -92,15 +92,15 @@ int apei_hest_parse(apei_hest_func_t func, void *data)
 	for (i = 0; i < hest_tab->error_source_count; i++) {
 		len = hest_esrc_len(hest_hdr);
 		if (!len) {
-			pr_warning(FW_WARN HEST_PFX
+			pr_warn(FW_WARN HEST_PFX
 				   "Unknown or unused hardware error source "
 				   "type: %d for hardware error source: %d.\n",
-				   hest_hdr->type, hest_hdr->source_id);
+				hest_hdr->type, hest_hdr->source_id);
 			return -EINVAL;
 		}
 		if ((void *)hest_hdr + len >
 		    (void *)hest_tab + hest_tab->header.length) {
-			pr_warning(FW_BUG HEST_PFX
+			pr_warn(FW_BUG HEST_PFX
 		"Table contents overflow for hardware error source: %d.\n",
 				hest_hdr->source_id);
 			return -EINVAL;
@@ -162,8 +162,8 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 		ghes_dev = ghes_arr->ghes_devs[i];
 		hdr = *(struct acpi_hest_header **)ghes_dev->dev.platform_data;
 		if (hdr->source_id == hest_hdr->source_id) {
-			pr_warning(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
-				   hdr->source_id);
+			pr_warn(FW_WARN HEST_PFX "Duplicated hardware error source ID: %d.\n",
+				hdr->source_id);
 			return -EIO;
 		}
 	}
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cd4c4271dc4c..0f490ff21121 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -420,8 +420,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
 		if (triggering != trig || polarity != pol) {
-			pr_warning("ACPI: IRQ %d override to %s, %s\n", gsi,
-				   t ? "level" : "edge", p ? "low" : "high");
+			pr_warn("ACPI: IRQ %d override to %s, %s\n",
+				gsi, t ? "level" : "edge", p ? "low" : "high");
 			triggering = trig;
 			polarity = pol;
 		}
-- 
2.10.0.rc2.1.g053435c
