From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 09/13] gma500: oaktrail_hdmi_i2c_handler(): base should be
 __iomem
Date: Wed, 02 May 2012 19:16:10 +0100
Message-ID: <20120502181438.26650.27864.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56301 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755424Ab2EBSQy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:16:54 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
index 5e84fbd..88627e3 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
@@ -250,7 +250,7 @@ static irqreturn_t oaktrail_hdmi_i2c_handler(int this_irq, void *dev)
  */
 static void oaktrail_hdmi_i2c_gpio_fix(void)
 {
-	void *base;
+	void __iomem *base;
 	unsigned int gpio_base = 0xff12c000;
 	int gpio_len = 0x1000;
 	u32 temp;

