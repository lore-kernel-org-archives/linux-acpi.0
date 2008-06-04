From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: [patch -v3 16/22] acpi: use memory_read_from_buffer
Date: Wed, 04 Jun 2008 20:56:49 +0900
Message-ID: <20080604115824.062644468@gmail.com>
References: <20080604115633.116832712@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:42730 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760215AbYFDMKp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Jun 2008 08:10:45 -0400
Received: by rv-out-0506.google.com with SMTP id l9so79958rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 04 Jun 2008 05:10:44 -0700 (PDT)
Content-Disposition: inline; filename=acpi-use-memory-read-from-buffer.patch
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/system.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

Index: 2.6-git/drivers/acpi/system.c
===================================================================
--- 2.6-git.orig/drivers/acpi/system.c
+++ 2.6-git/drivers/acpi/system.c
@@ -77,7 +77,6 @@ static ssize_t acpi_table_show(struct ko
 	    container_of(bin_attr, struct acpi_table_attr, attr);
 	struct acpi_table_header *table_header = NULL;
 	acpi_status status;
-	ssize_t ret_count = count;
 
 	status =
 	    acpi_get_table(table_attr->name, table_attr->instance,
@@ -85,18 +84,8 @@ static ssize_t acpi_table_show(struct ko
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
