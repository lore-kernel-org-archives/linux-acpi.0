From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/3] dock: bay: Don't call acpi_walk_namespace() when ACPI is
 disabled.
Date: Sat, 28 Jun 2008 01:32:45 -0400
Message-ID: <816c2eda3ce8fa7eb62f22e01e2ec7a3f7d677c0.1214631090.git.len.brown@intel.com>
References: <1214631165-1436-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:44622 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYF1Fcw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:32:52 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K3500B1SRERAD12@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:32:52 -0500 (CDT)
In-reply-to: <1214631165-1436-1-git-send-email-lenb@kernel.org>
In-reply-to: <16d752397301b95abaa95cbaf9e785d221872311.1214631090.git.len.brown@intel.com>
References: <16d752397301b95abaa95cbaf9e785d221872311.1214631090.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
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
1.5.6.1.89.gd544

