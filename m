From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/3] gma500: Prevent endless loop in panel power up sequence
Date: Mon, 21 May 2012 15:27:10 +0100
Message-ID: <20120521142145.18168.28248.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53250 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756371Ab2EUN1b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 May 2012 09:27:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Some devices don't have a panel connected to LVDS and thus will never power up.
This patch checks the power sequence progress bits in PP_STATUS to prevent an
endless loop on such devices.

Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/psb_lid.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_lid.c b/drivers/gpu/drm/gma500/psb_lid.c
index 7ff8bb2b..1d2ebb5 100644
--- a/drivers/gpu/drm/gma500/psb_lid.c
+++ b/drivers/gpu/drm/gma500/psb_lid.c
@@ -40,10 +40,16 @@ static void psb_lid_timer_func(unsigned long data)
 		REG_WRITE(PP_CONTROL, REG_READ(PP_CONTROL) | POWER_TARGET_ON);
 		do {
 			pp_status = REG_READ(PP_STATUS);
-		} while ((pp_status & PP_ON) == 0);
+		} while ((pp_status & PP_ON) == 0 &&
+			 (pp_status & PP_SEQUENCE_MASK) != 0);
 
-		/*FIXME: should be backlight level before*/
-		psb_intel_lvds_set_brightness(dev, 100);
+		if (REG_READ(PP_STATUS) & PP_ON) {
+			/*FIXME: should be backlight level before*/
+			psb_intel_lvds_set_brightness(dev, 100);
+		} else {
+			DRM_DEBUG("LVDS panel never powered up");
+			return;
+		}
 	} else {
 		psb_intel_lvds_set_brightness(dev, 0);
 

