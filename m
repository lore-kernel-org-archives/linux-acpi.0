From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/98] ACPICA: Add error check to debug object dump routine
Date: Sat, 28 Mar 2009 00:30:49 -0400
Message-ID: <4bbfb85da27c27e9cc9a7fef4bd75df6361152ff.1238214617.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:46073 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412AbZC1Ecp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:45 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7009T68M6JJO1@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:43 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add check for invalid handle in acpi_ns_dump_one_object.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nsdump.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/nsdump.c b/drivers/acpi/acpica/nsdump.c
index 0da33c8..e96d37a 100644
--- a/drivers/acpi/acpica/nsdump.c
+++ b/drivers/acpi/acpica/nsdump.c
@@ -181,6 +181,12 @@ acpi_ns_dump_one_object(acpi_handle obj_handle,
 	}
 
 	this_node = acpi_ns_map_handle_to_node(obj_handle);
+	if (!this_node) {
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Invalid object handle %p\n",
+				  obj_handle));
+		return (AE_OK);
+	}
+
 	type = this_node->type;
 
 	/* Check if the owner matches */
-- 
1.6.0.6

