From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/12] ACPI / PM: Move ACPI video resume to a PM notifier
Date: Tue, 06 Apr 2010 03:06:13 -0400
Message-ID: <c8cf3a14a6615e06504664cd50ca90baa5f2ef7d.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:60836 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757343Ab0DFHGc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 03:06:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0G008EQ12QS695@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 02:06:31 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Rafael Wysocki <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

=46rom: Rafael Wysocki <rjw@sisk.pl>

There is a problem with the ACPI video resume routine that it's
executed before the GPU that may be accessed by it.  To fix this
issue, move the ACPI video resume to a power management notifier,
so that it's executed after resuming all devices, including the GPU.

http://bugzilla.kernel.org/show_bug.cgi?id=3D15096

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Matthew Garrett <mjg@redhat.com>
Tested-by: Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/video.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 2ff2b6a..fc2a690 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -43,6 +43,7 @@
 #include <linux/dmi.h>
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
+#include <linux/suspend.h>
=20
 #define PREFIX "ACPI: "
=20
@@ -88,7 +89,6 @@ module_param(allow_duplicates, bool, 0644);
 static int register_count =3D 0;
 static int acpi_video_bus_add(struct acpi_device *device);
 static int acpi_video_bus_remove(struct acpi_device *device, int type)=
;
-static int acpi_video_resume(struct acpi_device *device);
 static void acpi_video_bus_notify(struct acpi_device *device, u32 even=
t);
=20
 static const struct acpi_device_id video_device_ids[] =3D {
@@ -104,7 +104,6 @@ static struct acpi_driver acpi_video_bus =3D {
 	.ops =3D {
 		.add =3D acpi_video_bus_add,
 		.remove =3D acpi_video_bus_remove,
-		.resume =3D acpi_video_resume,
 		.notify =3D acpi_video_bus_notify,
 		},
 };
@@ -159,6 +158,7 @@ struct acpi_video_bus {
 	struct proc_dir_entry *dir;
 	struct input_dev *input;
 	char phys[32];	/* for input device */
+	struct notifier_block pm_nb;
 };
=20
 struct acpi_video_device_flags {
@@ -2232,24 +2232,31 @@ static void acpi_video_device_notify(acpi_handl=
e handle, u32 event, void *data)
 	return;
 }
=20
-static int instance;
-static int acpi_video_resume(struct acpi_device *device)
+static int acpi_video_resume(struct notifier_block *nb,
+				unsigned long val, void *ign)
 {
 	struct acpi_video_bus *video;
 	struct acpi_video_device *video_device;
 	int i;
=20
-	if (!device || !acpi_driver_data(device))
-		return -EINVAL;
+	switch (val) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+	case PM_RESTORE_PREPARE:
+		return NOTIFY_DONE;
+	}
=20
-	video =3D acpi_driver_data(device);
+	video =3D container_of(nb, struct acpi_video_bus, pm_nb);
+
+	dev_info(&video->device->dev, "Restoring backlight state\n");
=20
 	for (i =3D 0; i < video->attached_count; i++) {
 		video_device =3D video->attached_array[i].bind_info;
 		if (video_device && video_device->backlight)
 			acpi_video_set_brightness(video_device->backlight);
 	}
-	return AE_OK;
+
+	return NOTIFY_OK;
 }
=20
 static acpi_status
@@ -2273,6 +2280,8 @@ acpi_video_bus_match(acpi_handle handle, u32 leve=
l, void *context,
 	return AE_OK;
 }
=20
+static int instance;
+
 static int acpi_video_bus_add(struct acpi_device *device)
 {
 	struct acpi_video_bus *video;
@@ -2366,6 +2375,10 @@ static int acpi_video_bus_add(struct acpi_device=
 *device)
 	       video->flags.rom ? "yes" : "no",
 	       video->flags.post ? "yes" : "no");
=20
+	video->pm_nb.notifier_call =3D acpi_video_resume;
+	video->pm_nb.priority =3D 0;
+	register_pm_notifier(&video->pm_nb);
+
 	return 0;
=20
  err_free_input_dev:
@@ -2392,6 +2405,8 @@ static int acpi_video_bus_remove(struct acpi_devi=
ce *device, int type)
=20
 	video =3D acpi_driver_data(device);
=20
+	unregister_pm_notifier(&video->pm_nb);
+
 	acpi_video_bus_stop_devices(video);
 	acpi_video_bus_put_devices(video);
 	acpi_video_bus_remove_fs(device);
--=20
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
