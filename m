From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 8/9] ACPI video: make procfs I/F depend on
 CONFIG_ACPI_PROCFS
Date: Thu, 15 Jul 2010 10:46:43 +0800
Message-ID: <1279162003.4537.8521.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52370 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128Ab0GOCot (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Jul 2010 22:44:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>


Make ACPI video driver procfs I/F depend on CONFIG_ACPI_PROCFS.

For backlight control, users should use /sys/class/backlight/ instead.
The other procfs I/F should not be used by any users, so that we can
remove them safely.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/Kconfig |    1 
 drivers/acpi/video.c |  131 +++++++++++++++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 50 deletions(-)

Index: linux-2.6/drivers/acpi/video.c
===================================================================
--- linux-2.6.orig/drivers/acpi/video.c
+++ linux-2.6/drivers/acpi/video.c
@@ -152,7 +152,9 @@ struct acpi_video_bus {
 	struct acpi_video_bus_flags flags;
 	struct list_head video_device_list;
 	struct mutex device_list_lock;	/* protects video_device_list */
+#ifdef CONFIG_ACPI_PROCFS
 	struct proc_dir_entry *dir;
+#endif
 	struct input_dev *input;
 	char phys[32];	/* for input device */
 	struct notifier_block pm_nb;
@@ -208,6 +210,7 @@ struct acpi_video_device {
 	struct output_device *output_dev;
 };
 
+#ifdef CONFIG_ACPI_PROCFS
 /* bus */
 static int acpi_video_bus_info_open_fs(struct inode *inode, struct file *file);
 static const struct file_operations acpi_video_bus_info_fops = {
@@ -307,6 +310,7 @@ static const struct file_operations acpi
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif /* CONFIG_ACPI_PROCFS */
 
 static const char device_decode[][30] = {
 	"motherboard VGA device",
@@ -450,16 +454,6 @@ static struct thermal_cooling_device_ops
 /* device */
 
 static int
-acpi_video_device_query(struct acpi_video_device *device, unsigned long long *state)
-{
-	int status;
-
-	status = acpi_evaluate_integer(device->dev->handle, "_DGS", NULL, state);
-
-	return status;
-}
-
-static int
 acpi_video_device_get_state(struct acpi_video_device *device,
 			    unsigned long long *state)
 {
@@ -698,46 +692,6 @@ acpi_video_device_EDID(struct acpi_video
 
 /* bus */
 
-static int
-acpi_video_bus_set_POST(struct acpi_video_bus *video, unsigned long option)
-{
-	int status;
-	unsigned long long tmp;
-	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list args = { 1, &arg0 };
-
-
-	arg0.integer.value = option;
-
-	status = acpi_evaluate_integer(video->device->handle, "_SPD", &args, &tmp);
-	if (ACPI_SUCCESS(status))
-		status = tmp ? (-EINVAL) : (AE_OK);
-
-	return status;
-}
-
-static int
-acpi_video_bus_get_POST(struct acpi_video_bus *video, unsigned long long *id)
-{
-	int status;
-
-	status = acpi_evaluate_integer(video->device->handle, "_GPD", NULL, id);
-
-	return status;
-}
-
-static int
-acpi_video_bus_POST_options(struct acpi_video_bus *video,
-			    unsigned long long *options)
-{
-	int status;
-
-	status = acpi_evaluate_integer(video->device->handle, "_VPO", NULL, options);
-	*options &= 3;
-
-	return status;
-}
-
 /*
  *  Arg:
  *  	video		: video bus device pointer
@@ -1159,6 +1113,7 @@ static int acpi_video_bus_check(struct a
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static struct proc_dir_entry *acpi_video_dir;
 
@@ -1198,6 +1153,18 @@ acpi_video_device_info_open_fs(struct in
 			   PDE(inode)->data);
 }
 
+static int
+acpi_video_device_query(struct acpi_video_device *device,
+			unsigned long long *state)
+{
+	int status;
+
+	status = acpi_evaluate_integer(device->dev->handle, "_DGS",
+				       NULL, state);
+
+	return status;
+}
+
 static int acpi_video_device_state_seq_show(struct seq_file *seq, void *offset)
 {
 	int status;
@@ -1492,6 +1459,19 @@ static int acpi_video_bus_ROM_open_fs(st
 	return single_open(file, acpi_video_bus_ROM_seq_show, PDE(inode)->data);
 }
 
+static int
+acpi_video_bus_POST_options(struct acpi_video_bus *video,
+			    unsigned long long *options)
+{
+	int status;
+
+	status = acpi_evaluate_integer(video->device->handle, "_VPO",
+				       NULL, options);
+	*options &= 3;
+
+	return status;
+}
+
 static int acpi_video_bus_POST_info_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_video_bus *video = seq->private;
@@ -1530,6 +1510,16 @@ acpi_video_bus_POST_info_open_fs(struct 
 			   PDE(inode)->data);
 }
 
+static int
+acpi_video_bus_get_POST(struct acpi_video_bus *video, unsigned long long *id)
+{
+	int status;
+
+	status = acpi_evaluate_integer(video->device->handle, "_GPD", NULL, id);
+
+	return status;
+}
+
 static int acpi_video_bus_POST_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_video_bus *video = seq->private;
@@ -1572,6 +1562,25 @@ static int acpi_video_bus_DOS_open_fs(st
 	return single_open(file, acpi_video_bus_DOS_seq_show, PDE(inode)->data);
 }
 
+static int
+acpi_video_bus_set_POST(struct acpi_video_bus *video, unsigned long option)
+{
+	int status;
+	unsigned long long tmp;
+	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
+	struct acpi_object_list args = { 1, &arg0 };
+
+
+	arg0.integer.value = option;
+
+	status = acpi_evaluate_integer(video->device->handle, "_SPD",
+				       &args, &tmp);
+	if (ACPI_SUCCESS(status))
+		status = tmp ? (-EINVAL) : (AE_OK);
+
+	return status;
+}
+
 static ssize_t
 acpi_video_bus_write_POST(struct file *file,
 			  const char __user * buffer,
@@ -1722,6 +1731,24 @@ static int acpi_video_bus_remove_fs(stru
 
 	return 0;
 }
+#else
+static inline int acpi_video_device_add_fs(struct acpi_device *device)
+{
+	return 0;
+}
+static inline int acpi_video_device_remove_fs(struct acpi_device *device)
+{
+	return 0;
+}
+static inline int acpi_video_bus_add_fs(struct acpi_device *device)
+{
+	return 0;
+}
+static inline int acpi_video_bus_remove_fs(struct acpi_device *device)
+{
+	return 0;
+}
+#endif /* CONFIG_ACPI_PROCFS */
 
 /* --------------------------------------------------------------------------
                                  Driver Interface
@@ -2557,9 +2584,11 @@ int acpi_video_register(void)
 		return 0;
 	}
 
+#ifdef CONFIG_ACPI_PROCFS
 	acpi_video_dir = proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
 	if (!acpi_video_dir)
 		return -ENODEV;
+#endif
 
 	result = acpi_bus_register_driver(&acpi_video_bus);
 	if (result < 0) {
@@ -2588,7 +2617,9 @@ void acpi_video_unregister(void)
 	}
 	acpi_bus_unregister_driver(&acpi_video_bus);
 
+#ifdef CONFIG_ACPI_PROCFS
 	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+#endif
 
 	register_count = 0;
 
Index: linux-2.6/drivers/acpi/Kconfig
===================================================================
--- linux-2.6.orig/drivers/acpi/Kconfig
+++ linux-2.6/drivers/acpi/Kconfig
@@ -56,6 +56,7 @@ config ACPI_PROCFS
 
 	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
 		cooling_device*/*)
+	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 


