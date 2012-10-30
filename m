From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH 3/4] ACPI: Remove the useless check in osl.c
Date: Tue, 30 Oct 2012 09:52:40 +0800
Message-ID: <1351561961-23821-3-git-send-email-feng.tang@intel.com>
References: <1351561961-23821-1-git-send-email-feng.tang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32579 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504Ab2J2Bx7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 28 Oct 2012 21:53:59 -0400
In-Reply-To: <1351561961-23821-1-git-send-email-feng.tang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: Feng Tang <feng.tang@intel.com>

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 drivers/acpi/osl.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 9eaf708..e76a7f5 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -949,12 +949,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 		(type == OSL_NOTIFY_HANDLER ? kacpi_notify_wq : kacpid_wq);
 	dpc->wait = hp ? 1 : 0;
 
-	if (queue == kacpi_hotplug_wq)
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	else if (queue == kacpi_notify_wq)
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
-	else
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+	INIT_WORK(&dpc->work, acpi_os_execute_deferred);
 
 	/*
 	 * On some machines, a software-initiated SMI causes corruption unless
-- 
1.7.9.5

