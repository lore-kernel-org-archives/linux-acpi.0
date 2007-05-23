From: akpm@linux-foundation.org
Subject: [patch 5/6] ACPI: bay: send envp with uevent
Date: Wed, 23 May 2007 14:12:29 -0700
Message-ID: <200705232112.l4NLCTIn032157@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:57412 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755799AbXEWVYs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 May 2007 17:24:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, kristen.c.accardi@intel.com, s.berberig@arcor.de

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Make the bay driver send env information on bay events.

Upon any bay event, we will send the string "BAY_EVENT=%d" along with the
KOBJ_CHANGE, and report the event number.  What the event number means will
be platform specific.  Event 3 is always an eject request, but an insert
may be either event 1, or it may be event 0.  Event 1 may also be a
remove request.  It would be best if you check the number of your event
with udevmonitor before writing any udev scripts for inserting and
removing drive bays.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Stephan Berberig <s.berberig@arcor.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/bay.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff -puN drivers/acpi/bay.c~acpi-bay-send-envp-with-uevent drivers/acpi/bay.c
--- a/drivers/acpi/bay.c~acpi-bay-send-envp-with-uevent
+++ a/drivers/acpi/bay.c
@@ -333,18 +333,12 @@ static void bay_notify(acpi_handle handl
 {
 	struct bay *bay_dev = (struct bay *)data;
 	struct device *dev = &bay_dev->pdev->dev;
+	char event_string[12];
+	char *envp[] = { event_string, NULL };
 
 	bay_dprintk(handle, "Bay event");
-
-	switch(event) {
-	case ACPI_NOTIFY_BUS_CHECK:
-	case ACPI_NOTIFY_DEVICE_CHECK:
-	case ACPI_NOTIFY_EJECT_REQUEST:
-		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
-		break;
-	default:
-		printk(KERN_ERR PREFIX "Bay: unknown event %d\n", event);
-	}
+	sprintf(event_string, "BAY_EVENT=%d\n", event);
+	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);
 }
 
 static acpi_status
_
