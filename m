From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/10] ACPI: dock: properly initialize local struct
 dock_station in dock_add()
Date: Tue, 16 Feb 2010 04:46:08 -0500
Message-ID: <49c6fb2e41d41c4c0c5c753b6960bc81fe658d20.1266313501.git.len.brown@intel.com>
References: <1266313570-6490-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:47906 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756834Ab0BPJq1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2010 04:46:27 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KXX00LVGHT4KIR4@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 16 Feb 2010 03:46:18 -0600 (CST)
In-reply-to: <1266313570-6490-1-git-send-email-lenb@kernel.org>
In-reply-to: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
References: <0406ad336c066190770cbf350b552d608e43ed09.1266313501.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Alex Chiang <achiang@hp.com>

Commit fe06fba2 (ACPI: dock: add struct dock_station * directly
to platform device data) changed dock_add() to use the
platform_device_register_data() API.

We passed that interface a stack variable, which is kmemdup'ed
and assigned to the device's platform_data pointer.

Unfortunately, whatever random garbage is in the stack variable
gets coped during the kmemdup, and that leads to broken behavior.

Explicitly zero out the structure before passing it to the API.

This fixes the T41 docking button issue:
http://bugzilla.kernel.org/show_bug.cgi?id=15000

Cc: stable@kernel.org
Reported-by: Chris Mason <chris.mason@oracle.com>
Signed-off-by: Alex Chiang <achiang@hp.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dock.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index bbc2c13..b2586f5 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -935,6 +935,7 @@ static int dock_add(acpi_handle handle)
 	struct platform_device *dd;
 
 	id = dock_station_count;
+	memset(&ds, 0, sizeof(ds));
 	dd = platform_device_register_data(NULL, "dock", id, &ds, sizeof(ds));
 	if (IS_ERR(dd))
 		return PTR_ERR(dd);
-- 
1.6.0.6

