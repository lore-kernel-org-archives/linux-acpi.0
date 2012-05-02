From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 08/13] gma500: lid_state should be __iomem
Date: Wed, 02 May 2012 19:14:27 +0100
Message-ID: <20120502181423.26650.14095.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56294 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755965Ab2EBSPK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:15:10 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

This was mostly already fixed but this one change is needed to match Kirill's
original submission

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/opregion.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/opregion.c b/drivers/gpu/drm/gma500/opregion.c
index 483e0b2..05661bf 100644
--- a/drivers/gpu/drm/gma500/opregion.c
+++ b/drivers/gpu/drm/gma500/opregion.c
@@ -302,7 +302,7 @@ int psb_intel_opregion_setup(struct drm_device *dev)
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	struct psb_intel_opregion *opregion = &dev_priv->opregion;
 	u32 opregion_phy, mboxes;
-	void *base;
+	void __iomem *base;
 	int err = 0;
 
 	pci_read_config_dword(dev->pdev, PCI_ASLS, &opregion_phy);

