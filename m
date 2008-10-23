From: Len Brown <lenb@kernel.org>
Subject: [PATCH 043/122] Subject: ACPI dock: Use ACPI_EXCEPTION instead of
 printk(KERN_ERR
Date: Thu, 23 Oct 2008 02:38:17 -0400
Message-ID: <0a918a9432cc30aede10f904253b66ea6ab485ac.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYJWGkE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:04 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600GGOIIL6U45@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:58 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

lenb: stripped patch down to what still applied to new dock.c

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index b7d1581..913bb1e 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -488,8 +488,9 @@ static void handle_dock(struct dock_station *ds, int dock)
 	arg.integer.value = dock;
 	status = acpi_evaluate_object(ds->handle, "_DCK", &arg_list, &buffer);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
-		printk(KERN_ERR PREFIX "%s - failed to execute _DCK\n",
-			 (char *)name_buffer.pointer);
+		ACPI_EXCEPTION((AE_INFO, status, "%s - failed to execute"
+			" _DCK\n", (char *)name_buffer.pointer));
+
 	kfree(buffer.pointer);
 	kfree(name_buffer.pointer);
 }
-- 
1.5.5.1

