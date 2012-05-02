From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 03/13] gma500: gtt: fix __iomem sparse warnings
Date: Wed, 02 May 2012 19:13:19 +0100
Message-ID: <20120502181314.26650.42621.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56278 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab2EBSOC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:14:02 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/gtt.c     |   11 +++++++----
 drivers/gpu/drm/gma500/psb_drv.h |    2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gtt.c b/drivers/gpu/drm/gma500/gtt.c
index 7d6f737..4cd33df 100644
--- a/drivers/gpu/drm/gma500/gtt.c
+++ b/drivers/gpu/drm/gma500/gtt.c
@@ -61,7 +61,7 @@ static inline uint32_t psb_gtt_mask_pte(uint32_t pfn, int type)
  *	Given a gtt_range object return the GTT offset of the page table
  *	entries for this gtt_range
  */
-static u32 *psb_gtt_entry(struct drm_device *dev, struct gtt_range *r)
+static u32 __iomem *psb_gtt_entry(struct drm_device *dev, struct gtt_range *r)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	unsigned long offset;
@@ -82,7 +82,8 @@ static u32 *psb_gtt_entry(struct drm_device *dev, struct gtt_range *r)
  */
 static int psb_gtt_insert(struct drm_device *dev, struct gtt_range *r)
 {
-	u32 *gtt_slot, pte;
+	u32 __iomem *gtt_slot;
+	u32 pte;
 	struct page **pages;
 	int i;
 
@@ -126,7 +127,8 @@ static int psb_gtt_insert(struct drm_device *dev, struct gtt_range *r)
 static void psb_gtt_remove(struct drm_device *dev, struct gtt_range *r)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	u32 *gtt_slot, pte;
+	u32 __iomem *gtt_slot;
+	u32 pte;
 	int i;
 
 	WARN_ON(r->stolen);
@@ -152,7 +154,8 @@ static void psb_gtt_remove(struct drm_device *dev, struct gtt_range *r)
  */
 void psb_gtt_roll(struct drm_device *dev, struct gtt_range *r, int roll)
 {
-	u32 *gtt_slot, pte;
+	u32 __iomem *gtt_slot;
+	u32 pte;
 	int i;
 
 	if (roll >= r->npage) {
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 5c5c3d0..9dc4476 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -507,7 +507,7 @@ struct drm_psb_private {
 	/* GTT Memory manager */
 	struct psb_gtt_mm *gtt_mm;
 	struct page *scratch_page;
-	u32 *gtt_map;
+	u32 __iomem *gtt_map;
 	uint32_t stolen_base;
 	void *vram_addr;
 	unsigned long vram_stolen_size;

