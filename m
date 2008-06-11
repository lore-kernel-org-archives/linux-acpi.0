From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/23] ACPI: use memory_read_from_buffer()
Date: Wed, 11 Jun 2008 03:59:19 -0400
Message-ID: <3e7c8720e1d10da045edd4d758af322ef5ac775e.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:57809 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbYFKH7k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:40 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2A00KWNGVA0N8B@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:35 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Akinobu Mita <akinobu.mita@gmail.com>

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/system.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/system.c b/drivers/acpi/system.c
index 769f248..5bd2dec 100644
--- a/drivers/acpi/system.c
+++ b/drivers/acpi/system.c
@@ -77,7 +77,6 @@ static ssize_t acpi_table_show(struct kobject *kobj,
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
-	ssize_t ret_count = count;
 
 	status =
 	    acpi_get_table(table_attr->name, table_attr->instance,
@@ -85,18 +84,8 @@ static ssize_t acpi_table_show(struct kobject *kobj,
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	if (offset >= table_header->length) {
-		ret_count = 0;
-		goto end;
-	}
-
-	if (offset + ret_count > table_header->length)
-		ret_count = table_header->length - offset;
-
-	memcpy(buf, ((char *)table_header) + offset, ret_count);
-
-      end:
-	return ret_count;
+	return memory_read_from_buffer(buf, count, &offset,
+					table_header, table_header->length);
 }
 
 static void acpi_table_attr_init(struct acpi_table_attr *table_attr,
-- 
1.5.6.rc2.23.gea81e

