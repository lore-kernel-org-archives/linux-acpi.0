From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 02/13] gma500: psb_gtt_init(): drop unused variable
Date: Wed, 02 May 2012 19:13:03 +0100
Message-ID: <20120502181300.26650.51122.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56275 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab2EBSNq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:13:46 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/gtt.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/gtt.c b/drivers/gpu/drm/gma500/gtt.c
index 54e5c9e..7d6f737 100644
--- a/drivers/gpu/drm/gma500/gtt.c
+++ b/drivers/gpu/drm/gma500/gtt.c
@@ -413,7 +413,6 @@ int psb_gtt_init(struct drm_device *dev, int resume)
 	unsigned long stolen_size, vram_stolen_size;
 	unsigned i, num_pages;
 	unsigned pfn_base;
-	uint32_t vram_pages;
 	uint32_t dvmt_mode = 0;
 	struct psb_gtt *pg;
 
@@ -529,7 +528,7 @@ int psb_gtt_init(struct drm_device *dev, int resume)
 	 */
 
 	pfn_base = dev_priv->stolen_base >> PAGE_SHIFT;
-	vram_pages = num_pages = vram_stolen_size >> PAGE_SHIFT;
+	num_pages = vram_stolen_size >> PAGE_SHIFT;
 	printk(KERN_INFO"Set up %d stolen pages starting at 0x%08x, GTT offset %dK\n",
 		num_pages, pfn_base << PAGE_SHIFT, 0);
 	for (i = 0; i < num_pages; ++i) {

