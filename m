From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 13/13] gma500: mdfld_dsi_dpi_mode_set() do not corrupt
 DSPSTRIDE
Date: Wed, 02 May 2012 19:17:18 +0100
Message-ID: <20120502181715.26650.71227.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56316 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726Ab2EBSSB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:18:01 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

The proper stride value set in mdfld__intel_pipe_set_base().

TODO: move tc35876x support to separate driver and get rid of all
if (mdfld_get_panel_type(dev, pipe) == TC35876X) { ... }

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
index d52358b..b34ff09 100644
--- a/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
@@ -869,7 +869,6 @@ void mdfld_dsi_dpi_mode_set(struct drm_encoder *encoder,
 		mdfld_set_pipe_timing(dsi_config, pipe);
 
 		REG_WRITE(DSPABASE, 0x00);
-		REG_WRITE(DSPASTRIDE, (mode->hdisplay * 4));
 		REG_WRITE(DSPASIZE,
 			((mode->vdisplay - 1) << 16) | (mode->hdisplay - 1));
 

