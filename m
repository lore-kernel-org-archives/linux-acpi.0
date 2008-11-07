From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/21] ACPI: avoid empty file name in sysfs
Date: Thu, 06 Nov 2008 23:39:24 -0500
Message-ID: <4feba70a2c1a1a0c96909f657f48b2e11e682370.1226032677.git.len.brown@intel.com>
References: <1226032765-15330-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:36457 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbYKGEji (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:39:38 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y006BA4XY9K51@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:39:35 -0600 (CST)
In-reply-to: <1226032765-15330-1-git-send-email-lenb@kernel.org>
In-reply-to: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
References: <2830c9fb8e66cee70b8bffdfb0de01c144c7e643.1226032677.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Gruber <nokos@gmx.net>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Peter Gruber <nokos@gmx.net>

Since commit bc45b1d39a925b56796bebf8a397a0491489d85c acpi tables are
allowed to have an empty signature and /sys/firmware/acpi/tables uses the
signature as filename.  Applications using naive recursion through /sys
loop forever.  A possible solution would be: (replacing the zero length
filename with the string "NULL")

http://bugzilla.kernel.org/show_bug.cgi?id=11539

Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/system.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 1d74171..62ec75e 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -78,9 +78,15 @@ static ssize_t acpi_table_show(struct kobject *kobj,
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
+	char name[ACPI_NAME_SIZE];
+
+	if (strncmp(table_attr->name, "NULL", 4))
+		memcpy(name, table_attr->name, ACPI_NAME_SIZE);
+	else
+		memcpy(name, "\0\0\0\0", 4);
 
 	status =
-	    acpi_get_table(table_attr->name, table_attr->instance,
+	    acpi_get_table(name, table_attr->instance,
 			   &table_header);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
@@ -95,21 +101,24 @@ static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
 	struct acpi_table_header *header = NULL;
 	struct acpi_table_attr *attr = NULL;
 
-	memcpy(table_attr->name, table_header->signature, ACPI_NAME_SIZE);
+	if (table_header->signature[0] != '\0')
+		memcpy(table_attr->name, table_header->signature,
+			ACPI_NAME_SIZE);
+	else
+		memcpy(table_attr->name, "NULL", 4);
 
 	list_for_each_entry(attr, &acpi_table_attr_list, node) {
-		if (!memcmp(table_header->signature, attr->name,
-			    ACPI_NAME_SIZE))
+		if (!memcmp(table_attr->name, attr->name, ACPI_NAME_SIZE))
 			if (table_attr->instance < attr->instance)
 				table_attr->instance = attr->instance;
 	}
 	table_attr->instance++;
 
 	if (table_attr->instance > 1 || (table_attr->instance == 1 &&
-					 !acpi_get_table(table_header->
-							 signature, 2,
-							 &header)))
-		sprintf(table_attr->name + 4, "%d", table_attr->instance);
+					!acpi_get_table
+					(table_header->signature, 2, &header)))
+		sprintf(table_attr->name + ACPI_NAME_SIZE, "%d",
+			table_attr->instance);
 
 	table_attr->attr.size = 0;
 	table_attr->attr.read = acpi_table_show;
-- 
1.5.6.5

