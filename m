From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 10/13] gma500: cdv_intel_lvds: mark cdv_intel_lvds_enc_funcs
 as static
Date: Wed, 02 May 2012 19:16:24 +0100
Message-ID: <20120502181621.26650.28531.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56304 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab2EBSRH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:17:07 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/cdv_intel_lvds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 44a8353..ff5b58e 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -556,7 +556,7 @@ static void cdv_intel_lvds_enc_destroy(struct drm_encoder *encoder)
 	drm_encoder_cleanup(encoder);
 }
 
-const struct drm_encoder_funcs cdv_intel_lvds_enc_funcs = {
+static const struct drm_encoder_funcs cdv_intel_lvds_enc_funcs = {
 	.destroy = cdv_intel_lvds_enc_destroy,
 };
 

