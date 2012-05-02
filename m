From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 12/13] gma500: mid-bios: rewrite VBT/GCT handling in a cleaner
 way
Date: Wed, 02 May 2012 19:17:04 +0100
Message-ID: <20120502181700.26650.75207.stgit@bluebook>
References: <20120502181044.26650.40123.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:56312 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab2EBSRr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 May 2012 14:17:47 -0400
In-Reply-To: <20120502181044.26650.40123.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/mid_bios.c        |  295 +++++++++++++++++++-----------
 drivers/gpu/drm/gma500/oaktrail.h        |   25 +--
 drivers/gpu/drm/gma500/oaktrail_device.c |    8 -
 drivers/gpu/drm/gma500/oaktrail_lvds.c   |    4 
 drivers/gpu/drm/gma500/psb_drv.h         |    2 
 5 files changed, 203 insertions(+), 131 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mid_bios.c b/drivers/gpu/drm/gma500/mid_bios.c
index 5eee9ad..b2a790b 100644
--- a/drivers/gpu/drm/gma500/mid_bios.c
+++ b/drivers/gpu/drm/gma500/mid_bios.c
@@ -118,139 +118,214 @@ static void mid_get_pci_revID(struct drm_psb_private *dev_priv)
 					dev_priv->platform_rev_id);
 }
 
