From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.30-rc3 video/i915 build error
Date: Fri, 24 Apr 2009 11:49:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904241145220.10096@localhost.localdomain>
References: <alpine.LFD.2.00.0904231231100.15830@localhost.localdomain>
 <20090423164642.GF495@gamma.logic.tuwien.ac.at>
 <alpine.LFD.2.00.0904231550020.15830@localhost.localdomain>
 <1240535458.3651.63.camel@localhost.localdomain>
 <alpine.LFD.2.00.0904232156040.15843@localhost.localdomain>
 <1240544791.3651.82.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:65139 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbZDXPtk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 11:49:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIM009LM3YI7KUH@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 24 Apr 2009 10:49:31 -0500 (CDT)
In-reply-to: <1240544791.3651.82.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: yakui_zhao <yakui.zhao@intel.com>
Cc: Norbert Preining <preining@logic.at>, Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, "Zhang, Rui" <rui.zhang@intel.com>, Keith Packard <keithp@keithp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

From: Len Brown <len.brown@intel.com>
Subject: [PATCH] ACPI, i915: build fix

drivers/built-in.o: In function `intel_opregion_init':
(.text+0x9d540): undefined reference to `acpi_video_register'

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
1.6.3.rc1.51.gea0b7

