From: Len Brown <lenb@kernel.org>
Subject: [PATCH 48/49] ACPI: Harden acpi_table_parse_entries() against BIOS bug
Date: Sat,  6 Oct 2012 22:43:18 -0400
Message-ID: <369d913b242cae2205471b11b6e33ac368ed33ec.1349554106.git.len.brown@intel.com>
References: <1349577799-566-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349577799-566-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Parsing acpi table entries may fall into an infinite loop on a buggy BIOS
which has entry length=0 in acpi table.

Instead of kernel hang with few failure clue which leads to heavy lifting debug
effort, this patch hardens kernel boot by booting into non NUMA mode. The debug
info left in log buffer helps people identify the issue.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/tables.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index f336bca7..2572d97 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -240,10 +240,17 @@ acpi_table_parse_entries(char *id,
 	       table_end) {
 		if (entry->type == entry_id
 		    && (!max_entries || count++ < max_entries))
-			if (handler(entry, table_end)) {
-				early_acpi_os_unmap_memory((char *)table_header, tbl_size);
-				return -EINVAL;
-			}
+			if (handler(entry, table_end))
+				goto err;
+
+		/*
+		 * If entry->length is 0, break from this loop to avoid
+		 * infinite loop.
+		 */
+		if (entry->length == 0) {
+			pr_err(PREFIX "[%4.4s:0x%02x] Invalid zero length\n", id, entry_id);
+			goto err;
+		}
 
 		entry = (struct acpi_subtable_header *)
 		    ((unsigned long)entry + entry->length);
@@ -255,6 +262,9 @@ acpi_table_parse_entries(char *id,
 
 	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
 	return count;
+err:
+	early_acpi_os_unmap_memory((char *)table_header, tbl_size);
+	return -EINVAL;
 }
 
 int __init
-- 
1.8.0.rc0.18.gf84667d
