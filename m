From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/12] acpi-power-meter: Don't leak ACPI error codes to
 userspace
Date: Sat, 07 Nov 2009 21:57:06 -0500
Message-ID: <22aecebfd9498c4779e5c5bed1d2d054bd99f7a4.1257648659.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:60890 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbZKHC5P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:15 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR002USS7K7BRO@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:21 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Darrick J. Wong <djwong@us.ibm.com>

If the ACPI methods return an error code, we must return -EINVAL to userspace
to flag the error.  Right now we pass the (positive) number right through,
which causes echo to keep writing bogus values.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power_meter.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/power_meter.c b/drivers/acpi/power_meter.c
index e6bfd77..2ef7030 100644
--- a/drivers/acpi/power_meter.c
+++ b/drivers/acpi/power_meter.c
@@ -294,7 +294,11 @@ static int set_acpi_trip(struct acpi_power_meter_resource *resource)
 		return -EINVAL;
 	}
 
-	return data;
+	/* _PTP returns 0 on success, nonzero otherwise */
+	if (data)
+		return -EINVAL;
+
+	return 0;
 }
 
 static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
-- 
1.6.0.6

