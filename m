From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 6/6] acpi: Return -ENOENT in acpi_table_parse() and fix wrong comment.
Date: Fri, 16 Aug 2013 15:06:49 +0800
Message-ID: <1376636809-10159-7-git-send-email-tangchen@cn.fujitsu.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The comment about return value of acpi_table_parse() is incorrect.
This patch fix it.

Furthermore, if the table is not found, return 1 means nothing, and
make it difficult to write the comment. So return -ENOENT when the
table is not found, and correct the comment.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
 drivers/acpi/tables.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 5a5263b..e6de24f 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -278,12 +278,13 @@ acpi_table_parse_madt(enum acpi_madt_type id,
 
 /**
  * acpi_table_parse - find table with @id, run @handler on it
- *
  * @id: table id to find
  * @handler: handler to run
  *
  * Scan the ACPI System Descriptor Table (STD) for a table matching @id,
- * run @handler on it.  Return 0 if table found, return on if not.
+ * run @handler on it.
+ *
+ * Return 0 on success, -errno on failure.
  */
 int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 {
@@ -306,7 +307,7 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		early_acpi_os_unmap_memory(table, tbl_size);
 		return 0;
 	} else
-		return 1;
+		return -ENOENT;
 }
 
 /* 
-- 
1.7.1
