From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/65] ACPICA: Fix possible dereference of null pointer
Date: Fri, 29 May 2009 21:41:53 -0400
Message-ID: <65259094c3e038519a2d8fa6fbc6256f04ad6535.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:61693 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493AbZE3Bmt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:49 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00L3XORFPUU2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:51 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fix dereference of possibly null pointer "Predefined" in the case
where the method is not one of the predefined methods.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/nspredef.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/nspredef.c b/drivers/acpi/acpica/nspredef.c
index d9e8cbc..7f8e066 100644
--- a/drivers/acpi/acpica/nspredef.c
+++ b/drivers/acpi/acpica/nspredef.c
@@ -144,7 +144,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 
 	pathname = acpi_ns_get_external_pathname(node);
 	if (!pathname) {
-		pathname = ACPI_CAST_PTR(char, predefined->info.name);
+		return AE_OK;	/* Could not get pathname, ignore */
 	}
 
 	/*
@@ -230,10 +230,7 @@ acpi_ns_check_predefined_names(struct acpi_namespace_node *node,
 	}
 
       exit:
-	if (pathname != predefined->info.name) {
-		ACPI_FREE(pathname);
-	}
-
+	ACPI_FREE(pathname);
 	return (status);
 }
 
-- 
1.6.0.6

