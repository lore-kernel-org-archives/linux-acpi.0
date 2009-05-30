From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/65] ACPICA: Eliminate extra call to NsGetParentNode
Date: Fri, 29 May 2009 21:42:09 -0400
Message-ID: <c446eed6187addf9f76ee0028abed32393aef27e.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40281 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbZE3Bm5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:57 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF0058VORIUAT3@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:55 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Was called twice in the same function with the same parameter.
Alex Chiang.

Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsxfobj.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nsxfobj.c b/drivers/acpi/acpica/nsxfobj.c
index dd33d8b..4071bad 100644
--- a/drivers/acpi/acpica/nsxfobj.c
+++ b/drivers/acpi/acpica/nsxfobj.c
@@ -162,6 +162,7 @@ ACPI_EXPORT_SYMBOL(acpi_get_type)
 acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 {
 	struct acpi_namespace_node *node;
+	struct acpi_namespace_node *parent_node;
 	acpi_status status;
 
 	if (!ret_handle) {
@@ -189,12 +190,12 @@ acpi_status acpi_get_parent(acpi_handle handle, acpi_handle * ret_handle)
 
 	/* Get the parent entry */
 
-	*ret_handle =
-	    acpi_ns_convert_entry_to_handle(acpi_ns_get_parent_node(node));
+	parent_node = acpi_ns_get_parent_node(node);
+	*ret_handle = acpi_ns_convert_entry_to_handle(parent_node);
 
 	/* Return exception if parent is null */
 
-	if (!acpi_ns_get_parent_node(node)) {
+	if (!parent_node) {
 		status = AE_NULL_ENTRY;
 	}
 
-- 
1.6.0.6

