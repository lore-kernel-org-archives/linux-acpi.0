From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/65] ACPICA: Fix printf format warnings for 64-bit build
Date: Fri, 29 May 2009 21:41:52 -0400
Message-ID: <b21245a85e62ea7eeb5b7562ce98cf8b0aecbd26.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:39590 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270AbZE3BnE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:43:04 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00HRZOREOAY2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:51 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fix warnings caused by size_t and ACPI_SIZE changing to 64 bits.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsnames.c |    2 +-
 drivers/acpi/acpica/tbfadt.c  |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index ae3dc10..af8e6bc 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -149,7 +149,7 @@ char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 
 	name_buffer = ACPI_ALLOCATE_ZEROED(size);
 	if (!name_buffer) {
-		ACPI_ERROR((AE_INFO, "Allocation failure"));
+		ACPI_ERROR((AE_INFO, "Could not allocate %u bytes", (u32)size));
 		return_PTR(NULL);
 	}
 
diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index 71e655d..e5fe7c8 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -284,9 +284,9 @@ void acpi_tb_create_local_fadt(struct acpi_table_header *table, u32 length)
 	if (length > sizeof(struct acpi_table_fadt)) {
 		ACPI_WARNING((AE_INFO,
 			      "FADT (revision %u) is longer than ACPI 2.0 version, "
-			      "truncating length 0x%X to 0x%zX",
-			      table->revision, (unsigned)length,
-			      sizeof(struct acpi_table_fadt)));
+			      "truncating length 0x%X to 0x%X",
+			      table->revision, length,
+			      (u32)sizeof(struct acpi_table_fadt)));
 	}
 
 	/* Clear the entire local FADT */
-- 
1.6.0.6

