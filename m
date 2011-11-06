From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend 2x] thermal: Prevent polling from happening during system suspend
Date: Sun, 6 Nov 2011 14:21:38 +0100
Message-ID: <201111061421.38580.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:52976 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab1KFNTA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Nov 2011 08:19:00 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Len Brown (Intel)" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The thermal driver should use a freezable workqueue to schedule
polling to prevent thermal_zone_device_update() from being run
during system suspend, when the devices it relies on may be inactive.
Make it use the system freezable workqueue for this purpose.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/thermal/thermal_sys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/thermal/thermal_sys.c
===================================================================
--- linux.orig/drivers/thermal/thermal_sys.c
+++ linux/drivers/thermal/thermal_sys.c
@@ -678,10 +678,10 @@ static void thermal_zone_device_set_poll
 		return;
 
 	if (delay > 1000)
-		schedule_delayed_work(&(tz->poll_queue),
+		queue_delayed_work(system_freezable_wq, &(tz->poll_queue),
 				      round_jiffies(msecs_to_jiffies(delay)));
 	else
-		schedule_delayed_work(&(tz->poll_queue),
+		queue_delayed_work(system_freezable_wq, &(tz->poll_queue),
 				      msecs_to_jiffies(delay));
 }
 
