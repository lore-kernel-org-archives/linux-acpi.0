From: Len Brown <len.brown@intel.com>
Subject: [PATCH 11/25] ACPI video hotkey: remove invalid events handler for video output devices
Date: Fri, 24 Aug 2007 03:20:58 -0400
Message-ID: <11879400872911-git-send-email-len.brown@intel.com>
References: <11879400723077-git-send-email-len.brown@intel.com>
 <11879400762710-git-send-email-len.brown@intel.com>
 <11879400782033-git-send-email-len.brown@intel.com>
 <11879400793131-git-send-email-len.brown@intel.com>
 <11879400794174-git-send-email-len.brown@intel.com>
 <11879400802531-git-send-email-len.brown@intel.com>
 <11879400812208-git-send-email-len.brown@intel.com>
 <11879400823500-git-send-email-len.brown@intel.com>
 <11879400841550-git-send-email-len.brown@intel.com>
 <1187940085345-git-send-email-len.brown@intel.com>
 <1187940086685-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12497 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762751AbXHXHV2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 03:21:28 -0400
In-Reply-To: <1187940086685-git-send-email-len.brown@intel.com>
Message-Id: <a1eb96a2f635cdb8f626f4074dae2ba5a6fce1e8.1187939442.git.len.brown@intel.com>
In-Reply-To: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
References: <3c1d36da1d5ed36979340efd233ddaacc45b0a02.1187939442.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Both ACPI_VIDEO_NOTIFY_SWITCH and ACPI_VIDEO_NOTIFY_PROBE
are valid for video bus devices only. Actually ACPI video output
device should never be notified for a output device switch/probe.

ACPI bus devices notify handler already has the code to
handle these kinds of events.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index d987019..8efdea5 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1813,10 +1813,6 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 	device = video_device->dev;
 
 	switch (event) {
-	case ACPI_VIDEO_NOTIFY_SWITCH:	/* change in status (cycle output device) */
-	case ACPI_VIDEO_NOTIFY_PROBE:	/* change in status (output device status) */
-		acpi_bus_generate_event(device, event, 0);
-		break;
 	case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:	/* Cycle brightness */
 	case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:	/* Increase brightness */
 	case ACPI_VIDEO_NOTIFY_DEC_BRIGHTNESS:	/* Decrease brightness */
-- 
1.5.3.rc6.17.g1911
