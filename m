From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/19] ACPI, i915: build fix
Date: Sat, 16 May 2009 02:02:12 -0400
Message-ID: <ecb4aed78dcf09e48c8c34c8c2fa7f5c69344be6.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:57099 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbZEPGC1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ00GDI3G28U6Q@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:27 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

drivers/built-in.o: In function `intel_opregion_init':
(.text+0x9d540): undefined reference to `acpi_video_register'

http://bugzilla.kernel.org/show_bug.cgi?id=13165

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/gpu/drm/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 3a22eb9..f33d252 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -83,6 +83,12 @@ config DRM_I915
 config DRM_I915_KMS
 	bool "Enable modesetting on intel by default"
 	depends on DRM_I915
+	# i915 KMS depends on ACPI_VIDEO when ACPI is enabled
+	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
+	select VIDEO_OUTPUT_CONTROL if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select INPUT if ACPI
+	select ACPI_VIDEO if ACPI
 	help
 	  Choose this option if you want kernel modesetting enabled by default,
 	  and you have a new enough userspace to support this. Running old
-- 
1.6.0.6

