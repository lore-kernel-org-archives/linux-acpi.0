From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 6/6] gma500: Set the mapping mask
Date: Tue, 24 Apr 2012 16:48:30 +0100
Message-ID: <20120424154821.1631.18527.stgit@bluebook>
References: <20120424154548.1631.58977.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34207 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab2DXPtD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Apr 2012 11:49:03 -0400
In-Reply-To: <20120424154548.1631.58977.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Some boards such as the Intel D2700MUD allow you to have over 4GB of RAM.
The GTT on the PVR based devices is 32bit however. Hugh Dickins points out
that we should therefore be setting the mapping gfp mask.

This is not the whole fix for the problem. Some further shmem patches will
be needed to deal with the corner cases.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/gem.c |    2 ++
 drivers/gpu/drm/gma500/gtt.c |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 9fbb868..fc7d144 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -124,6 +124,8 @@ static int psb_gem_create(struct drm_file *file,
 		dev_err(dev->dev, "GEM init failed for %lld\n", size);
 		return -ENOMEM;
 	}
+	/* Limit the object to 32bit mappings */
+	mapping_set_gfp_mask(r->gem.filp->f_mapping, GFP_KERNEL | __GFP_DMA32);
 	/* Give the object a handle so we can carry it more easily */
 	ret = drm_gem_handle_create(file, &r->gem, &handle);
 	if (ret) {
diff --git a/drivers/gpu/drm/gma500/gtt.c b/drivers/gpu/drm/gma500/gtt.c
index db2e823..54e5c9e 100644
--- a/drivers/gpu/drm/gma500/gtt.c
+++ b/drivers/gpu/drm/gma500/gtt.c
@@ -39,6 +39,10 @@ static inline uint32_t psb_gtt_mask_pte(uint32_t pfn, int type)
 {
 	uint32_t mask = PSB_PTE_VALID;
 
+	/* Ensure we explode rather than put an invalid low mapping of
+	   a high mapping page into the gtt */
+	BUG_ON(pfn & ~(0xFFFFFFFF >> PAGE_SHIFT));
+
 	if (type & PSB_MMU_CACHED_MEMORY)
 		mask |= PSB_PTE_CACHED;
 	if (type & PSB_MMU_RO_MEMORY)

