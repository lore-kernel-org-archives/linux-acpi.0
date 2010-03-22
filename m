From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI: fixes a false alarm from lockdep
Date: Mon, 22 Mar 2010 15:48:54 +0800
Message-ID: <1269244134.2205.1683.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:17404 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab0CVHrr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Mar 2010 03:47:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Li, Shaohua" <shaohua.li@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>


fixes a false alarm from lockdep, as acpi hotplug workqueue waits other
workqueues.
http://bugzilla.kernel.org/show_bug.cgi?id=14553
https://bugzilla.kernel.org/show_bug.cgi?id=15521

Original-patch-from: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/osl.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/osl.c
===================================================================
--- linux-2.6.orig/drivers/acpi/osl.c	2010-03-19 09:34:33.000000000 +0800
+++ linux-2.6/drivers/acpi/osl.c	2010-03-19 09:36:00.000000000 +0800
@@ -758,7 +758,14 @@
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


