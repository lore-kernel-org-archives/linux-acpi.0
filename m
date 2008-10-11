From: Len Brown <lenb@kernel.org>
Subject: [PATCH 57/85] ACPI: acpi_driver_data could only be applied to
 acpi_device
Date: Sat, 11 Oct 2008 02:36:17 -0400
Message-ID: <4b5fcb353ba46adfa2f98546e3d34e7dc65221cb.1223706853.git.len.brown@intel.com>
References: <1223707005-26864-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:41914 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbYJKGhJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 02:37:09 -0400
In-reply-to: <1223707005-26864-1-git-send-email-lenb@kernel.org>
In-reply-to: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
References: <1d80ebdb81444701024ad9b9f026516561496a43.1223706853.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Hannes Reinecke <hare@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
CC: Hannes Reinecke <hare@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f6f52c1..e7b8853 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -384,7 +384,7 @@ static int acpi_device_remove(struct device * dev)
 			acpi_drv->ops.remove(acpi_dev, acpi_dev->removal_type);
 	}
 	acpi_dev->driver = NULL;
-	acpi_driver_data(dev) = NULL;
+	acpi_driver_data(acpi_dev) = NULL;
 
 	put_device(dev);
 	return 0;
-- 
1.5.5.1

