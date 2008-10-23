From: Len Brown <lenb@kernel.org>
Subject: [PATCH 060/122] ACPI: Allow overriding to higher critical trip point.
Date: Thu, 23 Oct 2008 02:38:34 -0400
Message-ID: <22a94d79a34bf010d11996d30eed8ee3fc1a4fbf.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481AbYJWGk0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006X7IIS37Z1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:05 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=9129

lenb: Note that overriding a critical trip point
may simply fool the user into thinking that they
have control that they do not actually have.
For it is EC firmware that decides when the EC
sends Linux temperature change events, and the
EC may or may not decide to send Linux these events
anywhere in the neighborhood of the fake
override trip points.  Beware.

note also that thermal.nocrt is already available
to disable crtical trip point actios,
and thermal.crt=-1 is already available to
disabled critical trip points entirely.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |    2 +-
 drivers/acpi/thermal.c              |    8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1150444..0707423 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2146,7 +2146,7 @@ and is between 256 and 4096 characters. It is defined in the file
 
 	thermal.crt=	[HW,ACPI]
 			-1: disable all critical trip points in all thermal zones
-			<degrees C>: lower all critical trip points
+			<degrees C>: override all critical trip points
 
 	thermal.nocrt=	[HW,ACPI]
 			Set to disable actions on ACPI thermal zone
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index e052a75..e9e17df 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -388,10 +388,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 			} else if (crt > 0) {
 				unsigned long crt_k = CELSIUS_TO_KELVIN(crt);
 				/*
-				 * Allow override to lower critical threshold
+				 * Allow override critical threshold
 				 */
-				if (crt_k < tz->trips.critical.temperature)
-					tz->trips.critical.temperature = crt_k;
+				if (crt_k > tz->trips.critical.temperature)
+					printk(KERN_WARNING PREFIX
+						"Critical threshold %d C\n", crt);
+				tz->trips.critical.temperature = crt_k;
 			}
 		}
 	}
-- 
1.5.5.1

