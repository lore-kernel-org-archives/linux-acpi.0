From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 1/2] acpi/video: Load the module even if ACPI is disabled
Date: Sun,  1 Mar 2015 10:41:37 +0000
Message-ID: <1425206498-1615-1-git-send-email-chris@chris-wilson.co.uk>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jani Nikula <jani.nikula@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

i915.ko depends upon the acpi/video.ko module and so refuses to load if
ACPI is disabled at runtime if for example the BIOS is broken beyond
repair. acpi/video provides an optional service for i915.ko and so we
should just allow the modules to load, but do no nothing in order to let
the machines boot correctly.

Reported-by: Bill Augur <bill-auger@programmer.net>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---
 drivers/acpi/video.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index debd30917010..3b76aef79a1c 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -2176,6 +2176,16 @@ EXPORT_SYMBOL(acpi_video_unregister_backlight);
 
 static int __init acpi_video_init(void)
 {
+	/* Let the module load even if ACPI is disabled (e.g. due to
+	 * a broken BIOS) so that i915.ko can still be loaded on such
+	 * old systems without an AcpiOpRegion.
+	 *
+	 * acpi_video_register() will report -ENODEV later as well due
+	 * to acpi_disabled when i915.ko tries to register itself afterwards.
+	 */
+	if (acpi_disabled)
+		return 0;
+
 	dmi_check_system(video_dmi_table);
 
 	if (intel_opregion_present())
-- 
2.1.4
