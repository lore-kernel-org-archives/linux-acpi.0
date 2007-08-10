From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC] [PATCH V2 2/3] ACPI video hotkey: remove invalid events
	handled by video output devices
Date: Sat, 11 Aug 2007 05:07:24 +0800
Message-ID: <1186780044.6830.58.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59810 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756763AbXHJVGT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Aug 2007 17:06:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com

Both ACPI_VIDEO_NOTIFY_SWITCH and ACPI_VIDEO_NOTIFY_PROBE
are valid for video Display Devices only.

ACPI video output devices should not handle these kinds of events.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6.23-rc2/drivers/acpi/video.c
===================================================================
--- linux-2.6.23-rc2.orig/drivers/acpi/video.c
+++ linux-2.6.23-rc2/drivers/acpi/video.c
@@ -1813,10 +1813,6 @@ static void acpi_video_device_notify(acp
 	device = video_device->dev;
 
 	switch (event) {
-	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
-	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
-		acpi_bus_generate_event(device, event, 0);
-		break;
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