+struct vbt_header {
+	u32 signature;
+	u8 revision;
+} __packed;
+
+/* The same for r0 and r1 */
+struct vbt_r0 {
+	struct vbt_header vbt_header;
+	u8 size;
+	u8 checksum;
+} __packed;
+
+struct vbt_r10 {
+	struct vbt_header vbt_header;
+	u8 checksum;
+	u16 size;
+	u8 panel_count;
+	u8 primary_panel_idx;
+	u8 secondary_panel_idx;
+	u8 __reserved[5];
+} __packed;
+
+static int read_vbt_r0(u32 addr, struct vbt_r0 *vbt)
+{
+	void __iomem *vbt_virtual;
+
+	vbt_virtual = ioremap(addr, sizeof(*vbt));
+	if (vbt_virtual == NULL)
+		return -1;
+
+	memcpy_fromio(vbt, vbt_virtual, sizeof(*vbt));
+	iounmap(vbt_virtual);
+
+	return 0;
+}
+
+static int read_vbt_r10(u32 addr, struct vbt_r10 *vbt)
+{
+	void __iomem *vbt_virtual;
+
+	vbt_virtual = ioremap(addr, sizeof(*vbt));
+	if (!vbt_virtual)
+		return -1;
+
+	memcpy_fromio(vbt, vbt_virtual, sizeof(*vbt));
+	iounmap(vbt_virtual);
+
+	return 0;
+}
+
+static int mid_get_vbt_data_r0(struct drm_psb_private *dev_priv, u32 addr)
+{
+	struct vbt_r0 vbt;
+	void __iomem *gct_virtual;
+	struct gct_r0 gct;
+	u8 bpi;
+
+	if (read_vbt_r0(addr, &vbt))
+		return -1;
+
+	gct_virtual = ioremap(addr + sizeof(vbt), vbt.size - sizeof(vbt));
+	if (!gct_virtual)
+		return -1;
+	memcpy_fromio(&gct, gct_virtual, sizeof(gct));
+	iounmap(gct_virtual);
+
+	bpi = gct.PD.BootPanelIndex;
+	dev_priv->gct_data.bpi = bpi;
+	dev_priv->gct_data.pt = gct.PD.PanelType;
+	dev_priv->gct_data.DTD = gct.panel[bpi].DTD;
+	dev_priv->gct_data.Panel_Port_Control =
+		gct.panel[bpi].Panel_Port_Control;
+	dev_priv->gct_data.Panel_MIPI_Display_Descriptor =
+		gct.panel[bpi].Panel_MIPI_Display_Descriptor;
+
+	return 0;
+}
+
+static int mid_get_vbt_data_r1(struct drm_psb_private *dev_priv, u32 addr)
+{
+	struct vbt_r0 vbt;
+	void __iomem *gct_virtual;
+	struct gct_r1 gct;
+	u8 bpi;
+
+	if (read_vbt_r0(addr, &vbt))
+		return -1;
+
+	gct_virtual = ioremap(addr + sizeof(vbt), vbt.size - sizeof(vbt));
+	if (!gct_virtual)
+		return -1;
+	memcpy_fromio(&gct, gct_virtual, sizeof(gct));
+	iounmap(gct_virtual);
+
+	bpi = gct.PD.BootPanelIndex;
+	dev_priv->gct_data.bpi = bpi;
+	dev_priv->gct_data.pt = gct.PD.PanelType;
+	dev_priv->gct_data.DTD = gct.panel[bpi].DTD;
+	dev_priv->gct_data.Panel_Port_Control =
+		gct.panel[bpi].Panel_Port_Control;
+	dev_priv->gct_data.Panel_MIPI_Display_Descriptor =
+		gct.panel[bpi].Panel_MIPI_Display_Descriptor;
+
+	return 0;
+}
+
+static int mid_get_vbt_data_r10(struct drm_psb_private *dev_priv, u32 addr)
+{
+	struct vbt_r10 vbt;
+	void __iomem *gct_virtual;
+	struct gct_r10 *gct;
+	struct oaktrail_timing_info *dp_ti = &dev_priv->gct_data.DTD;
+	struct gct_r10_timing_info *ti;
+	int ret = -1;
+
+	if (read_vbt_r10(addr, &vbt))
+		return -1;
+
+	gct = kmalloc(sizeof(*gct) * vbt.panel_count, GFP_KERNEL);
+	if (!gct)
+		return -1;
+
+	gct_virtual = ioremap(addr + sizeof(vbt),
+			sizeof(*gct) * vbt.panel_count);
+	if (!gct_virtual)
+		goto out;
+	memcpy_fromio(gct, gct_virtual, sizeof(*gct));
+	iounmap(gct_virtual);
+
+	dev_priv->gct_data.bpi = vbt.primary_panel_idx;
+	dev_priv->gct_data.Panel_MIPI_Display_Descriptor =
+		gct[vbt.primary_panel_idx].Panel_MIPI_Display_Descriptor;
+
+	ti = &gct[vbt.primary_panel_idx].DTD;
+	dp_ti->pixel_clock = ti->pixel_clock;
+	dp_ti->hactive_hi = ti->hactive_hi;
+	dp_ti->hactive_lo = ti->hactive_lo;
+	dp_ti->hblank_hi = ti->hblank_hi;
+	dp_ti->hblank_lo = ti->hblank_lo;
+	dp_ti->hsync_offset_hi = ti->hsync_offset_hi;
+	dp_ti->hsync_offset_lo = ti->hsync_offset_lo;
+	dp_ti->hsync_pulse_width_hi = ti->hsync_pulse_width_hi;
+	dp_ti->hsync_pulse_width_lo = ti->hsync_pulse_width_lo;
+	dp_ti->vactive_hi = ti->vactive_hi;
+	dp_ti->vactive_lo = ti->vactive_lo;
+	dp_ti->vblank_hi = ti->vblank_hi;
+	dp_ti->vblank_lo = ti->vblank_lo;
+	dp_ti->vsync_offset_hi = ti->vsync_offset_hi;
+	dp_ti->vsync_offset_lo = ti->vsync_offset_lo;
+	dp_ti->vsync_pulse_width_hi = ti->vsync_pulse_width_hi;
+	dp_ti->vsync_pulse_width_lo = ti->vsync_pulse_width_lo;
+
+	ret = 0;
+out:
+	kfree(gct);
+	return ret;
+}
+
 static void mid_get_vbt_data(struct drm_psb_private *dev_priv)
 {
 	struct drm_device *dev = dev_priv->dev;
-	struct oaktrail_vbt *vbt = &dev_priv->vbt_data;
 	u32 addr;
-	u16 new_size;
-	u8 *vbt_virtual;
-	u8 bpi;
-	u8 number_desc = 0;
-	struct oaktrail_timing_info *dp_ti = &dev_priv->gct_data.DTD;
-	struct gct_r10_timing_info ti;
-	void *pGCT;
+	u8 __iomem *vbt_virtual;
+	struct vbt_header vbt_header;
 	struct pci_dev *pci_gfx_root = pci_get_bus_and_slot(0, PCI_DEVFN(2, 0));
+	int ret = -1;
 
-	/* Get the address of the platform config vbt, B0:D2:F0;0xFC */
+	/* Get the address of the platform config vbt */
 	pci_read_config_dword(pci_gfx_root, 0xFC, &addr);
 	pci_dev_put(pci_gfx_root);
 
 	dev_dbg(dev->dev, "drm platform config address is %x\n", addr);
 
-	/* check for platform config address == 0. */
-	/* this means fw doesn't support vbt */
-
-	if (addr == 0) {
-		vbt->size = 0;
-		return;
-	}
+	if (!addr)
+		goto out;
 
 	/* get the virtual address of the vbt */
-	vbt_virtual = ioremap(addr, sizeof(*vbt));
-	if (vbt_virtual == NULL) {
-		vbt->size = 0;
-		return;
-	}
+	vbt_virtual = ioremap(addr, sizeof(vbt_header));
+	if (!vbt_virtual)
+		goto out;
 
-	memcpy(vbt, vbt_virtual, sizeof(*vbt));
-	iounmap(vbt_virtual); /* Free virtual address space */
+	memcpy_fromio(&vbt_header, vbt_virtual, sizeof(vbt_header));
+	iounmap(vbt_virtual);
 
-	/* No matching signature don't process the data */
-	if (memcmp(vbt->signature, "$GCT", 4)) {
-		vbt->size = 0;
-		return;
-	}
+	if (memcmp(&vbt_header.signature, "$GCT", 4))
+		goto out;
+
+	dev_dbg(dev->dev, "GCT revision is %02x\n", vbt_header.revision);
 
-	dev_dbg(dev->dev, "GCT revision is %x\n", vbt->revision);
-
-	switch (vbt->revision) {
-	case 0:
-		vbt->oaktrail_gct = ioremap(addr + sizeof(*vbt) - 4,
-					vbt->size - sizeof(*vbt) + 4);
-		pGCT = vbt->oaktrail_gct;
-		bpi = ((struct oaktrail_gct_v1 *)pGCT)->PD.BootPanelIndex;
-		dev_priv->gct_data.bpi = bpi;
-		dev_priv->gct_data.pt =
-			((struct oaktrail_gct_v1 *)pGCT)->PD.PanelType;
-		memcpy(&dev_priv->gct_data.DTD,
-			&((struct oaktrail_gct_v1 *)pGCT)->panel[bpi].DTD,
-				sizeof(struct oaktrail_timing_info));
-		dev_priv->gct_data.Panel_Port_Control =
-		  ((struct oaktrail_gct_v1 *)pGCT)->panel[bpi].Panel_Port_Control;
-		dev_priv->gct_data.Panel_MIPI_Display_Descriptor =
-			((struct oaktrail_gct_v1 *)pGCT)->panel[bpi].Panel_MIPI_Display_Descriptor;
+	switch (vbt_header.revision) {
+	case 0x00:
+		ret = mid_get_vbt_data_r0(dev_priv, addr);
 		break;
-	case 1:
-		vbt->oaktrail_gct = ioremap(addr + sizeof(*vbt) - 4,
-					vbt->size - sizeof(*vbt) + 4);
-		pGCT = vbt->oaktrail_gct;
-		bpi = ((struct oaktrail_gct_v2 *)pGCT)->PD.BootPanelIndex;
-		dev_priv->gct_data.bpi = bpi;
-		dev_priv->gct_data.pt =
-			((struct oaktrail_gct_v2 *)pGCT)->PD.PanelType;
-		memcpy(&dev_priv->gct_data.DTD,
-			&((struct oaktrail_gct_v2 *)pGCT)->panel[bpi].DTD,
-				sizeof(struct oaktrail_timing_info));
-		dev_priv->gct_data.Panel_Port_Control =
-		  ((struct oaktrail_gct_v2 *)pGCT)->panel[bpi].Panel_Port_Control;
-		dev_priv->gct_data.Panel_MIPI_Display_Descriptor =
-			((struct oaktrail_gct_v2 *)pGCT)->panel[bpi].Panel_MIPI_Display_Descriptor;
+	case 0x01:
+		ret = mid_get_vbt_data_r1(dev_priv, addr);
 		break;
 	case 0x10:
-		/*header definition changed from rev 01 (v2) to rev 10h. */
-		/*so, some values have changed location*/
-		new_size = vbt->checksum; /*checksum contains lo size byte*/
-		/*LSB of oaktrail_gct contains hi size byte*/
-		new_size |= ((0xff & (unsigned int)(long)vbt->oaktrail_gct)) << 8;
-
-		vbt->checksum = vbt->size; /*size contains the checksum*/
-		if (new_size > 0xff)
-			vbt->size = 0xff; /*restrict size to 255*/
-		else
-			vbt->size = new_size;
-
-		/* number of descriptors defined in the GCT */
-		number_desc = ((0xff00 & (unsigned int)(long)vbt->oaktrail_gct)) >> 8;
-		bpi = ((0xff0000 & (unsigned int)(long)vbt->oaktrail_gct)) >> 16;
-		vbt->oaktrail_gct = ioremap(addr + GCT_R10_HEADER_SIZE,
-				GCT_R10_DISPLAY_DESC_SIZE * number_desc);
-		pGCT = vbt->oaktrail_gct;
-		pGCT = (u8 *)pGCT + (bpi*GCT_R10_DISPLAY_DESC_SIZE);
-		dev_priv->gct_data.bpi = bpi; /*save boot panel id*/
-
-		/*copy the GCT display timings into a temp structure*/
-		memcpy(&ti, pGCT, sizeof(struct gct_r10_timing_info));
-
-		/*now copy the temp struct into the dev_priv->gct_data*/
-		dp_ti->pixel_clock = ti.pixel_clock;
-		dp_ti->hactive_hi = ti.hactive_hi;
-		dp_ti->hactive_lo = ti.hactive_lo;
-		dp_ti->hblank_hi = ti.hblank_hi;
-		dp_ti->hblank_lo = ti.hblank_lo;
-		dp_ti->hsync_offset_hi = ti.hsync_offset_hi;
-		dp_ti->hsync_offset_lo = ti.hsync_offset_lo;
-		dp_ti->hsync_pulse_width_hi = ti.hsync_pulse_width_hi;
-		dp_ti->hsync_pulse_width_lo = ti.hsync_pulse_width_lo;
-		dp_ti->vactive_hi = ti.vactive_hi;
-		dp_ti->vactive_lo = ti.vactive_lo;
-		dp_ti->vblank_hi = ti.vblank_hi;
-		dp_ti->vblank_lo = ti.vblank_lo;
-		dp_ti->vsync_offset_hi = ti.vsync_offset_hi;
-		dp_ti->vsync_offset_lo = ti.vsync_offset_lo;
-		dp_ti->vsync_pulse_width_hi = ti.vsync_pulse_width_hi;
-		dp_ti->vsync_pulse_width_lo = ti.vsync_pulse_width_lo;
-
-		/* Move the MIPI_Display_Descriptor data from GCT to dev priv */
-		dev_priv->gct_data.Panel_MIPI_Display_Descriptor =
-							*((u8 *)pGCT + 0x0d);
-		dev_priv->gct_data.Panel_MIPI_Display_Descriptor |=
-						(*((u8 *)pGCT + 0x0e)) << 8;
+		ret = mid_get_vbt_data_r10(dev_priv, addr);
 		break;
 	default:
 		dev_err(dev->dev, "Unknown revision of GCT!\n");
-		vbt->size = 0;
 	}
+
+out:
+	if (ret)
+		dev_err(dev->dev, "Unable to read GCT!");
+	else
+		dev_priv->has_gct = true;
 }
 
 int mid_chip_setup(struct drm_device *dev)
diff --git a/drivers/gpu/drm/gma500/oaktrail.h b/drivers/gpu/drm/gma500/oaktrail.h
index 2da1f36..f2f9f38 100644
--- a/drivers/gpu/drm/gma500/oaktrail.h
+++ b/drivers/gpu/drm/gma500/oaktrail.h
@@ -19,14 +19,6 @@
 
 /* MID device specific descriptors */
 
-struct oaktrail_vbt {
-	s8 signature[4];	/*4 bytes,"$GCT" */
-	u8 revision;
-	u8 size;
-	u8 checksum;
-	void *oaktrail_gct;
-} __packed;
-
 struct oaktrail_timing_info {
 	u16 pixel_clock;
 	u8 hactive_lo;
@@ -161,7 +153,7 @@ union oaktrail_panel_rx {
 	u16 panel_receiver;
 } __packed;
 
-struct oaktrail_gct_v1 {
+struct gct_r0 {
 	union { /*8 bits,Defined as follows: */
 		struct {
 			u8 PanelType:4; /*4 bits, Bit field for panels*/
@@ -178,7 +170,7 @@ struct oaktrail_gct_v1 {
 	union oaktrail_panel_rx panelrx[4]; /* panel receivers*/
 } __packed;
 
-struct oaktrail_gct_v2 {
+struct gct_r1 {
 	union { /*8 bits,Defined as follows: */
 		struct {
 			u8 PanelType:4; /*4 bits, Bit field for panels*/
@@ -195,6 +187,16 @@ struct oaktrail_gct_v2 {
 	union oaktrail_panel_rx panelrx[4]; /* panel receivers*/
 } __packed;
 
+struct gct_r10 {
+	struct gct_r10_timing_info DTD;
+	u16 Panel_MIPI_Display_Descriptor;
+	u16 Panel_MIPI_Receiver_Descriptor;
+	u16 Panel_Backlight_Inverter_Descriptor;
+	u8 Panel_Initial_Brightness;
+	u32 MIPI_Ctlr_Init_ptr;
+	u32 MIPI_Panel_Init_ptr;
+} __packed;
+
 struct oaktrail_gct_data {
 	u8 bpi; /* boot panel index, number of panel used during boot */
 	u8 pt; /* panel type, 4 bit field, 0=lvds, 1=mipi */
@@ -213,9 +215,6 @@ struct oaktrail_gct_data {
 #define MODE_SETTING_IN_DSR		0x4
 #define MODE_SETTING_ENCODER_DONE	0x8
 
-#define GCT_R10_HEADER_SIZE		16
-#define GCT_R10_DISPLAY_DESC_SIZE	28
-
 /*
  *	Moorestown HDMI interfaces
  */
diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/drm/gma500/oaktrail_device.c
index b152134..0bb74cc 100644
--- a/drivers/gpu/drm/gma500/oaktrail_device.c
+++ b/drivers/gpu/drm/gma500/oaktrail_device.c
@@ -458,13 +458,12 @@ static int oaktrail_power_up(struct drm_device *dev)
 static int oaktrail_chip_setup(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	struct oaktrail_vbt *vbt = &dev_priv->vbt_data;
 	int ret;
-	
+
 	ret = mid_chip_setup(dev);
 	if (ret < 0)
 		return ret;
-	if (vbt->size == 0) {
+	if (!dev_priv->has_gct) {
 		/* Now pull the BIOS data */
 		psb_intel_opregion_init(dev);
 		psb_intel_init_bios(dev);
@@ -476,10 +475,9 @@ static int oaktrail_chip_setup(struct drm_device *dev)
 static void oaktrail_teardown(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
-	struct oaktrail_vbt *vbt = &dev_priv->vbt_data;
 
 	oaktrail_hdmi_teardown(dev);
-	if (vbt->size == 0)
+	if (!dev_priv->has_gct)
 		psb_intel_destroy_bios(dev);
 }
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds.c b/drivers/gpu/drm/gma500/oaktrail_lvds.c
index 654f32b..558c77f 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds.c
@@ -257,7 +257,7 @@ static void oaktrail_lvds_get_configuration_mode(struct drm_device *dev,
 	mode_dev->panel_fixed_mode = NULL;
 
 	/* Use the firmware provided data on Moorestown */
-	if (dev_priv->vbt_data.size != 0x00) { /*if non-zero, then use vbt*/
+	if (dev_priv->has_gct) {
 		mode = kzalloc(sizeof(*mode), GFP_KERNEL);
 		if (!mode)
 			return;
@@ -371,7 +371,7 @@ void oaktrail_lvds_init(struct drm_device *dev,
 					BRIGHTNESS_MAX_LEVEL);
 
 	mode_dev->panel_wants_dither = false;
-	if (dev_priv->vbt_data.size != 0x00)
+	if (dev_priv->has_gct)
 		mode_dev->panel_wants_dither = (dev_priv->gct_data.
 			Panel_Port_Control & MRST_PANEL_8TO6_DITHER_ENABLE);
         if (dev_priv->lvds_dither)
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index 67a863b..270a27b 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -612,7 +612,7 @@ struct drm_psb_private {
 	int rpm_enabled;
 
 	/* MID specific */
-	struct oaktrail_vbt vbt_data;
+	bool has_gct;
 	struct oaktrail_gct_data gct_data;
 
 	/* Oaktrail HDMI state */

