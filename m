From: Luca Tettamanti <kronos.it@gmail.com>
Subject: [PATCH/RFC] drm/radeon: ACPI: veto the keypress on ATIF events
Date: Wed, 1 Aug 2012 15:49:00 +0200
Message-ID: <20120801134900.GA7909@growl>
References: <20120728145626.GA6304@growl>
 <CADnq5_OjWoLS=GO_qYEBeTPvXrKJeJUjUCzOZS5w3erjHeFDqg@mail.gmail.com>
 <20120729130644.GA12378@growl>
 <CADnq5_OdKXsiVnFbkBNB2ue4df6tGaZ7bVMP+TvetFcy0faKog@mail.gmail.com>
 <20120730202449.GA5600@growl>
 <CADnq5_NP9Rw8DhmS+Q5G1PaUqcHQtVA6KoCGH5MME6DEd-Lw7Q@mail.gmail.com>
 <CAKPcRGpL6JBx5MnWk6fFVOYCPQGeeDC-ytOwA+J+gEEZS+4SuA@mail.gmail.com>
 <CADnq5_NN8OcmyKDemO=Mv0as-02sYEHxxbn2G4XtSmpzEsnR0w@mail.gmail.com>
 <20120731200520.GA5425@growl>
 <CADnq5_Meh0nW90PZ=kAJdK=WjZKTdr7+5vN=vza+PzyJnEWKAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38053 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2HANtH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Aug 2012 09:49:07 -0400
Received: by wgbdr13 with SMTP id dr13so6941308wgb.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Aug 2012 06:49:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADnq5_Meh0nW90PZ=kAJdK=WjZKTdr7+5vN=vza+PzyJnEWKAA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, joeyli <jlee@suse.com>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

AMD ACPI interface may overload the standard event
ACPI_VIDEO_NOTIFY_PROBE (0x81) to signal AMD-specific events. In such
cases we don't want to send the keypress (KEY_SWITCHVIDEOMODE) to the
userspace because the user did not press the mode switch key (the
spurious keypress confuses the DE which usually changes the
display configuration and messes up a dual-screen setup).
This patch gives the radeon driver the chance to examine the event and
block the keypress if the event is an "AMD event".

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
---
Any comment from ACPI front?

 drivers/acpi/video.c                 |   10 ++++++++--
 drivers/gpu/drm/radeon/radeon_acpi.c |    7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1e0a9e1..a8592c4 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1457,7 +1457,12 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 		acpi_video_device_enumerate(video);
 		acpi_video_device_rebind(video);
 		acpi_bus_generate_proc_event(device, event, 0);
-		keycode = KEY_SWITCHVIDEOMODE;
+		/* This event is also overloaded by AMD ACPI interface, don't
+		 * send the key press if the event has been handled elsewhere
+		 * (e.g. radeon DRM driver).
+		 */
+		if (!acpi_notifier_call_chain(device, event, 0))
+			keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_CYCLE:	/* Cycle Display output hotkey pressed. */
@@ -1479,7 +1484,8 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 		break;
 	}
 
-	if (event != ACPI_VIDEO_NOTIFY_SWITCH)
+	if (event != ACPI_VIDEO_NOTIFY_SWITCH &&
+			event != ACPI_VIDEO_NOTIFY_PROBE)
 		acpi_notifier_call_chain(device, event, 0);
 
 	if (keycode) {
diff --git a/drivers/gpu/drm/radeon/radeon_acpi.c b/drivers/gpu/drm/radeon/radeon_acpi.c
index 96de08d..ee0d29e 100644
--- a/drivers/gpu/drm/radeon/radeon_acpi.c
+++ b/drivers/gpu/drm/radeon/radeon_acpi.c
@@ -273,7 +273,12 @@ int radeon_atif_handler(struct radeon_device *rdev,
 	}
 	/* TODO: check other events */
 
-	return NOTIFY_OK;
+	/* We've handled the event, stop the notifier chain. The ACPI interface
+	 * overloads ACPI_VIDEO_NOTIFY_PROBE, we don't want to send that to
+	 * userspace if the event was generated only to signal a SBIOS
+	 * request.
+	 */
+	return NOTIFY_BAD;
 }
 
 /* Call all ACPI methods here */
-- 
1.7.10.4
