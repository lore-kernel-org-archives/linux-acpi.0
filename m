From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/4] gma500: opregion and ACPI
Date: Tue, 01 May 2012 14:33:05 +0100
Message-ID: <20120501133223.1682.73707.stgit@bluebook>
References: <20120501133037.1682.58297.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:54669 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2EANdv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 May 2012 09:33:51 -0400
In-Reply-To: <20120501133037.1682.58297.stgit@bluebook>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Add the opregion support and bring us in line with the opregion functionality in the
reference driver code. We can't share this with i915 currently because there are
hardcoded assumptions about dev_priv etc in both versions.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/gpu/drm/gma500/Makefile          |    2 
 drivers/gpu/drm/gma500/cdv_device.c      |    4 
 drivers/gpu/drm/gma500/intel_opregion.c  |  178 ---------------
 drivers/gpu/drm/gma500/oaktrail_device.c |    2 
 drivers/gpu/drm/gma500/opregion.c        |  350 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/gma500/psb_device.c      |    2 
 drivers/gpu/drm/gma500/psb_drv.c         |    8 -
 drivers/gpu/drm/gma500/psb_drv.h         |    4 
 drivers/gpu/drm/gma500/psb_intel_reg.h   |    1 
 drivers/gpu/drm/gma500/psb_irq.c         |    4 
 10 files changed, 367 insertions(+), 188 deletions(-)
 delete mode 100644 drivers/gpu/drm/gma500/intel_opregion.c
 create mode 100644 drivers/gpu/drm/gma500/opregion.c

diff --git a/drivers/gpu/drm/gma500/Makefile b/drivers/gpu/drm/gma500/Makefile
index 1583982..efdad01 100644
--- a/drivers/gpu/drm/gma500/Makefile
+++ b/drivers/gpu/drm/gma500/Makefile
@@ -12,8 +12,8 @@ gma500_gfx-y += gem_glue.o \
 	  intel_bios.o \
 	  intel_i2c.o \
 	  intel_gmbus.o \
-	  intel_opregion.o \
 	  mmu.o \
+	  opregion.o \
 	  power.o \
 	  psb_drv.o \
 	  psb_intel_display.o \
diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index 726bfb7..c10f020 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -157,7 +157,7 @@ static int cdv_backlight_init(struct drm_device *dev)
 
 	cdv_backlight_device->props.brightness =
 			cdv_get_brightness(cdv_backlight_device);
-	cdv_backlight_device->props.max_brightness = cdv_get_max_brightness;
+	cdv_backlight_device->props.max_brightness = cdv_get_max_backlight(dev);
 	backlight_update_status(cdv_backlight_device);
 	dev_priv->backlight_device = cdv_backlight_device;
 	return 0;
@@ -490,7 +490,7 @@ static int cdv_chip_setup(struct drm_device *dev)
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	INIT_WORK(&dev_priv->hotplug_work, cdv_hotplug_work_func);
 	cdv_get_core_freq(dev);
-	gma_intel_opregion_init(dev);
+	psb_intel_opregion_init(dev);
 	psb_intel_init_bios(dev);
 	cdv_hotplug_enable(dev, false);
 	return 0;
