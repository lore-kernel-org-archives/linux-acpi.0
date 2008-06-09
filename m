From: akpm@linux-foundation.org
Subject: [patch 11/11] acpi: use memory_read_from_buffer()
Date: Mon, 09 Jun 2008 16:22:26 -0700
Message-ID: <200806092322.m59NMQld013985@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35297 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753775AbYFIX2p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 19:28:45 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, akinobu.mita@gmail.com, robert.moore@intel.com, rui.zhang@intel.com, trenn@suse.de

From: Akinobu Mita <akinobu.mita@gmail.com>

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/system.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff -puN drivers/acpi/system.c~acpi-use-memory_read_from_buffer drivers/acpi/system.c
--- a/drivers/acpi/system.c~acpi-use-memory_read_from_buffer
+++ a/drivers/acpi/system.c
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
_
