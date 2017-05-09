From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v4 3/4] ACPI: sysfs: Fix acpi_get_table() leak
Date: Tue,  9 May 2017 13:57:48 +0800
Message-ID: <a3b97a562302b87f815081ac40b9079afa5c3c71.1494309338.git.lv.zheng@intel.com>
References: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5361b51c7c257b3216475018a3a5cc4f8b6b21c6.1493281247.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

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
