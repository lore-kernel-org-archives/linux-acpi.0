From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ACPI / tables: test the correct variable
Date: Tue, 22 Sep 2015 15:29:25 +0300
Message-ID: <20150922122925.GA27407@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The intent was to test "proc[i].handler" instead of "proc->handler".

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index c1ff58d..6c0f079 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -268,7 +268,8 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 		for (i = 0; i < proc_num; i++) {
 			if (entry->type != proc[i].id)
 				continue;
-			if (!proc->handler || proc[i].handler(entry, table_end))
+			if (!proc[i].handler ||
+			     proc[i].handler(entry, table_end))
 				return -EINVAL;
 
 			proc->count++;
