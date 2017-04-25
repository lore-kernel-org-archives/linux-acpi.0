From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] acpi: fix acpi_get_table() leak / acpi-sysfs denial of
 service
Date: Tue, 25 Apr 2017 12:39:20 -0700
Message-ID: <149314916034.8899.7439820192725219189.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:61489 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1433130AbdDYTpN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Apr 2017 15:45:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: Anush Seetharaman <anush.seetharaman@intel.com>, Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>, Ryon Jensen <ryon.jensen@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-acpi@vger.kernel.org, Kristin Jacque <kristin.jacque@intel.com>, Zhang Rui <rui.zhang@intel.com>

Reading an ACPI table through the /sys/firmware/acpi/tables interface
more than 65,536 times leads to the following log message:

 ACPI Error: Table ffff88033595eaa8, Validation count is zero after increment
  (20170119/tbutils-423)

...and the table being unavailable until the next reboot. Add the
missing acpi_put_table() so the table ->validation_count is decremented
after each read.

Cc: <stable@vger.kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>
Cc: Kristin Jacque <kristin.jacque@intel.com>
Cc: Tiffany Kasanicky <tiffany.j.kasanicky@intel.com>
Cc: Ryon Jensen <ryon.jensen@intel.com>
Reported-by: Anush Seetharaman <anush.seetharaman@intel.com>
Fixes: 1c8fce27e275 ("ACPI: introduce drivers/acpi/sysfs.c")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/sysfs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index cf05ae973381..531ddabf0390 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -333,14 +333,17 @@ static ssize_t acpi_table_show(struct file *filp, struct kobject *kobj,
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
+	ssize_t rc;
 
 	status = acpi_get_table(table_attr->name, table_attr->instance,
 				&table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	return memory_read_from_buffer(buf, count, &offset,
-				       table_header, table_header->length);
+	rc = memory_read_from_buffer(buf, count, &offset, table_header,
+			table_header->length);
+	acpi_put_table(table);
+	return rc;
 }
 
 static int acpi_table_attr_init(struct kobject *tables_obj,

