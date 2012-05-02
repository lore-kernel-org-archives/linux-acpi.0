From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 06/13] gma500: framebuffer: mark psb_fb_helper_funcs as static
Date: Wed, 02 May 2012 19:14:01 +0100
Message-ID: <20120502181358.26650.63773.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56288 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab2EBSOn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:14:43 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/framebuffer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 30400b6..f47f883 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -572,7 +572,7 @@ static int psbfb_probe(struct drm_fb_helper *helper,
 	return new_fb;
 }
 
-struct drm_fb_helper_funcs psb_fb_helper_funcs = {
+static struct drm_fb_helper_funcs psb_fb_helper_funcs = {
 	.gamma_set = psbfb_gamma_set,
 	.gamma_get = psbfb_gamma_get,
 	.fb_probe = psbfb_probe,

