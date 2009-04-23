From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/29] thermal: Fix polling frequency for systems without
 passive cooling
Date: Thu, 23 Apr 2009 02:23:32 -0400
Message-ID: <67405439bca28c4dbecd3fefd97fbdb282a302d9.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54737 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605AbZDWGYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:14 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00D0HJ3ZLGVG@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:04 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg59@srcf.ucam.org>

The polling interval (in deciseconds) was accidently interpreted as
being in milliseconds in one codepath, resulting in excessively frequent
polling. Ensure that the conversion is performed.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 9cd15e8..564ea14 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -909,7 +909,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 			thermal_zone_device_register("acpitz", trips, tz,
 						     &acpi_thermal_zone_ops,
 						     0, 0, 0,
-						     tz->polling_frequency);
+						     tz->polling_frequency*100);
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
-- 
1.6.0.6

