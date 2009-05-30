From: Len Brown <lenb@kernel.org>
Subject: Re: [i915] Kernel does not compile when set to use i915 kernel
 mode-setting per default (CONFIG_DRM_I915_KMS=y)
Date: Fri, 29 May 2009 21:13:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905292113150.4293@localhost.localdomain>
References: <fcd863fc0905181109h372e5967t9d179b820a62132d@mail.gmail.com>
 <4A1464C9.9030603@xandros.com> <4A1475D5.6080602@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:40279 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280AbZE3BOI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:14:08 -0400
In-reply-to: <4A1475D5.6080602@oracle.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Woody Suwalski <woodys@xandros.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Zorael <zorael@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

From: Len Brown <len.brown@intel.com>
Subject: [PATCH] ACPI, i915: build fix (v2)

drivers/built-in.o: In function `intel_opregion_init':
(.text+0x9d540): undefined reference to `acpi_video_register'

v2: move under DRM_I915 from DRM_I915_KMS

Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
as applied.
thanks,
-Len

 drivers/gpu/drm/Kconfig |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 4cd35d8..f5d46e7 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -67,12 +67,18 @@ config DRM_I830
 	  will load the correct one.
 
 config DRM_I915
+	tristate "i915 driver"
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select FB
 	select FRAMEBUFFER_CONSOLE if !EMBEDDED
-	tristate "i915 driver"
+	# i915 depends on ACPI_VIDEO when ACPI is enabled
+	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
+	select VIDEO_OUTPUT_CONTROL if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select INPUT if ACPI
+	select ACPI_VIDEO if ACPI
 	help
 	  Choose this option if you have a system that has Intel 830M, 845G,
 	  852GM, 855GM 865G or 915G integrated graphics.  If M is selected, the
@@ -84,12 +90,6 @@ config DRM_I915
 config DRM_I915_KMS
 	bool "Enable modesetting on intel by default"
 	depends on DRM_I915
-	# i915 KMS depends on ACPI_VIDEO when ACPI is enabled
-	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select VIDEO_OUTPUT_CONTROL if ACPI
-	select BACKLIGHT_CLASS_DEVICE if ACPI
-	select INPUT if ACPI
-	select ACPI_VIDEO if ACPI
 	help
 	  Choose this option if you want kernel modesetting enabled by default,
 	  and you have a new enough userspace to support this. Running old
-- 
1.6.3.1.175.g3be7e