diff --git a/drivers/gpu/drm/gma500/intel_opregion.c b/drivers/gpu/drm/gma500/intel_opregion.c
deleted file mode 100644
index 7041f40..0000000
--- a/drivers/gpu/drm/gma500/intel_opregion.c
+++ /dev/null
@@ -1,178 +0,0 @@
-/*
- * Copyright 2010 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
- *
- * FIXME: resolve with the i915 version
- */
-
-#include "psb_drv.h"
-
-#define PCI_ASLE 0xe4
-#define PCI_ASLS 0xfc
-
-#define OPREGION_HEADER_OFFSET 0
-#define OPREGION_ACPI_OFFSET   0x100
-#define   ACPI_CLID 0x01ac /* current lid state indicator */
-#define   ACPI_CDCK 0x01b0 /* current docking state indicator */
-#define OPREGION_SWSCI_OFFSET  0x200
-#define OPREGION_ASLE_OFFSET   0x300
-#define OPREGION_VBT_OFFSET    0x400
-
-#define OPREGION_SIGNATURE "IntelGraphicsMem"
-#define MBOX_ACPI      (1<<0)
-#define MBOX_SWSCI     (1<<1)
-#define MBOX_ASLE      (1<<2)
-
-struct opregion_header {
-	u8 signature[16];
-	u32 size;
-	u32 opregion_ver;
-	u8 bios_ver[32];
-	u8 vbios_ver[16];
-	u8 driver_ver[16];
-	u32 mboxes;
-	u8 reserved[164];
-} __packed;
-
-/* OpRegion mailbox #1: public ACPI methods */
-struct opregion_acpi {
-	u32 drdy;       /* driver readiness */
-	u32 csts;       /* notification status */
-	u32 cevt;       /* current event */
-	u8 rsvd1[20];
-	u32 didl[8];    /* supported display devices ID list */
-	u32 cpdl[8];    /* currently presented display list */
-	u32 cadl[8];    /* currently active display list */
-	u32 nadl[8];    /* next active devices list */
-	u32 aslp;       /* ASL sleep time-out */
-	u32 tidx;       /* toggle table index */
-	u32 chpd;       /* current hotplug enable indicator */
-	u32 clid;       /* current lid state*/
-	u32 cdck;       /* current docking state */
-	u32 sxsw;       /* Sx state resume */
-	u32 evts;       /* ASL supported events */
-	u32 cnot;       /* current OS notification */
-	u32 nrdy;       /* driver status */
-	u8 rsvd2[60];
-} __attribute__((packed));
-
-/* OpRegion mailbox #2: SWSCI */
-struct opregion_swsci {
-	u32 scic;       /* SWSCI command|status|data */
-	u32 parm;       /* command parameters */
-	u32 dslp;       /* driver sleep time-out */
-	u8 rsvd[244];
-} __attribute__((packed));
-
-/* OpRegion mailbox #3: ASLE */
-struct opregion_asle {
-	u32 ardy;       /* driver readiness */
-	u32 aslc;       /* ASLE interrupt command */
-	u32 tche;       /* technology enabled indicator */
-	u32 alsi;       /* current ALS illuminance reading */
-	u32 bclp;       /* backlight brightness to set */
-	u32 pfit;       /* panel fitting state */
-	u32 cblv;       /* current brightness level */
-	u16 bclm[20];   /* backlight level duty cycle mapping table */
-	u32 cpfm;       /* current panel fitting mode */
-	u32 epfm;       /* enabled panel fitting modes */
-	u8 plut[74];    /* panel LUT and identifier */
-	u32 pfmb;       /* PWM freq and min brightness */
-	u8 rsvd[102];
-} __attribute__((packed));
-
-/* ASLE irq request bits */
-#define ASLE_SET_ALS_ILLUM     (1 << 0)
-#define ASLE_SET_BACKLIGHT     (1 << 1)
-#define ASLE_SET_PFIT          (1 << 2)
-#define ASLE_SET_PWM_FREQ      (1 << 3)
-#define ASLE_REQ_MSK           0xf
-
-/* response bits of ASLE irq request */
-#define ASLE_ALS_ILLUM_FAILED	(1<<10)
-#define ASLE_BACKLIGHT_FAILED	(1<<12)
-#define ASLE_PFIT_FAILED	(1<<14)
-#define ASLE_PWM_FREQ_FAILED	(1<<16)
-
-/* ASLE backlight brightness to set */
-#define ASLE_BCLP_VALID                (1<<31)
-#define ASLE_BCLP_MSK          (~(1<<31))
-
-/* ASLE panel fitting request */
-#define ASLE_PFIT_VALID         (1<<31)
-#define ASLE_PFIT_CENTER (1<<0)
-#define ASLE_PFIT_STRETCH_TEXT (1<<1)
-#define ASLE_PFIT_STRETCH_GFX (1<<2)
-
-/* PWM frequency and minimum brightness */
-#define ASLE_PFMB_BRIGHTNESS_MASK (0xff)
-#define ASLE_PFMB_BRIGHTNESS_VALID (1<<8)
-#define ASLE_PFMB_PWM_MASK (0x7ffffe00)
-#define ASLE_PFMB_PWM_VALID (1<<31)
-
-#define ASLE_CBLV_VALID         (1<<31)
-
-#define ACPI_OTHER_OUTPUT (0<<8)
-#define ACPI_VGA_OUTPUT (1<<8)
-#define ACPI_TV_OUTPUT (2<<8)
-#define ACPI_DIGITAL_OUTPUT (3<<8)
-#define ACPI_LVDS_OUTPUT (4<<8)
-
-int gma_intel_opregion_init(struct drm_device *dev)
-{
-	struct drm_psb_private *dev_priv = dev->dev_private;
-	struct psb_intel_opregion *opregion = &dev_priv->opregion;
-	u32 opregion_phy;
-	void *base;
-	u32 *lid_state;
-
-	dev_priv->lid_state = NULL;
-
-	pci_read_config_dword(dev->pdev, 0xfc, &opregion_phy);
-	if (opregion_phy == 0)
-		return -ENOTSUPP;
-
-	base = ioremap(opregion_phy, 8*1024);
-	if (!base)
-		return -ENOMEM;
-	/* FIXME: should use _io ops - ditto on i915 */
-	if (memcmp(base, OPREGION_SIGNATURE, 16)) {
-		DRM_ERROR("opregion signature mismatch\n");
-		iounmap(base);
-		return -EINVAL;
-	}
-
-	lid_state = base + 0x01ac;
-
-	dev_priv->lid_state = lid_state;
-	dev_priv->lid_last_state = readl(lid_state);
-	opregion->header = base;
-	opregion->vbt = base + OPREGION_VBT_OFFSET;
-	return 0;
-}
-
-int gma_intel_opregion_exit(struct drm_device *dev)
-{
-	struct drm_psb_private *dev_priv = dev->dev_private;
-	if (dev_priv->opregion.header)
-		iounmap(dev_priv->opregion.header);
-	return 0;
-}
diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/drm/gma500/oaktrail_device.c
index d0b2244..b152134 100644
--- a/drivers/gpu/drm/gma500/oaktrail_device.c
+++ b/drivers/gpu/drm/gma500/oaktrail_device.c
@@ -466,7 +466,7 @@ static int oaktrail_chip_setup(struct drm_device *dev)
 		return ret;
 	if (vbt->size == 0) {
 		/* Now pull the BIOS data */
-		gma_intel_opregion_init(dev);
+		psb_intel_opregion_init(dev);
 		psb_intel_init_bios(dev);
 	}
 	oaktrail_hdmi_setup(dev);
