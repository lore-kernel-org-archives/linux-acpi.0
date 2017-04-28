From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 3/4] ACPI: sysfs: Fix acpi_get_table() leak
Date: Fri, 28 Apr 2017 13:30:26 +0800
Message-ID: <4fc8ea10af02eeaea5d7cb2bc8625ddc47cd6c16.1493357251.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:48360 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164575AbdD1Fab (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 28 Apr 2017 01:30:31 -0400
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

From: Dan Williams <dan.j.williams@intel.com>

Reading an ACPI table through the /sys/firmware/acpi/tables interface
more than 65,536 times leads to the following log message:

 ACPI Error: Table ffff88033595eaa8, Validation count is zero after
increment
  (20170119/tbutils-423)

Add the missing acpi_put_table() so the table ->validation_count is
decremented after each read.

Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/sysfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 1b5ee1e..2bbf722 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -333,14 +333,17 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
+	ssize_t len;
 
 	status = acpi_get_table(table_attr->name, table_attr->instance,
 				&table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	return memory_read_from_buffer(buf, count, &offset,
-				       table_header, table_header->length);
+	len = memory_read_from_buffer(buf, count, &offset,
+				      table_header, table_header->length);
+	acpi_put_table(table_header);
+	return len;
 }
 
 static int acpi_table_attr_init(struct kobject *tables_obj,
-- 
2.7.4

