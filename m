From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V3 2/3] ACPI video hotkey: remove invalid events handler
	for video output devices
Date: Mon, 20 Aug 2007 18:23:51 +0800
Message-ID: <1187605431.2920.141.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54516 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941AbXHTKXt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Aug 2007 06:23:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
Cc: lenb@kernel.org, mjg59@srcf.ucam.org, dmitry.torokhov@gmail.com, hmh@hmh.eng.hr, hughsient@gmail.com, luming.yu@intel.com

Both ACPI_VIDEO_NOTIFY_SWITCH and ACPI_VIDEO_NOTIFY_PROBE
are valid for video bus devices only. Actually ACPI video output
device should never be notified for a output device switch/probe.

ACPI bus devices notify handler already has the code to
handle these kinds of events.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6.23-rc3/drivers/acpi/video.c
===================================================================
--- linux-2.6.23-rc3.orig/drivers/acpi/video.c
+++ linux-2.6.23-rc3/drivers/acpi/video.c
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
