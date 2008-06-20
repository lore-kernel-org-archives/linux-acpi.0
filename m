From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] ACPI: no AC status notification
Date: Fri, 20 Jun 2008 03:35:10 -0400
Message-ID: <f163ff5176a8e9c827d8ebe044710d67d40799c3.1213947186.git.len.brown@intel.com>
References: <1213947310-10807-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:33734 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbYFTHfR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:35:17 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2R00I793QO75G1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:35:16 -0500 (CDT)
In-reply-to: <1213947310-10807-1-git-send-email-lenb@kernel.org>
In-reply-to: <d385c2a85877f0cb785070094edf9a624c090d68.1213947186.git.len.brown@intel.com>
References: <d385c2a85877f0cb785070094edf9a624c090d68.1213947186.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=10695

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ac.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 5b73f6a..831883b 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -233,6 +233,9 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 
 	device = ac->device;
 	switch (event) {
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				  "Unsupported event [0x%x]\n", event));
 	case ACPI_AC_NOTIFY_STATUS:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
@@ -244,11 +247,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 #ifdef CONFIG_ACPI_SYSFS_POWER
 		kobject_uevent(&ac->charger.dev->kobj, KOBJ_CHANGE);
 #endif
-		break;
-	default:
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-				  "Unsupported event [0x%x]\n", event));
-		break;
 	}
 
 	return;
-- 
1.5.6

