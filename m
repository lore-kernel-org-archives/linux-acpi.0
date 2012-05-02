From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 00/13] More GMA500 work
Date: Wed, 02 May 2012 19:12:20 +0100
Message-ID: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56268 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab2EBSNK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:13:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

This follows on from the last set and sorts out the lid regression
they caused on the Poulsbo devices. It then includes another pile
of clean up work and Medfield fixes from Kirill.
---

Alan Cox (1):
      gma500: address the lid code

Kirill A. Shutemov (12):
      gma500: mdfld_dsi_dpi_mode_set() do not corrupt DSPSTRIDE
      gma500: mid-bios: rewrite VBT/GCT handling in a cleaner way
      gma500: fix -Wmissing-include-dirs warnings
      gma500: cdv_intel_lvds: mark cdv_intel_lvds_enc_funcs as static
      gma500: oaktrail_hdmi_i2c_handler(): base should be __iomem
      gma500: lid_state should be __iomem
      gma500: psb_irq_turn_off_dpst() fix bit operation
      gma500: framebuffer: mark psb_fb_helper_funcs as static
      gma500: vram_addr should be __iomem
      gma500: sgx_reg and vdc_reg should be __iomem
      gma500: gtt: fix __iomem sparse warnings
      gma500: psb_gtt_init(): drop unused variable


 drivers/gpu/drm/gma500/Makefile            |    2 
 drivers/gpu/drm/gma500/cdv_intel_lvds.c    |    2 
 drivers/gpu/drm/gma500/framebuffer.c       |    5 
 drivers/gpu/drm/gma500/gtt.c               |   14 +
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c     |    1 
 drivers/gpu/drm/gma500/mid_bios.c          |  295 ++++++++++++++++++----------
 drivers/gpu/drm/gma500/oaktrail.h          |   25 +-
 drivers/gpu/drm/gma500/oaktrail_device.c   |    8 -
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c |    2 
 drivers/gpu/drm/gma500/oaktrail_lvds.c     |    4 
 drivers/gpu/drm/gma500/opregion.c          |    2 
 drivers/gpu/drm/gma500/psb_drv.c           |    2 
 drivers/gpu/drm/gma500/psb_drv.h           |   11 -
 drivers/gpu/drm/gma500/psb_irq.c           |    2 
 drivers/gpu/drm/gma500/psb_lid.c           |    2 
 15 files changed, 224 insertions(+), 153 deletions(-)

-- 
#include <witty.h>

