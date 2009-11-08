From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/12] acpi: thermal: Add EOL to the trip_point_N_type strings
Date: Sat, 07 Nov 2009 21:57:10 -0500
Message-ID: <625120a42bd4371da98808a4ca3e7589083a06d8.1257648659.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:41776 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbZKHC5R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:17 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR006M0S7MF0J2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:23 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Amit Kucheria <amit.kucheria@canonical.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Amit Kucheria <amit.kucheria@canonical.com>

Make the trip_point_N_type sysfs files return a string ending in EOL for
consistency with other sysfs files.

Signed-off-by: Amit Kucheria <amit.kucheria@canonical.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/thermal_sys.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 4e83c29..6f8d8f9 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -180,15 +180,15 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 
 	switch (type) {
 	case THERMAL_TRIP_CRITICAL:
-		return sprintf(buf, "critical");
+		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
-		return sprintf(buf, "hot");
+		return sprintf(buf, "hot\n");
 	case THERMAL_TRIP_PASSIVE:
-		return sprintf(buf, "passive");
+		return sprintf(buf, "passive\n");
 	case THERMAL_TRIP_ACTIVE:
-		return sprintf(buf, "active");
+		return sprintf(buf, "active\n");
 	default:
-		return sprintf(buf, "unknown");
+		return sprintf(buf, "unknown\n");
 	}
 }
 
-- 
1.6.0.6

