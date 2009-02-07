From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/30] ACPI: struct device - replace bus_id with dev_name(),
 dev_set_name()
Date: Sat, 07 Feb 2009 01:41:34 -0500
Message-ID: <db1461ad431f0fd21afcd8ea6594ae38fdc57759.1233988827.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:17388 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbZBGGmF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 01:42:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KEO00KCTNY4ZJS2@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Feb 2009 00:42:05 -0600 (CST)
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
In-reply-to: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
References: <091d71e023557136e96f0e54f301497a3fc95dc3.1233988822.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kay Sievers <kay.sievers@vrfy.org>, Len Brown <len.brown@intel.com>

From: Kay Sievers <kay.sievers@vrfy.org>

Signed-off-by: Kay Sievers <kay.sievers@vrfy.org>
Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index adec3d1..5479b9f 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -255,12 +255,12 @@ static int acpi_platform_notify(struct device *dev)
 	}
 	type = acpi_get_bus_type(dev->bus);
 	if (!type) {
-		DBG("No ACPI bus support for %s\n", dev->bus_id);
+		DBG("No ACPI bus support for %s\n", dev_name(dev));
 		ret = -EINVAL;
 		goto end;
 	}
 	if ((ret = type->find_device(dev, &handle)) != 0)
-		DBG("Can't get handler for %s\n", dev->bus_id);
+		DBG("Can't get handler for %s\n", dev_name(dev));
       end:
 	if (!ret)
 		acpi_bind_one(dev, handle);
@@ -271,10 +271,10 @@ static int acpi_platform_notify(struct device *dev)
 
 		acpi_get_name(dev->archdata.acpi_handle,
 			      ACPI_FULL_PATHNAME, &buffer);
-		DBG("Device %s -> %s\n", dev->bus_id, (char *)buffer.pointer);
+		DBG("Device %s -> %s\n", dev_name(dev), (char *)buffer.pointer);
 		kfree(buffer.pointer);
 	} else
-		DBG("Device %s -> No ACPI support\n", dev->bus_id);
+		DBG("Device %s -> No ACPI support\n", dev_name(dev));
 #endif
 
 	return ret;
-- 
1.5.6.6

