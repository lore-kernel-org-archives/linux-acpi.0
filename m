From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] gma500: wide framebuffer memory
Date: Tue, 01 May 2012 14:31:55 +0100
Message-ID: <20120501133119.1682.36727.stgit@bluebook>
References: <20120501133037.1682.58297.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54660 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2EANcj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2012 09:32:39 -0400
In-Reply-To: <20120501133037.1682.58297.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

If we set a small text framebuffer and have a bigger scanout then we want
to send black not random bits for the overscan.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/framebuffer.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index c9fe4bd..4fc0d08 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -408,6 +408,8 @@ static int psbfb_create(struct psb_fbdev *fbdev,
 			return -ENOMEM;
 	}
 
+	memset(dev_priv->vram_addr + backing->offset, 0, size);
+
 	mutex_lock(&dev->struct_mutex);
 
 	info = framebuffer_alloc(0, device);

