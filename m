From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/12] ACPI: fixes a false alarm from lockdep
Date: Tue, 06 Apr 2010 03:06:15 -0400
Message-ID: <bc73675b99fd9850dd914be01d71af99c5d2a1ae.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60836 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342Ab0DFHGc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G008AG12RO7B1@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:31 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

fixes a false alarm from lockdep, as acpi hotplug workqueue waits other
workqueues.
http://bugzilla.kernel.org/show_bug.cgi?id=14553
https://bugzilla.kernel.org/show_bug.cgi?id=15521

Original-patch-from: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 8e6d866..900da68 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -758,7 +758,14 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 	queue = hp ? kacpi_hotplug_wq :
 		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
 	dpc->wait = hp ? 1 : 0;
-	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+
+	if (queue == kacpi_hotplug_wq)
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	else if (queue == kacpi_notify_wq)
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	else
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+
 	ret = queue_work(queue, &dpc->work);
 
 	if (!ret) {
-- 
1.6.0.6

