From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/25] ACPICA: Namespace: Properly null terminate objects detached from a namespace node
Date: Tue,  8 Jul 2014 10:06:24 +0800
Message-ID: <6fff15e2fdeaa2327c4cb98c39b2bf415d997d0f.1404277202.git.lv.zheng@intel.com>
References: <cover.1404277202.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:36798 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752477AbaGHCG2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 7 Jul 2014 22:06:28 -0400
In-Reply-To: <cover.1404277202.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, Bob Moore <robert.moore@intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

Fixes a bug exposed by an ACPICA unit test around the
acpi_attach_data()/acpi_detach_data() APIs where the failure to null
terminate a detached object led to the creation of a circular linked list
(and infinite looping) when the object is reattached.

Reported in acpica bugzilla #1063

Reference: https://bugs.acpica.org/show_bug.cgi?id=1063
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Cc: stable <stable@kernel.org>		[3.15.x]
---
 drivers/acpi/acpica/nsobject.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/acpica/nsobject.c b/drivers/acpi/acpica/nsobject.c
index fe54a8c..f1ea8e5 100644
--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -239,6 +239,17 @@ void acpi_ns_detach_object(struct acpi_namespace_node *node)
 		}
 	}
 
+	/*
+	 * Detach the object from any data objects (which are still held by
+	 * the namespace node)
+	 */
+
+	if (obj_desc->common.next_object &&
+	    ((obj_desc->common.next_object)->common.type ==
+	     ACPI_TYPE_LOCAL_DATA)) {
+		obj_desc->common.next_object = NULL;
+	}
+
 	/* Reset the node type to untyped */
 
 	node->type = ACPI_TYPE_ANY;
-- 
1.7.10

