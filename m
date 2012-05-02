From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 05/13] gma500: vram_addr should be __iomem
Date: Wed, 02 May 2012 19:13:47 +0100
Message-ID: <20120502181342.26650.75371.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab2EBSOa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:14:30 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/framebuffer.c |    3 +--
 drivers/gpu/drm/gma500/psb_drv.h     |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 4fc0d08..30400b6 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -455,8 +455,7 @@ static int psbfb_create(struct psb_fbdev *fbdev,
 	info->fix.ypanstep = 0;
 
 	/* Accessed stolen memory directly */
-	info->screen_base = (char *)dev_priv->vram_addr +
-							backing->offset;
+	info->screen_base = dev_priv->vram_addr + backing->offset;
 	info->screen_size = size;
 
 	if (dev_priv->gtt.stolen_size) {
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index e59511d..67a863b 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -509,7 +509,7 @@ struct drm_psb_private {
 	struct page *scratch_page;
 	u32 __iomem *gtt_map;
 	uint32_t stolen_base;
-	void *vram_addr;
+	u8 __iomem *vram_addr;
 	unsigned long vram_stolen_size;
 	int gtt_initialized;
 	u16 gmch_ctrl;		/* Saved GTT setup */

