From: akpm@osdl.org
Subject: [patch 10/19] fbdev: update after backlight argument change
Date: Tue, 19 Dec 2006 12:56:16 -0800
Message-ID: <200612192056.kBJKuGlm010035@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:34497 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932952AbWLSU5F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Dec 2006 15:57:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, jsimmons@infradead.org, Luming.yu@intel.com, adaplas@pol.net, greg@kroah.com, len.brown@intel.com

From: James Simmons <jsimmons@infradead.org>

Update the frambuffer drivers to the backlight_device_registers changes.

Signed-off-by: James Simmons <jsimmons@infradead.org>
Cc: Luming Yu <Luming.yu@intel.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Greg KH <greg@kroah.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/aty128fb.c         |    2 +-
 drivers/video/aty/atyfb_base.c       |    2 +-
 drivers/video/aty/radeon_backlight.c |    2 +-
 drivers/video/nvidia/nv_backlight.c  |    2 +-
 drivers/video/riva/fbdev.c           |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/video/aty/aty128fb.c~fbdev-update-after-backlight-argument-change drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c~fbdev-update-after-backlight-argument-change
+++ a/drivers/video/aty/aty128fb.c
@@ -1834,7 +1834,7 @@ static void aty128_bl_init(struct aty128
 
 	snprintf(name, sizeof(name), "aty128bl%d", info->node);
 
-	bd = backlight_device_register(name, par, &aty128_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &aty128_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "aty128: Backlight registration failed\n");
diff -puN drivers/video/aty/atyfb_base.c~fbdev-update-after-backlight-argument-change drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c~fbdev-update-after-backlight-argument-change
+++ a/drivers/video/aty/atyfb_base.c
@@ -2211,7 +2211,7 @@ static void aty_bl_init(struct atyfb_par
 
 	snprintf(name, sizeof(name), "atybl%d", info->node);
 
-	bd = backlight_device_register(name, par, &aty_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &aty_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "aty: Backlight registration failed\n");
diff -puN drivers/video/aty/radeon_backlight.c~fbdev-update-after-backlight-argument-change drivers/video/aty/radeon_backlight.c
--- a/drivers/video/aty/radeon_backlight.c~fbdev-update-after-backlight-argument-change
+++ a/drivers/video/aty/radeon_backlight.c
@@ -163,7 +163,7 @@ void radeonfb_bl_init(struct radeonfb_in
 
 	snprintf(name, sizeof(name), "radeonbl%d", rinfo->info->node);
 
-	bd = backlight_device_register(name, pdata, &radeon_bl_data);
+	bd = backlight_device_register(name, rinfo->info->dev, pdata, &radeon_bl_data);
 	if (IS_ERR(bd)) {
 		rinfo->info->bl_dev = NULL;
 		printk("radeonfb: Backlight registration failed\n");
diff -puN drivers/video/nvidia/nv_backlight.c~fbdev-update-after-backlight-argument-change drivers/video/nvidia/nv_backlight.c
--- a/drivers/video/nvidia/nv_backlight.c~fbdev-update-after-backlight-argument-change
+++ a/drivers/video/nvidia/nv_backlight.c
@@ -141,7 +141,7 @@ void nvidia_bl_init(struct nvidia_par *p
 
 	snprintf(name, sizeof(name), "nvidiabl%d", info->node);
 
-	bd = backlight_device_register(name, par, &nvidia_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &nvidia_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "nvidia: Backlight registration failed\n");
diff -puN drivers/video/riva/fbdev.c~fbdev-update-after-backlight-argument-change drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c~fbdev-update-after-backlight-argument-change
+++ a/drivers/video/riva/fbdev.c
@@ -384,7 +384,7 @@ static void riva_bl_init(struct riva_par
 
 	snprintf(name, sizeof(name), "rivabl%d", info->node);
 
-	bd = backlight_device_register(name, par, &riva_bl_data);
+	bd = backlight_device_register(name, info->dev, par, &riva_bl_data);
 	if (IS_ERR(bd)) {
 		info->bl_dev = NULL;
 		printk(KERN_WARNING "riva: Backlight registration failed\n");
_
