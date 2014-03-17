From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 3/4] acer-wmi: Stop selecting VIDEO_OUTPUT_CONTROL
Date: Mon, 17 Mar 2014 15:48:23 +0100
Message-ID: <20140317154823.1e822687@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41961 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933490AbaCQOs0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Mar 2014 10:48:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>

ACPI_VIDEO no longer depends on VIDEO_OUTPUT_CONTROL, so drivers which
want to select ACPI_VIDEO no longer have to select
VIDEO_OUTPUT_CONTROL.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>
---
 drivers/platform/x86/Kconfig |    2 --
 1 file changed, 2 deletions(-)

--- linux-3.14-rc7.orig/drivers/platform/x86/Kconfig	2014-03-17 14:23:31.511815259 +0100
+++ linux-3.14-rc7/drivers/platform/x86/Kconfig	2014-03-17 14:24:32.100155709 +0100
@@ -27,8 +27,6 @@ config ACER_WMI
 	depends on ACPI_WMI
 	select INPUT_SPARSEKMAP
 	# Acer WMI depends on ACPI_VIDEO when ACPI is enabled
-	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-        select VIDEO_OUTPUT_CONTROL if ACPI
         select ACPI_VIDEO if ACPI
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds


-- 
Jean Delvare
SUSE L3 Support
