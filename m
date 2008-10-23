From: Len Brown <lenb@kernel.org>
Subject: [PATCH 100/122] ACPICA: Add namespace node to operand object union
Date: Thu, 23 Oct 2008 02:39:14 -0400
Message-ID: <8d5c54b65b20bf81fa9841a27143e2f71f3a7756.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40898 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbYJWGkV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:21 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K960001UIJ6XRL2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:18 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Add ACPI_NAMESPACE_NODE to the ACPI_OPERAND_OBJECT in order to
simplify code that accepts both of these objects. A common type
field is used to differentiate them.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/acobject.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/acpi/acobject.h b/include/acpi/acobject.h
index e9657da..0ca3926 100644
--- a/include/acpi/acobject.h
+++ b/include/acpi/acobject.h
@@ -379,6 +379,13 @@ union acpi_operand_object {
 	struct acpi_object_extra extra;
 	struct acpi_object_data data;
 	struct acpi_object_cache_list cache;
+
+	/*
+	 * Add namespace node to union in order to simplify code that accepts both
+	 * ACPI_OPERAND_OBJECTs and ACPI_NAMESPACE_NODEs. The structures share
+	 * a common descriptor_type field in order to differentiate them.
+	 */
+	struct acpi_namespace_node node;
 };
 
 /******************************************************************************
-- 
1.5.5.1

