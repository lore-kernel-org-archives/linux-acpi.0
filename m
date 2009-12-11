From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH 2/2]ACPI: assign different lockdep key for acpi works
Date: Fri, 11 Dec 2009 11:04:58 +0800
Message-ID: <20091211030458.GB7772@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40271 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752099AbZLKDEy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Dec 2009 22:04:54 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, akpm@linux-foundation.org, mingo@elte.hu

Differentiate works for three different workqueue in ACPI. This fixes
a fase alarm from lockdep, as acpi hotplug workqueue waits other
workqueues.

http://bugzilla.kernel.org/show_bug.cgi?id=14553

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---
 drivers/acpi/osl.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux/drivers/acpi/osl.c
===================================================================
--- linux.orig/drivers/acpi/osl.c	2009-12-10 10:40:15.000000000 +0800
+++ linux/drivers/acpi/osl.c	2009-12-10 10:43:25.000000000 +0800
@@ -729,6 +729,8 @@ static acpi_status __acpi_os_execute(acp
 	struct acpi_os_dpc *dpc;
 	struct workqueue_struct *queue;
 	int ret;
+	static struct lock_class_key hp_key, notify_key, acpid_key;
+
 	ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
@@ -758,7 +760,15 @@ static acpi_status __acpi_os_execute(acp
 	queue = hp ? kacpi_hotplug_wq :
 		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
 	dpc->wait = hp ? 1 : 0;
-	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	if (queue == kacpi_hotplug_wq)
+		INIT_WORK_KEY(&dpc->work, acpi_os_execute_deferred,
+				hp_key, "acpi_hp_work");
+	else if (queue == kacpi_notify_wq)
+		INIT_WORK_KEY(&dpc->work, acpi_os_execute_deferred,
+				notify_key, "acpi_notify_work");
+	else
+		INIT_WORK_KEY(&dpc->work, acpi_os_execute_deferred,
+				acpid_key, "acpi_acpid_work");
 	ret = queue_work(queue, &dpc->work);
 
 	if (!ret) {
