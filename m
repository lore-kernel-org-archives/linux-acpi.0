From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH] i915: enable MCHBAR if needed
Date: Tue, 14 Apr 2009 12:48:00 -0700
Message-ID: <20090414124800.6852821c@hobbes>
References: <20090414124618.0dd9f536@hobbes>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-304.bluehost.com ([67.222.53.250]:48713 "HELO
	outbound-mail-304.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754338AbZDNTyn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Apr 2009 15:54:43 -0400
In-Reply-To: <20090414124618.0dd9f536@hobbes>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, intel-gfx@lists.freedesktop.org

Using the new PNP resource checking code, this patch allows the i915
driver to allocate MCHBAR space if needed and use the BAR to determine
current memory settings.

Testing & feedback welcome.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index e9de2c2..d34fad9 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -143,6 +143,8 @@ typedef struct drm_i915_private {
 	drm_local_map_t hws_map;
 	struct drm_gem_object *hws_obj;
 
+	struct resource mch_res;
+
 	unsigned int cpp;
 	int back_offset;
 	int front_offset;
diff --git a/drivers/gpu/drm/i915/i915_gem_tiling.c b/drivers/gpu/drm/i915/i915_gem_tiling.c
index 6be3f92..a8d2d67 100644
--- a/drivers/gpu/drm/i915/i915_gem_tiling.c
+++ b/drivers/gpu/drm/i915/i915_gem_tiling.c
@@ -24,6 +24,8 @@
  *    Eric Anholt <eric@anholt.net>
  *
  */
+#include <linux/acpi.h>
+#include <linux/pnp.h>
 
 #include "drmP.h"
 #include "drm.h"
@@ -79,6 +81,143 @@
  * to match what the GPU expects.
  */
 
+#define MCHBAR_I915 0x44
+#define MCHBAR_I965 0x48
+#define MCHBAR_SIZE (4*4096)
+
+#define DEVEN_REG 0x54
+#define   DEVEN_MCHBAR_EN (1 << 28)
+
+/* Allocate space for the MCH regs if needed, return nonzero on error */
+static int
+intel_alloc_mchbar_resource(struct drm_device *dev)
+{
+	struct pci_dev *bridge_dev;
+	drm_i915_private_t *dev_priv = dev->dev_private;
+	int reg = IS_I965G(dev) ? MCHBAR_I965 : MCHBAR_I915;
+	u32 temp_lo, temp_hi = 0;
+	u64 mchbar_addr;
+	int ret = 0;
+
+	bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
+	if (!bridge_dev) {
+		DRM_DEBUG("no bridge dev?!\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (IS_I965G(dev))
+		pci_read_config_dword(bridge_dev, reg + 4, &temp_hi);
+	pci_read_config_dword(bridge_dev, reg, &temp_lo);
+	mchbar_addr = ((u64)temp_hi << 32) | temp_lo;
+
+	/* If ACPI doesn't have it, assume we need to allocate it ourselves */
+	if (mchbar_addr &&
+	    is_acpi_pnp_reserved(mchbar_addr, mchbar_addr + MCHBAR_SIZE)) {
+		ret = 0;
+		goto out_put;
+	}
+
+	/* Get some space for it */
+	ret = pci_bus_alloc_resource(bridge_dev->bus, &dev_priv->mch_res,
+				     MCHBAR_SIZE, MCHBAR_SIZE,
+				     PCIBIOS_MIN_MEM,
+				     0,   pcibios_align_resource,
+				     bridge_dev);
+	if (ret) {
+		DRM_DEBUG("failed bus alloc: %d\n", ret);
+		dev_priv->mch_res.start = 0;
+		goto out_put;
+	}
+
+	if (IS_I965G(dev))
+		pci_write_config_dword(bridge_dev, reg + 4,
+				       upper_32_bits(dev_priv->mch_res.start));
+
+	pci_write_config_dword(bridge_dev, reg,
+			       lower_32_bits(dev_priv->mch_res.start));
+out_put:
+	pci_dev_put(bridge_dev);
+out:
+	return ret;
+}
+
+/* Setup MCHBAR if possible, return true if we should disable it again */
+static bool
+intel_setup_mchbar(struct drm_device *dev)
+{
+	struct pci_dev *bridge_dev;
+	int mchbar_reg = IS_I965G(dev) ? MCHBAR_I965 : MCHBAR_I915;
+	u32 temp;
+	bool need_disable = false, enabled;
+
+	bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
+	if (!bridge_dev) {
+		DRM_DEBUG("no bridge dev?!\n");
+		goto out;
+	}
+
+	if (IS_I915G(dev) || IS_I915GM(dev)) {
+		pci_read_config_dword(bridge_dev, DEVEN_REG, &temp);
+		enabled = !!(temp & DEVEN_MCHBAR_EN);
+	} else {
+		pci_read_config_dword(bridge_dev, mchbar_reg, &temp);
+		enabled = temp & 1;
+	}
+
+	/* If it's already enabled, don't have to do anything */
+	if (enabled)
+		goto out_put;
+
+	if (intel_alloc_mchbar_resource(dev))
+		goto out_put;
+
+	need_disable = true;
+
+	/* Space is allocated or reserved, so enable it. */
+	if (IS_I915G(dev) || IS_I915GM(dev)) {
+		pci_write_config_dword(bridge_dev, DEVEN_REG,
+				       temp | DEVEN_MCHBAR_EN);
+	} else {
+		pci_read_config_dword(bridge_dev, mchbar_reg, &temp);
+		pci_write_config_dword(bridge_dev, mchbar_reg, temp | 1);
+	}
+out_put:
+	pci_dev_put(bridge_dev);
+out:
+	return need_disable;
+}
+
+static void
+intel_teardown_mchbar(struct drm_device *dev, bool disable)
+{
+	drm_i915_private_t *dev_priv = dev->dev_private;
+	struct pci_dev *bridge_dev;
+	int mchbar_reg = IS_I965G(dev) ? MCHBAR_I965 : MCHBAR_I915;
+	u32 temp;
+
+	bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0,0));
+	if (!bridge_dev) {
+		DRM_DEBUG("no bridge dev?!\n");
+		return;
+	}
+
+	if (disable) {
+		if (IS_I915G(dev) || IS_I915GM(dev)) {
+			pci_read_config_dword(bridge_dev, DEVEN_REG, &temp);
+			temp &= ~DEVEN_MCHBAR_EN;
+			pci_write_config_dword(bridge_dev, DEVEN_REG, temp);
+		} else {
+			pci_read_config_dword(bridge_dev, mchbar_reg, &temp);
+			temp &= ~1;
+			pci_write_config_dword(bridge_dev, mchbar_reg, temp);
+		}
+	}
+
+	if (dev_priv->mch_res.start)
+		release_resource(&dev_priv->mch_res);
+}
+
 /**
  * Detects bit 6 swizzling of address lookup between IGD access and CPU
  * access through main memory.
@@ -89,6 +228,7 @@ i915_gem_detect_bit_6_swizzle(struct drm_device *dev)
 	drm_i915_private_t *dev_priv = dev->dev_private;
 	uint32_t swizzle_x = I915_BIT_6_SWIZZLE_UNKNOWN;
 	uint32_t swizzle_y = I915_BIT_6_SWIZZLE_UNKNOWN;
+	bool need_disable;
 
 	if (!IS_I9XX(dev)) {
 		/* As far as we know, the 865 doesn't have these bit 6
@@ -99,6 +239,9 @@ i915_gem_detect_bit_6_swizzle(struct drm_device *dev)
 	} else if (IS_MOBILE(dev)) {
 		uint32_t dcc;
 
+		/* Try to make sure MCHBAR is enabled before poking at it */
+		need_disable = intel_setup_mchbar(dev);
+
 		/* On mobile 9xx chipsets, channel interleave by the CPU is
 		 * determined by DCC.  For single-channel, neither the CPU
 		 * nor the GPU do swizzling.  For dual channel interleaved,
@@ -138,6 +281,8 @@ i915_gem_detect_bit_6_swizzle(struct drm_device *dev)
 			swizzle_x = I915_BIT_6_SWIZZLE_UNKNOWN;
 			swizzle_y = I915_BIT_6_SWIZZLE_UNKNOWN;
 		}
+
+		intel_teardown_mchbar(dev, need_disable);
 	} else {
 		/* The 965, G33, and newer, have a very flexible memory
 		 * configuration.  It will enable dual-channel mode
