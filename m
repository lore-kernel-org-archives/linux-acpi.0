From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/6] gma500: Clean up weirdness in the cdv mode test code
Date: Tue, 24 Apr 2012 16:46:48 +0100
Message-ID: <20120424154645.1631.20259.stgit@bluebook>
References: <20120424154548.1631.58977.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34190 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755288Ab2DXPrU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:47:20 -0400
In-Reply-To: <20120424154548.1631.58977.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/cdv_intel_crt.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_crt.c b/drivers/gpu/drm/gma500/cdv_intel_crt.c
index 1de27c7..1a82843 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_crt.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_crt.c
@@ -67,7 +67,6 @@ static void cdv_intel_crt_dpms(struct drm_encoder *encoder, int mode)
 static int cdv_intel_crt_mode_valid(struct drm_connector *connector,
 				struct drm_display_mode *mode)
 {
-	int max_clock = 0;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		return MODE_NO_DBLESCAN;
 
@@ -76,8 +75,7 @@ static int cdv_intel_crt_mode_valid(struct drm_connector *connector,
 		return MODE_CLOCK_LOW;
 
 	/* The max clock for CDV is 355 instead of 400 */
-	max_clock = 355000;
-	if (mode->clock > max_clock)
+	if (mode->clock > 355000)
 		return MODE_CLOCK_HIGH;
 
 	if (mode->hdisplay > 1680 || mode->vdisplay > 1050)

