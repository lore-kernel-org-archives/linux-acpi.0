From: Len Brown <lenb@kernel.org>
Subject: [PATCH 18/20] ACPI video: make procfs I/F depend on CONFIG_ACPI_PROCFS
Date: Sun, 15 Aug 2010 01:23:22 -0400
Message-ID: <6e37c658aefa57c472b2dbf1de88dbd3c67cdb52.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:57585 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421Ab0HOFaK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:30:10 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600HN2HY5RHB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:30:10 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Mark ACPI video driver procfs I/F deprecated, including:
/proc/acpi/video/*/info
/proc/acpi/video/*/DOS
/proc/acpi/video/*/ROM
/proc/acpi/video/*/POST
/proc/acpi/video/*/POST_info
/proc/acpi/video/*/*/info
/proc/acpi/video/*/*/state
/proc/acpi/video/*/*/EDID
and
/proc/acpi/video/*/*/brightness, because
1. we already have the sysfs I/F /sysclass/backlight/ as the replacement
of /proc/acpi/video/*/*/brightness.
2. the other procfs I/F is not useful for userspace.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    1 +
 drivers/acpi/video.c |  131 +++++++++++++++++++++++++++++++-------------------
 2 files changed, 82 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 6f66a93..354e613 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -56,6 +56,7 @@ config ACPI_PROCFS
 
 	  /proc/acpi/processor/*/throttling (/sys/class/thermal/
 		cooling_device*/*)
+	  /proc/acpi/video/*/brightness (/sys/class/backlight/)
 	  This option has no effect on /proc/acpi/ files
 	  and functions which do not yet exist in /sys.
 
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 9865d46..909ae7b 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
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
@@ -307,6 +310,7 @@ static const struct file_operations acpi_video_device_EDID_fops = {
 	.llseek = seq_lseek,
 	.release = single_release,
 };
+#endif /* CONFIG_ACPI_PROCFS */
 
 static const char device_decode[][30] = {
 	"motherboard VGA device",
@@ -450,16 +454,6 @@ static struct thermal_cooling_device_ops video_cooling_ops = {
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
@@ -698,46 +692,6 @@ acpi_video_device_EDID(struct acpi_video_device *device,
 
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
@@ -1159,6 +1113,7 @@ static int acpi_video_bus_check(struct acpi_video_bus *video)
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
+#ifdef CONFIG_ACPI_PROCFS
 
 static struct proc_dir_entry *acpi_video_dir;
 
@@ -1198,6 +1153,18 @@ acpi_video_device_info_open_fs(struct inode *inode, struct file *file)
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
@@ -1492,6 +1459,19 @@ static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file *file)
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
@@ -1530,6 +1510,16 @@ acpi_video_bus_POST_info_open_fs(struct inode *inode, struct file *file)
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
@@ -1572,6 +1562,25 @@ static int acpi_video_bus_DOS_open_fs(struct inode *inode, struct file *file)
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
@@ -1722,6 +1731,24 @@ static int acpi_video_bus_remove_fs(struct acpi_device *device)
 
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
 
-- 
1.7.2.1.95.g3d045