diff --git a/drivers/gpu/drm/gma500/opregion.c b/drivers/gpu/drm/gma500/opregion.c
new file mode 100644
index 0000000..483e0b2
--- /dev/null
+++ b/drivers/gpu/drm/gma500/opregion.c
@@ -0,0 +1,350 @@
+/*
+ * Copyright 2011 Intel Corporation
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifdef CONFIG_ACPI
+#include <linux/acpi.h>
+#include <linux/acpi_io.h>
+#endif
+#include "psb_drv.h"
+#include "psb_intel_reg.h"
+
+#define PCI_ASLE 0xe4
+#define PCI_ASLS 0xfc
+
+#define OPREGION_HEADER_OFFSET 0
+#define OPREGION_ACPI_OFFSET   0x100
+#define   ACPI_CLID 0x01ac /* current lid state indicator */
+#define   ACPI_CDCK 0x01b0 /* current docking state indicator */
+#define OPREGION_SWSCI_OFFSET  0x200
+#define OPREGION_ASLE_OFFSET   0x300
+#define OPREGION_VBT_OFFSET    0x400
+
+#define OPREGION_SIGNATURE "IntelGraphicsMem"
+#define MBOX_ACPI      (1<<0)
+#define MBOX_SWSCI     (1<<1)
+#define MBOX_ASLE      (1<<2)
+
+struct opregion_header {
+	u8 signature[16];
+	u32 size;
+	u32 opregion_ver;
+	u8 bios_ver[32];
+	u8 vbios_ver[16];
+	u8 driver_ver[16];
+	u32 mboxes;
+	u8 reserved[164];
+} __packed;
+
+/* OpRegion mailbox #1: public ACPI methods */
+struct opregion_acpi {
+	u32 drdy;	/* driver readiness */
+	u32 csts;	/* notification status */
+	u32 cevt;	/* current event */
+	u8 rsvd1[20];
+	u32 didl[8];	/* supported display devices ID list */
+	u32 cpdl[8];	/* currently presented display list */
+	u32 cadl[8];	/* currently active display list */
+	u32 nadl[8];	/* next active devices list */
+	u32 aslp;	/* ASL sleep time-out */
+	u32 tidx;	/* toggle table index */
+	u32 chpd;	/* current hotplug enable indicator */
+	u32 clid;	/* current lid state*/
+	u32 cdck;	/* current docking state */
+	u32 sxsw;	/* Sx state resume */
+	u32 evts;	/* ASL supported events */
+	u32 cnot;	/* current OS notification */
+	u32 nrdy;	/* driver status */
+	u8 rsvd2[60];
+} __packed;
+
+/* OpRegion mailbox #2: SWSCI */
+struct opregion_swsci {
+	/*FIXME: add it later*/
+} __packed;
+
+/* OpRegion mailbox #3: ASLE */
+struct opregion_asle {
+	u32 ardy;	/* driver readiness */
+	u32 aslc;	/* ASLE interrupt command */
+	u32 tche;	/* technology enabled indicator */
+	u32 alsi;	/* current ALS illuminance reading */
+	u32 bclp;	/* backlight brightness to set */
+	u32 pfit;	/* panel fitting state */
+	u32 cblv;	/* current brightness level */
+	u16 bclm[20];	/* backlight level duty cycle mapping table */
+	u32 cpfm;	/* current panel fitting mode */
+	u32 epfm;	/* enabled panel fitting modes */
+	u8 plut[74];	/* panel LUT and identifier */
+	u32 pfmb;	/* PWM freq and min brightness */
+	u8 rsvd[102];
+} __packed;
+
+/* ASLE irq request bits */
+#define ASLE_SET_ALS_ILLUM     (1 << 0)
+#define ASLE_SET_BACKLIGHT     (1 << 1)
+#define ASLE_SET_PFIT          (1 << 2)
+#define ASLE_SET_PWM_FREQ      (1 << 3)
+#define ASLE_REQ_MSK           0xf
+
+/* response bits of ASLE irq request */
+#define ASLE_ALS_ILLUM_FAILED   (1<<10)
+#define ASLE_BACKLIGHT_FAILED   (1<<12)
+#define ASLE_PFIT_FAILED        (1<<14)
+#define ASLE_PWM_FREQ_FAILED    (1<<16)
+
+/* ASLE backlight brightness to set */
+#define ASLE_BCLP_VALID                (1<<31)
+#define ASLE_BCLP_MSK          (~(1<<31))
+
+/* ASLE panel fitting request */
+#define ASLE_PFIT_VALID         (1<<31)
+#define ASLE_PFIT_CENTER (1<<0)
+#define ASLE_PFIT_STRETCH_TEXT (1<<1)
+#define ASLE_PFIT_STRETCH_GFX (1<<2)
+
+/* response bits of ASLE irq request */
+#define ASLE_ALS_ILLUM_FAILED	(1<<10)
+#define ASLE_BACKLIGHT_FAILED	(1<<12)
+#define ASLE_PFIT_FAILED	(1<<14)
+#define ASLE_PWM_FREQ_FAILED	(1<<16)
+
+/* ASLE backlight brightness to set */
+#define ASLE_BCLP_VALID                (1<<31)
+#define ASLE_BCLP_MSK          (~(1<<31))
+
+/* ASLE panel fitting request */
+#define ASLE_PFIT_VALID         (1<<31)
+#define ASLE_PFIT_CENTER (1<<0)
+#define ASLE_PFIT_STRETCH_TEXT (1<<1)
+#define ASLE_PFIT_STRETCH_GFX (1<<2)
+
+/* PWM frequency and minimum brightness */
+#define ASLE_PFMB_BRIGHTNESS_MASK (0xff)
+#define ASLE_PFMB_BRIGHTNESS_VALID (1<<8)
+#define ASLE_PFMB_PWM_MASK (0x7ffffe00)
+#define ASLE_PFMB_PWM_VALID (1<<31)
+
+#define ASLE_CBLV_VALID         (1<<31)
+
+static u32 asle_set_backlight(struct drm_device *dev, u32 bclp)
+{
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct opregion_asle *asle = dev_priv->opregion.asle;
+	struct backlight_device *bd = dev_priv->backlight_device;
+	u32 max;
+
+	DRM_DEBUG_DRIVER("asle set backlight %x\n", bclp);
+
+	if (!(bclp & ASLE_BCLP_VALID))
+		return ASLE_BACKLIGHT_FAILED;
+
+	if (bd == NULL)
+		return ASLE_BACKLIGHT_FAILED;
+
+	bclp &= ASLE_BCLP_MSK;
+	if (bclp > 255)
+		return ASLE_BACKLIGHT_FAILED;
+
+#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
+	max = bd->props.max_brightness;
+	bd->props.brightness = bclp * max / 255;
+	backlight_update_status(bd);
+#endif
+	asle->cblv = (bclp * 0x64) / 0xff | ASLE_CBLV_VALID;
+
+	return 0;
+}
+
+void psb_intel_opregion_asle_intr(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct opregion_asle *asle = dev_priv->opregion.asle;
+	u32 asle_stat = 0;
+	u32 asle_req;
+
+	if (!asle)
+		return;
+
+	asle_req = asle->aslc & ASLE_REQ_MSK;
+	if (!asle_req) {
+		DRM_DEBUG_DRIVER("non asle set request??\n");
+		return;
+	}
+
+	if (asle_req & ASLE_SET_BACKLIGHT)
+		asle_stat |= asle_set_backlight(dev, asle->bclp);
+
+	asle->aslc = asle_stat;
+}
+
+#define ASLE_ALS_EN    (1<<0)
+#define ASLE_BLC_EN    (1<<1)
+#define ASLE_PFIT_EN   (1<<2)
+#define ASLE_PFMB_EN   (1<<3)
+
+void psb_intel_opregion_enable_asle(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct opregion_asle *asle = dev_priv->opregion.asle;
+
+	if (asle) {
+		/* Don't do this on Medfield or other non PC like devices, they
+		   use the bit for something different altogether */
+		psb_enable_pipestat(dev_priv, 0, PIPE_LEGACY_BLC_EVENT_ENABLE);
+		psb_enable_pipestat(dev_priv, 1, PIPE_LEGACY_BLC_EVENT_ENABLE);
+
+		asle->tche = ASLE_ALS_EN | ASLE_BLC_EN | ASLE_PFIT_EN
+								| ASLE_PFMB_EN;
+		asle->ardy = 1;
+	}
+}
+
+#define ACPI_EV_DISPLAY_SWITCH (1<<0)
+#define ACPI_EV_LID            (1<<1)
+#define ACPI_EV_DOCK           (1<<2)
+
+static struct psb_intel_opregion *system_opregion;
+
+static int psb_intel_opregion_video_event(struct notifier_block *nb,
+					  unsigned long val, void *data)
+{
+	/* The only video events relevant to opregion are 0x80. These indicate
+	   either a docking event, lid switch or display switch request. In
+	   Linux, these are handled by the dock, button and video drivers.
+	   We might want to fix the video driver to be opregion-aware in
+	   future, but right now we just indicate to the firmware that the
+	   request has been handled */
+
+	struct opregion_acpi *acpi;
+
+	if (!system_opregion)
+		return NOTIFY_DONE;
+
+	acpi = system_opregion->acpi;
+	acpi->csts = 0;
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block psb_intel_opregion_notifier = {
+	.notifier_call = psb_intel_opregion_video_event,
+};
+
+void psb_intel_opregion_init(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct psb_intel_opregion *opregion = &dev_priv->opregion;
+
+	if (!opregion->header)
+		return;
+
+	if (opregion->acpi) {
+		/* Notify BIOS we are ready to handle ACPI video ext notifs.
+		 * Right now, all the events are handled by the ACPI video
+		 * module. We don't actually need to do anything with them. */
+		opregion->acpi->csts = 0;
+		opregion->acpi->drdy = 1;
+
+		system_opregion = opregion;
+		register_acpi_notifier(&psb_intel_opregion_notifier);
+	}
+
+	if (opregion->asle)
+		psb_intel_opregion_enable_asle(dev);
+}
+
+void psb_intel_opregion_fini(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct psb_intel_opregion *opregion = &dev_priv->opregion;
+
+	if (!opregion->header)
+		return;
+
+	if (opregion->acpi) {
+		opregion->acpi->drdy = 0;
+
+		system_opregion = NULL;
+		unregister_acpi_notifier(&psb_intel_opregion_notifier);
+	}
+
+	/* just clear all opregion memory pointers now */
+	iounmap(opregion->header);
+	opregion->header = NULL;
+	opregion->acpi = NULL;
+	opregion->swsci = NULL;
+	opregion->asle = NULL;
+	opregion->vbt = NULL;
+}
+
+int psb_intel_opregion_setup(struct drm_device *dev)
+{
+	struct drm_psb_private *dev_priv = dev->dev_private;
+	struct psb_intel_opregion *opregion = &dev_priv->opregion;
+	u32 opregion_phy, mboxes;
+	void *base;
+	int err = 0;
+
+	pci_read_config_dword(dev->pdev, PCI_ASLS, &opregion_phy);
+	if (opregion_phy == 0) {
+		DRM_DEBUG_DRIVER("ACPI Opregion not supported\n");
+		return -ENOTSUPP;
+	}
+	DRM_DEBUG("OpRegion detected at 0x%8x\n", opregion_phy);
+#ifdef CONFIG_ACPI
+	base = acpi_os_ioremap(opregion_phy, 8*1024);
+#else
+	base = ioremap(opregion_phy, 8*1024);
+#endif
+	if (!base)
+		return -ENOMEM;
+
+	if (memcmp(base, OPREGION_SIGNATURE, 16)) {
+		DRM_DEBUG_DRIVER("opregion signature mismatch\n");
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	opregion->header = base;
+	opregion->vbt = base + OPREGION_VBT_OFFSET;
+
+	opregion->lid_state = base + ACPI_CLID;
+
+	mboxes = opregion->header->mboxes;
+	if (mboxes & MBOX_ACPI) {
+		DRM_DEBUG_DRIVER("Public ACPI methods supported\n");
+		opregion->acpi = base + OPREGION_ACPI_OFFSET;
+	}
+
+	if (mboxes & MBOX_ASLE) {
+		DRM_DEBUG_DRIVER("ASLE supported\n");
+		opregion->asle = base + OPREGION_ASLE_OFFSET;
+	}
+
+	return 0;
+
+err_out:
+	iounmap(base);
+	return err;
+}
+
diff --git a/drivers/gpu/drm/gma500/psb_device.c b/drivers/gpu/drm/gma500/psb_device.c
index 34e6866..e95cddb 100644
--- a/drivers/gpu/drm/gma500/psb_device.c
+++ b/drivers/gpu/drm/gma500/psb_device.c
@@ -293,7 +293,7 @@ static int psb_chip_setup(struct drm_device *dev)
 {
 	psb_get_core_freq(dev);
 	gma_intel_setup_gmbus(dev);
-	gma_intel_opregion_init(dev);
+	psb_intel_opregion_init(dev);
 	psb_intel_init_bios(dev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 45bd0c7..fc6045f 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -215,12 +215,11 @@ static int psb_driver_unload(struct drm_device *dev)
 	/* Kill vblank etc here */
 
 	gma_backlight_exit(dev);
-
 	psb_modeset_cleanup(dev);
 
 	if (dev_priv) {
+		psb_intel_opregion_fini(dev);
 		psb_lid_timer_takedown(dev_priv);
-		gma_intel_opregion_exit(dev);
 
 		if (dev_priv->ops->chip_teardown)
 			dev_priv->ops->chip_teardown(dev);
@@ -310,6 +309,8 @@ static int psb_driver_load(struct drm_device *dev, unsigned long chipset)
 	if (!dev_priv->sgx_reg)
 		goto out_err;
 
+	psb_intel_opregion_setup(dev);
+
 	ret = dev_priv->ops->chip_setup(dev);
 	if (ret)
 		goto out_err;
@@ -349,8 +350,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long chipset)
 	PSB_WSGX32(0x20000000, PSB_CR_PDS_EXEC_BASE);
 	PSB_WSGX32(0x30000000, PSB_CR_BIF_3D_REQ_BASE);
 
-/*	igd_opregion_init(&dev_priv->opregion_dev); */
-/*	acpi_video_register(); */
+	acpi_video_register();
 	if (dev_priv->lid_state)
 		psb_lid_timer_init(dev_priv);
 
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index d3528a6..3773936 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -30,6 +30,7 @@
 #include "psb_intel_drv.h"
 #include "gtt.h"
 #include "power.h"
+#include "opregion.h"
 #include "oaktrail.h"
 
 /* Append new drm mode definition here, align with libdrm definition */
@@ -120,6 +121,7 @@ enum {
 #define PSB_HWSTAM		  0x2098
 #define PSB_INSTPM		  0x20C0
 #define PSB_INT_IDENTITY_R        0x20A4
+#define _PSB_IRQ_ASLE		  (1<<0)
 #define _MDFLD_PIPEC_EVENT_FLAG   (1<<2)
 #define _MDFLD_PIPEC_VBLANK_FLAG  (1<<3)
 #define _PSB_DPST_PIPEB_FLAG      (1<<4)
@@ -259,7 +261,7 @@ struct psb_intel_opregion {
 	struct opregion_swsci *swsci;
 	struct opregion_asle *asle;
 	void *vbt;
-	int enabled;
+	u32 __iomem *lid_state;
 };
 
 struct sdvo_device_mapping {
diff --git a/drivers/gpu/drm/gma500/psb_intel_reg.h b/drivers/gpu/drm/gma500/psb_intel_reg.h
index 519a9cd..8e8c8ef 100644
--- a/drivers/gpu/drm/gma500/psb_intel_reg.h
+++ b/drivers/gpu/drm/gma500/psb_intel_reg.h
@@ -507,6 +507,7 @@
 #define PIPE_VBLANK_INTERRUPT_ENABLE		(1UL << 17)
 #define PIPE_START_VBLANK_INTERRUPT_ENABLE	(1UL << 18)
 #define PIPE_TE_ENABLE				(1UL << 22)
+#define PIPE_LEGACY_BLC_EVENT_ENABLE		(1UL << 22)
 #define PIPE_DPST_EVENT_ENABLE			(1UL << 23)
 #define PIPE_VSYNC_ENABL			(1UL << 25)
 #define PIPE_HDMI_AUDIO_UNDERRUN		(1UL << 26)
diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index 2fcdffd..4ffb2a0 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -190,6 +190,9 @@ static void mid_pipe_event_handler(struct drm_device *dev, int pipe)
  */
 static void psb_vdc_interrupt(struct drm_device *dev, uint32_t vdc_stat)
 {
+	if (vdc_stat & _PSB_IRQ_ASLE)
+		psb_intel_opregion_asle_intr(dev);
+
 	if (vdc_stat & _PSB_VSYNC_PIPEA_FLAG)
 		mid_pipe_event_handler(dev, 0);
 
@@ -283,6 +286,7 @@ void psb_irq_preinstall(struct drm_device *dev)
 	/* Revisit this area - want per device masks ? */
 	if (dev_priv->ops->hotplug)
 		dev_priv->vdc_irq_mask |= _PSB_IRQ_DISP_HOTSYNC;
+	dev_priv->vdc_irq_mask |= _PSB_IRQ_ASLE;
 
 	/* This register is safe even if display island is off */
 	PSB_WVDC32(~dev_priv->vdc_irq_mask, PSB_INT_MASK_R);

