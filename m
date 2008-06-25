From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] dock: bay: Don't call acpi_walk_namespace() when ACPI is
 disabled.
Date: Tue, 24 Jun 2008 23:07:44 -0400
Message-ID: <7fd311a816aeae978d4f994569b846091dbdf404.1214362900.git.len.brown@intel.com>
References: <20080620135639.GA5073@damson.getinternet.no>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53118 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbYFYDHx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 23:07:53 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3000H9T0DP6BX7@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Jun 2008 22:01:02 -0500 (CDT)
In-reply-to: <20080620135639.GA5073@damson.getinternet.no>
In-reply-to: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
References: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernrel@vger.kernrel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bay.c  |    3 +++
 drivers/acpi/dock.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bay.c b/drivers/acpi/bay.c
index 26038c2..61b6c5b 100644
--- a/drivers/acpi/bay.c
+++ b/drivers/acpi/bay.c
@@ -377,6 +377,9 @@ static int __init bay_init(void)
 
 	INIT_LIST_HEAD(&drive_bays);
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	/* look for dockable drive bays */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 		ACPI_UINT32_MAX, find_bay, &bays, NULL);
diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 96c542f..bb7c51f 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -917,6 +917,9 @@ static int __init dock_init(void)
 
 	dock_station = NULL;
 
+	if (acpi_disabled)
+		return 0;
+
 	/* look for a dock station */
 	acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 			    ACPI_UINT32_MAX, find_dock, &num, NULL);
-- 
1.5.6.56.g29b0d

