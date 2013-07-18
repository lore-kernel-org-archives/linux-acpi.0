From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] ACPI / video: Always call acpi_video_init_brightness() on init
Date: Thu, 18 Jul 2013 02:21:03 +0200
Message-ID: <2754766.4uAbGBBbb8@vostro.rjw.lan>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com> <1448863.3slS729B6b@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448863.3slS729B6b@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <matthew.garrett@nebula.com>, seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org, Aaron Lu <aaron.lu@intel.com>, Igor Gnatenko <i.gnatenko.brain@gmail.com>, Yves-Alexis Perez <corsac@debian.org>, Felipe Contreras <felipe.contreras@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-acpi@vger.kernel.org

From: Matthew Garrett <matthew.garrett@nebula.com>

We have to call acpi_video_init_brightness() even if we're not going
to initialise the backlight - Thinkpads seem to use this as the
trigger for enabling ACPI notifications rather than handling it in
firmware.

[rjw: Drop the brightness object created by
 acpi_video_init_brightness() if we are not going to use it.]
Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/video.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/acpi/video.c
===================================================================
--- linux-pm.orig/drivers/acpi/video.c
+++ linux-pm/drivers/acpi/video.c
@@ -884,6 +884,9 @@ static void acpi_video_device_find_cap(s
 	if (acpi_has_method(device->dev->handle, "_DDC"))
 		device->cap._DDC = 1;
 
+	if (acpi_video_init_brightness(device))
+		return;
+
 	if (acpi_video_backlight_support()) {
 		struct backlight_properties props;
 		struct pci_dev *pdev;
@@ -893,9 +896,6 @@ static void acpi_video_device_find_cap(s
 		static int count = 0;
 		char *name;
 
-		result = acpi_video_init_brightness(device);
-		if (result)
-			return;
 		name = kasprintf(GFP_KERNEL, "acpi_video%d", count);
 		if (!name)
 			return;
@@ -955,6 +955,11 @@ static void acpi_video_device_find_cap(s
 		if (result)
 			printk(KERN_ERR PREFIX "Create sysfs link\n");
 
+	} else {
+		/* Remove the brightness object. */
+		kfree(device->brightness->levels);
+		kfree(device->brightness);
+		device->brightness = NULL;
 	}
 }
 
