From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: [PATCH] ACPI: constify function pointer tables
Date: Tue, 22 Jan 2008 20:44:42 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801222044260.5722@fbirervta.pbzchgretzou.qr>
References: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sovereign.computergmbh.de ([85.214.69.204]:46078 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYAVToo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2008 14:44:44 -0500
In-Reply-To: <54038cd4f87a03884e4f59f8f3697889dfb63c54.1201030614.git.jengelh@computergmbh.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@computergmbh.de>
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
index c4a769d..e164029 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -713,7 +713,7 @@ DECLARE_FILE_FUNCTIONS(alarm);
 static struct battery_file {
 	struct file_operations ops;
 	mode_t mode;
-	char *name;
+	const char *name;
 } acpi_battery_file[] = {
 	FILE_DESCRIPTION_RO(info),
 	FILE_DESCRIPTION_RO(state),
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 97dc161..0efbd51 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -629,7 +629,7 @@ static int acpi_ec_info_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_ec_read_info, PDE(inode)->data);
 }
 
-static struct file_operations acpi_ec_info_ops = {
+static const struct file_operations acpi_ec_info_ops = {
 	.open = acpi_ec_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 463b024..263a136 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -389,7 +389,7 @@ EXPORT_SYMBOL(acpi_processor_notify_smm);
 /* /proc/acpi/processor/../performance interface (DEPRECATED) */
 
 static int acpi_processor_perf_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_processor_perf_fops = {
+static const struct file_operations acpi_processor_perf_fops = {
 	.open = acpi_processor_perf_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
index 06e6f3f..2510928 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -382,7 +382,7 @@ static ssize_t acpi_processor_write_limit(struct file * file,
 	return count;
 }
 
-struct file_operations acpi_processor_limit_fops = {
+const struct file_operations acpi_processor_limit_fops = {
 	.open = acpi_processor_limit_open_fs,
 	.read = seq_read,
 	.write = acpi_processor_write_limit,
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index 6742d7b..916204c 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -917,7 +917,7 @@ static ssize_t acpi_processor_write_throttling(struct file *file,
 	return count;
 }
 
-struct file_operations acpi_processor_throttling_fops = {
+const struct file_operations acpi_processor_throttling_fops = {
 	.open = acpi_processor_throttling_open_fs,
 	.read = seq_read,
 	.write = acpi_processor_write_throttling,
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f136c7d..23c8618 100644
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
 	struct proc_dir_entry *entry = NULL;
 
@@ -694,7 +694,7 @@ static int acpi_battery_alarm_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_battery_read_alarm, PDE(inode)->data);
 }
 
-static struct file_operations acpi_battery_info_fops = {
+static const struct file_operations acpi_battery_info_fops = {
 	.open = acpi_battery_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -702,7 +702,7 @@ static struct file_operations acpi_battery_info_fops = {
 	.owner = THIS_MODULE,
 };
 
-static struct file_operations acpi_battery_state_fops = {
+static const struct file_operations acpi_battery_state_fops = {
 	.open = acpi_battery_state_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -710,7 +710,7 @@ static struct file_operations acpi_battery_state_fops = {
 	.owner = THIS_MODULE,
 };
 
-static struct file_operations acpi_battery_alarm_fops = {
+static const struct file_operations acpi_battery_alarm_fops = {
 	.open = acpi_battery_alarm_open_fs,
 	.read = seq_read,
 	.write = acpi_battery_write_alarm,
@@ -742,7 +742,7 @@ static int acpi_ac_state_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_ac_read_state, PDE(inode)->data);
 }
 
-static struct file_operations acpi_ac_state_fops = {
+static const struct file_operations acpi_ac_state_fops = {
 	.open = acpi_ac_state_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
index bd77e81..25de850 100644
--- a/drivers/acpi/video.c
+++ b/drivers/acpi/video.c
@@ -184,7 +184,7 @@ struct acpi_video_device {
 
 /* bus */
 static int acpi_video_bus_info_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_video_bus_info_fops = {
+static const struct file_operations acpi_video_bus_info_fops = {
 	.open = acpi_video_bus_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -192,7 +192,7 @@ static struct file_operations acpi_video_bus_info_fops = {
 };
 
 static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file *file);
-static struct file_operations acpi_video_bus_ROM_fops = {
+static const struct file_operations acpi_video_bus_ROM_fops = {
 	.open = acpi_video_bus_ROM_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -201,7 +201,7 @@ static struct file_operations acpi_video_bus_ROM_fops = {
 
 static int acpi_video_bus_POST_info_open_fs(struct inode *inode,
 					    struct file *file);
-static struct file_operations acpi_video_bus_POST_info_fops = {
+static const struct file_operations acpi_video_bus_POST_info_fops = {
 	.open = acpi_video_bus_POST_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -227,7 +227,7 @@ static struct file_operations acpi_video_bus_DOS_fops = {
 /* device */
 static int acpi_video_device_info_open_fs(struct inode *inode,
 					  struct file *file);
-static struct file_operations acpi_video_device_info_fops = {
+static const struct file_operations acpi_video_device_info_fops = {
 	.open = acpi_video_device_info_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
@@ -254,7 +254,7 @@ static struct file_operations acpi_video_device_brightness_fops = {
 
 static int acpi_video_device_EDID_open_fs(struct inode *inode,
 					  struct file *file);
-static struct file_operations acpi_video_device_EDID_fops = {
+static const struct file_operations acpi_video_device_EDID_fops = {
 	.open = acpi_video_device_EDID_open_fs,
 	.read = seq_read,
 	.llseek = seq_lseek,
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 76411b1..d997361 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -315,7 +315,7 @@ static inline int acpi_processor_ppc_has_changed(struct acpi_processor *pr)
 /* in processor_throttling.c */
 int acpi_processor_get_throttling_info(struct acpi_processor *pr);
 extern int acpi_processor_set_throttling(struct acpi_processor *pr, int state);
-extern struct file_operations acpi_processor_throttling_fops;
+extern const struct file_operations acpi_processor_throttling_fops;
 
 /* in processor_idle.c */
 int acpi_processor_power_init(struct acpi_processor *pr,
@@ -329,7 +329,7 @@ extern struct cpuidle_driver acpi_idle_driver;
 
 /* in processor_thermal.c */
 int acpi_processor_get_limit_info(struct acpi_processor *pr);
-extern struct file_operations acpi_processor_limit_fops;
+extern const struct file_operations acpi_processor_limit_fops;
 
 #ifdef CONFIG_CPU_FREQ
 void acpi_thermal_cpufreq_init(void);
-- 
1.5.3.4

