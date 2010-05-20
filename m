From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/22] ACPICA: Prevent possible allocation overrun during
 object copy
Date: Thu, 20 May 2010 01:18:46 -0400
Message-ID: <17b82327f3e7ab5a068f8019768008ee82d912be.1274332658.git.len.brown@intel.com>
References: <1274332730-27370-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:36044 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0ETGPc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 May 2010 02:15:32 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L2P007GDG0X9AM5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 20 May 2010 01:14:59 -0500 (CDT)
In-reply-to: <1274332730-27370-1-git-send-email-lenb@kernel.org>
In-reply-to: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
References: <4cdf1a562bfb5852954aadbe8515557b8acc8168.1274332657.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Original code did not handle the case where the object to be
copied was a namespace node.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/utcopy.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 97ec362..6fef83f 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -677,16 +677,24 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 	u16 reference_count;
 	union acpi_operand_object *next_object;
 	acpi_status status;
+	acpi_size copy_size;
 
 	/* Save fields from destination that we don't want to overwrite */
 
 	reference_count = dest_desc->common.reference_count;
 	next_object = dest_desc->common.next_object;
 
-	/* Copy the entire source object over the destination object */
+	/*
+	 * Copy the entire source object over the destination object.
+	 * Note: Source can be either an operand object or namespace node.
+	 */
+	copy_size = sizeof(union acpi_operand_object);
+	if (ACPI_GET_DESCRIPTOR_TYPE(source_desc) == ACPI_DESC_TYPE_NAMED) {
+		copy_size = sizeof(struct acpi_namespace_node);
+	}
 
-	ACPI_MEMCPY((char *)dest_desc, (char *)source_desc,
-		    sizeof(union acpi_operand_object));
+	ACPI_MEMCPY(ACPI_CAST_PTR(char, dest_desc),
+		    ACPI_CAST_PTR(char, source_desc), copy_size);
 
 	/* Restore the saved fields */
 
-- 
1.6.0.6

