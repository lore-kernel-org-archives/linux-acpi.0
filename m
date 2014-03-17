From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH 1/4] ACPI: fix ACPI_VIDEO dependencies
Date: Mon, 17 Mar 2014 15:46:44 +0100
Message-ID: <20140317154644.15065deb@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Jani Nikula <jani.nikula@linux.intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <matthew.garrett@nebula.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>
Subject: ACPI: fix ACPI_VIDEO dependencies

ACPI_VIDEO stopped depending on VIDEO_OUTPUT_CONTROL over 3 years ago
(see commit 677bd810, "ACPI video: remove output switching control".)
So it's about time to remove the Kconfig dependency between these two
options.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
It would be great if this patch could go upstream quickly, as
system-wide cleanups depend on it.

 drivers/acpi/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc7.orig/drivers/acpi/Kconfig	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc7/drivers/acpi/Kconfig	2014-03-17 14:13:33.312716554 +0100
@@ -115,7 +115,7 @@ config ACPI_BUTTON
 
 config ACPI_VIDEO
 	tristate "Video"
-	depends on X86 && BACKLIGHT_CLASS_DEVICE && VIDEO_OUTPUT_CONTROL
+	depends on X86 && BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
 	select THERMAL
 	help


-- 
Jean Delvare
SUSE L3 Support
