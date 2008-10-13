From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 6/6] ACPI: don't use empty filename for acpi tables sysfs
	I/F
Date: Mon, 13 Oct 2008 16:10:38 +0800
Message-ID: <1223885438.2735.190.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:29939 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbYJMIMe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Oct 2008 04:12:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, nokos@gmx.net, "Zhang, Rui" <rui.zhang@intel.com>

From: Peter Gruber <nokos@gmx.net>

For the ACPI tables with NULL table signature,
use "NULL" as the filename under /sys/firmware/acpi/tables/.

http://bugzilla.kernel.org/show_bug.cgi?id=11539

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/system.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

Index: linux-acpi-2.6/drivers/acpi/system.c
===================================================================
--- linux-acpi-2.6.orig/drivers/acpi/system.c
+++ linux-acpi-2.6/drivers/acpi/system.c
@@ -88,8 +88,10 @@ static ssize_t acpi_table_show(struct ko
 						table_attr->table_index,
 						&table_header);
 	else
-		status = acpi_get_table(table_attr->name, table_attr->instance,
-						&table_header);
+		status = acpi_get_table(strncmp(table_attr->name, "NULL",
+					ACPI_NAME_SIZE) ?
+					table_attr->name : "\0\0\0\0",
+					table_attr->instance, &table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
@@ -102,10 +104,14 @@ static void acpi_table_attr_init(struct 
 {
 	struct acpi_table_attr *attr = NULL;
 
-	memcpy(table_attr->name, table_header->signature, ACPI_NAME_SIZE);
+	if (table_header->signature[0] == '\0')
+		memcpy(table_attr->name, "NULL", ACPI_NAME_SIZE);
+	else
+		memcpy(table_attr->name, table_header->signature,
+			ACPI_NAME_SIZE);
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
-		if (!memcmp(table_header->signature, attr->name,
+		if (!memcmp(table_attr->name, attr->name,
 			    ACPI_NAME_SIZE) && (attr->flag == table_attr->flag))
 			if (table_attr->instance < attr->instance)
 				table_attr->instance = attr->instance;
@@ -113,7 +119,8 @@ static void acpi_table_attr_init(struct 
 	table_attr->instance++;
 
 	if (table_attr->instance > 1)
-		sprintf(table_attr->name + 4, "%d", table_attr->instance);
+		sprintf(table_attr->name + ACPI_NAME_SIZE,
+			"%d", table_attr->instance);
 
 	table_attr->attr.size = 0;
 	table_attr->attr.read = acpi_table_show;


