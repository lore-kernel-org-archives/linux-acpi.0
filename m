From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: [PATCH 3/3] i915: Don't provide ACPI backlight interface if firmware expects Windows 8
Date: Sun,  9 Jun 2013 19:01:39 -0400
Message-ID: <1370818899-8595-4-git-send-email-matthew.garrett@nebula.com>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, rjw@sisk.pl, Matthew Garrett <matthew.garrett@nebula.com>
List-Id: linux-acpi@vger.kernel.org

Windows 8 leaves backlight control up to individual graphics drivers rather
than making ACPI calls itself. There's plenty of evidence to suggest that
the Intel driver for Windows doesn't use the ACPI interface, including the
fact that it's broken on a bunch of machines when the OS claims to support
Windows 8. The simplest thing to do appears to be to disable the ACPI
backlight interface on these systems.

Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
---
 drivers/gpu/drm/i915/i915_dma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
index 3b315ba..23b6292 100644
--- a/drivers/gpu/drm/i915/i915_dma.c
+++ b/drivers/gpu/drm/i915/i915_dma.c
@@ -1661,6 +1661,9 @@ int i915_driver_load(struct drm_device *dev, unsigned long flags)
 		/* Must be done after probing outputs */
 		intel_opregion_init(dev);
 		acpi_video_register();
+		/* Don't use ACPI backlight functions on Windows 8 platforms */
+		if (acpi_osi_version() >= ACPI_OSI_WIN_8)
+			acpi_video_backlight_unregister();
 	}
 
 	if (IS_GEN5(dev))
-- 
1.8.2.1
