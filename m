From: Jan Engelhardt <jengelh@medozas.de>
Subject: acpi: constify VFTs (1/2)
Date: Mon, 12 Jan 2009 00:07:55 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901120007250.20643@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:52679 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200AbZAKXH5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Jan 2009 18:07:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

parent 1b4a88617720bf38c46614bf9308ccbb150979bb (v2.6.29-rc1-9-g1b4a886)
commit a0fab196edee967a0ad7369c4dce37f162ce8369
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Jan 12 00:00:22 2009 +0100

acpi: constify VFTs (1/2)

Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 drivers/acpi/battery.c              |    2 +-
 drivers/acpi/ec.c                   |    2 +-
 drivers/acpi/processor_perflib.c    |    2 +-
 drivers/acpi/processor_thermal.c    |    2 +-
 drivers/acpi/processor_throttling.c |    2 +-
 drivers/acpi/sbs.c                  |   14 +++++++-------
 drivers/acpi/video.c                |   10 +++++-----
 include/acpi/processor.h            |    4 ++--
 8 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 65132f9..355dc40 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -717,7 +717,7 @@ DECLARE_FILE_FUNCTIONS(alarm);
 static struct battery_file {
 	struct file_operations ops;
 	mode_t mode;
-	char *name;
+	const char *name;
 } acpi_battery_file[] = {
 	FILE_DESCRIPTION_RO(info),
 	FILE_DESCRIPTION_RO(state),
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 8dfcbb8..4886a42 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -693,7 +693,7 @@ static int acpi_ec_info_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_ec_read_info, PDE(inode)->data);
 }
 
-static struct file_operations acpi_ec_info_ops = {
+static const struct file_operations acpi_ec_info_ops = {
 	.open = acpi_ec_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 846e227..52464c6 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -438,7 +438,7 @@ EXPORT_SYMBOL(acpi_processor_notify_smm);
 /* /proc/acpi/processor/../performance interface (DEPRECATED) */
 
 static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_processor_perf_fops = {
+static const struct file_operations acpi_processor_perf_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_processor_perf_open_fs,
 	.read = seq_read,
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index b1eb376..1f31699 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -507,7 +507,7 @@ static ssize_t acpi_processor_write_limit(struct file * file,
 	return count;
 }
 
-struct file_operations acpi_processor_limit_fops = {
+const struct file_operations acpi_processor_limit_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_processor_limit_open_fs,
 	.read = seq_read,
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d278381..73aed5f 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -1291,7 +1291,7 @@ static ssize_t acpi_processor_write_throttling(struct file *file,
 	return count;
 }
 
-struct file_operations acpi_processor_throttling_fops = {
+const struct file_operations acpi_processor_throttling_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_processor_throttling_open_fs,
 	.read = seq_read,
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 6050ce4..1e3cf98 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -479,9 +479,9 @@ static int
 acpi_sbs_add_fs(struct proc_dir_entry **dir,
 		struct proc_dir_entry *parent_dir,
 		char *dir_name,
-		struct file_operations *info_fops,
-		struct file_operations *state_fops,
-		struct file_operations *alarm_fops, void *data)
+		const struct file_operations *info_fops,
+		const struct file_operations *state_fops,
+		const struct file_operations *alarm_fops, void *data)
 {
 	if (!*dir) {
 		*dir = proc_mkdir(dir_name, parent_dir);
@@ -677,7 +677,7 @@ static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_battery_read_alarm, PDE(inode)->data);
 }
 
-static struct file_operations acpi_battery_info_fops = {
+static const struct file_operations acpi_battery_info_fops = {
 	.open = acpi_battery_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -685,7 +685,7 @@ static struct file_operations acpi_battery_info_fops = {
 	.owner = THIS_MODULE,
 };
 
-static struct file_operations acpi_battery_state_fops = {
+static const struct file_operations acpi_battery_state_fops = {
 	.open = acpi_battery_state_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -693,7 +693,7 @@ static struct file_operations acpi_battery_state_fops = {
 	.owner = THIS_MODULE,
 };
 
-static struct file_operations acpi_battery_alarm_fops = {
+static const struct file_operations acpi_battery_alarm_fops = {
 	.open = acpi_battery_alarm_open_fs,
 	.read = seq_read,
 	.write = acpi_battery_write_alarm,
@@ -725,7 +725,7 @@ static int acpi_ac_state_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_ac_read_state, PDE(inode)->data);
 }
 
-static struct file_operations acpi_ac_state_fops = {
+static const struct file_operations acpi_ac_state_fops = {
 	.open = acpi_ac_state_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index 35f113b..c3722cd 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -189,7 +189,7 @@ struct acpi_video_device {
 
 /* bus */
 static int acpi_video_bus_info_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_video_bus_info_fops = {
+static const struct file_operations acpi_video_bus_info_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_bus_info_open_fs,
 	.read = seq_read,
@@ -198,7 +198,7 @@ static struct file_operations acpi_video_bus_info_fops = {
 };
 
 static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_video_bus_ROM_fops = {
+static const struct file_operations acpi_video_bus_ROM_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_bus_ROM_open_fs,
 	.read = seq_read,
@@ -208,7 +208,7 @@ static struct file_operations acpi_video_bus_ROM_fops = {
 
 static int acpi_video_bus_POST_info_open_fs(struct inode *inode,
 					    struct file *file);
-static struct file_operations acpi_video_bus_POST_info_fops = {
+static const struct file_operations acpi_video_bus_POST_info_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_bus_POST_info_open_fs,
 	.read = seq_read,
@@ -237,7 +237,7 @@ static struct file_operations acpi_video_bus_DOS_fops = {
 /* device */
 static int acpi_video_device_info_open_fs(struct inode *inode,
 					  struct file *file);
-static struct file_operations acpi_video_device_info_fops = {
+static const struct file_operations acpi_video_device_info_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_device_info_open_fs,
 	.read = seq_read,
@@ -267,7 +267,7 @@ static struct file_operations acpi_video_device_brightness_fops = {
 
 static int acpi_video_device_EDID_open_fs(struct inode *inode,
 					  struct file *file);
-static struct file_operations acpi_video_device_EDID_fops = {
+static const struct file_operations acpi_video_device_EDID_fops = {
 	.owner = THIS_MODULE,
 	.open = acpi_video_device_EDID_open_fs,
 	.read = seq_read,
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 0574add..b09c4fd 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -322,7 +322,7 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 int acpi_processor_tstate_has_changed(struct acpi_processor *pr);
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
-extern struct file_operations acpi_processor_throttling_fops;
+extern const struct file_operations acpi_processor_throttling_fops;
 extern void acpi_processor_throttling_init(void);
 /* in processor_idle.c */
 int acpi_processor_power_init(struct acpi_processor *pr,
@@ -336,7 +336,7 @@ extern struct cpuidle_driver acpi_idle_driver;
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-extern struct file_operations acpi_processor_limit_fops;
+extern const struct file_operations acpi_processor_limit_fops;
 extern struct thermal_cooling_device_ops processor_cooling_ops;
 #ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(void);
-- 
# Created with git-export-patch

