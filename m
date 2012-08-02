From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH/RFC] drm/radeon: ACPI: veto the keypress on ATIF events
Date: Thu, 2 Aug 2012 15:46:12 +0200
Message-ID: <20120802134612.GA30802@growl>
References: <20120729130644.GA12378@growl>
 <CADnq5_OdKXsiVnFbkBNB2ue4df6tGaZ7bVMP+TvetFcy0faKog@mail.gmail.com>
 <20120730202449.GA5600@growl>
 <CADnq5_NP9Rw8DhmS+Q5G1PaUqcHQtVA6KoCGH5MME6DEd-Lw7Q@mail.gmail.com>
 <CAKPcRGpL6JBx5MnWk6fFVOYCPQGeeDC-ytOwA+J+gEEZS+4SuA@mail.gmail.com>
 <CADnq5_NN8OcmyKDemO=Mv0as-02sYEHxxbn2G4XtSmpzEsnR0w@mail.gmail.com>
 <20120731200520.GA5425@growl>
 <CADnq5_Meh0nW90PZ=kAJdK=WjZKTdr7+5vN=vza+PzyJnEWKAA@mail.gmail.com>
 <20120801134900.GA7909@growl>
 <1343868330.1682.502.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57542 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab2HBNqT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Aug 2012 09:46:19 -0400
Received: by wgbdr13 with SMTP id dr13so7979823wgb.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Aug 2012 06:46:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343868330.1682.502.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, airlied@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, joeyli <jlee@suse.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 02, 2012 at 08:45:30AM +0800, Zhang Rui wrote:
> On 三, 2012-08-01 at 15:49 +0200, Luca Tettamanti wrote:
> > AMD ACPI interface may overload the standard event
> > ACPI_VIDEO_NOTIFY_PROBE (0x81) to signal AMD-specific events. In such
> > cases we don't want to send the keypress (KEY_SWITCHVIDEOMODE) to the
> > userspace because the user did not press the mode switch key (the
> > spurious keypress confuses the DE which usually changes the
> > display configuration and messes up a dual-screen setup).
> > This patch gives the radeon driver the chance to examine the event and
> > block the keypress if the event is an "AMD event".
> > 
> > Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> > ---
> > Any comment from ACPI front?
> > 
> it looks good to me.
> But I'm wondering if we can use the following code for ACPI part, which
> looks cleaner.
> I know this may change the behavior of other events, but in theory, we
> should not send any input event if we know something wrong in kernel.
> 
> what do you think?

I like it, it's cleaner.
I've split the patch in two pieces (one for video, the other for
radeon) and adopted your suggestion.

BTW, I'm leaving for vacation in a few hours, I'll be offline till mid
August.

Luca

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-ACPI-video-allow-events-handlers-to-veto-the-keypres.patch"

>From acce30c96b90d1bc550e82a9e7f19226fa194d5e Mon Sep 17 00:00:00 2001
From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 2 Aug 2012 15:30:27 +0200
Subject: [PATCH 1/2] ACPI video: allow events handlers to veto the keypress

The standard video events may be overloaded for device specific
purposes. For example AMD ACPI interface overloads
ACPI_VIDEO_NOTIFY_PROBE (0x81) to signal AMD-specific events. In such
cases we don't want to send the keypress (KEY_SWITCHVIDEOMODE) to the
userspace because the user did not press the mode switch key (the
spurious keypress confuses the DE which usually changes the
display configuration and messes up a dual-screen setup).
This patch gives the handlers the chance to examine the event and
block the keypress if the event is device specific.
v2: refactor as suggested by Zhang Rui <rui.zhang@intel.com>

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/acpi/video.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 1e0a9e1..d75642a 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -1448,8 +1448,7 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User requested a switch,
 					 * most likely via hotkey. */
 		acpi_bus_generate_proc_event(device, event, 0);
-		if (!acpi_notifier_call_chain(device, event, 0))
-			keycode = KEY_SWITCHVIDEOMODE;
+		keycode = KEY_SWITCHVIDEOMODE;
 		break;
 
 	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plugged in or removed a video
@@ -1479,8 +1478,9 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 		break;
 	}
 
-	if (event != ACPI_VIDEO_NOTIFY_SWITCH)
-		acpi_notifier_call_chain(device, event, 0);
+	if (acpi_notifier_call_chain(device, event, 0))
+		/* Something vetoed the keypress. */
+		keycode = 0;
 
 	if (keycode) {
 		input_report_key(input, keycode, 1);
-- 
1.7.10.4


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0002-drm-radeon-block-the-keypress-on-ATIF-events.patch"

>From def5119d8f617eef0fac2cd35d7bb18c176ff8f6 Mon Sep 17 00:00:00 2001
From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 2 Aug 2012 15:33:03 +0200
Subject: [PATCH 2/2] drm/radeon: block the keypress on ATIF events

The AMD ACPI interface may use ACPI_VIDEO_NOTIFY_PROBE to signal SBIOS
requests; block the keypress in this case since the user did not
actually press the mode switch key.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_acpi.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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


--VS++wcV0S1rZb1Fb--
