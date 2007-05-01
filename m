From: Len Brown <lenb@kernel.org>
Subject: Subject: [PATCH 1/2] ACPI: thermal trip points are read-only
Date: Mon, 30 Apr 2007 23:35:43 -0400
Message-ID: <200704302335.44125.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47152 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbXEACeX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 Apr 2007 22:34:23 -0400
Received: from [10.251.2.25] ([192.102.209.1])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l412X9WY021494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 1 May 2007 02:34:22 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

/proc/acpi/thermal_zone/*/trip_points displays
what the kernel reads from the BIOS via ACPI.

If you echo a string of ':' deliminted numbers to this file
then it will change what it displays.

But it shouldn't, since the kernel has no way to communicate
these changes to ACPI thermal zones.  ACPI thermal zone
trip points are read-only.

The kernel does have the opportunity to ask the BIOS to change
the trip points with _SCP - Set Cooling Policy.

Request Active Cooling Mode:
# echo 0 > /proc/acpi/thermal_zone/*/cooling_policy

Request Passive Cooling Mode:
# echo 1 > /proc/acpi/thermal_zone/*/cooling_policy

However, in practice it is quite rare for the BIOS
to support the optional _SCP, and it is even more rare
for the BIOS to export an _SCP that actually changes
the trip points.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/thermal.c |   65 ------------------------------------------------
 1 files changed, 0 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 589b98b..73b6fe7 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -86,9 +86,6 @@ static int acpi_thermal_resume(struct acpi_device *device);
 static int acpi_thermal_state_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_temp_open_fs(struct inode *inode, struct file *file);
 static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file);
-static ssize_t acpi_thermal_write_trip_points(struct file *,
-					      const char __user *, size_t,
-					      loff_t *);
 static int acpi_thermal_cooling_open_fs(struct inode *inode, struct file *file);
 static ssize_t acpi_thermal_write_cooling_mode(struct file *,
 					       const char __user *, size_t,
@@ -193,7 +190,6 @@ static const struct file_operations acpi_thermal_temp_fops = {
 static const struct file_operations acpi_thermal_trip_fops = {
 	.open = acpi_thermal_trip_open_fs,
 	.read = seq_read,
-	.write = acpi_thermal_write_trip_points,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -889,67 +885,6 @@ static int acpi_thermal_trip_open_fs(struct inode *inode, struct file *file)
 	return single_open(file, acpi_thermal_trip_seq_show, PDE(inode)->data);
 }
 
-static ssize_t
-acpi_thermal_write_trip_points(struct file *file,
-			       const char __user * buffer,
-			       size_t count, loff_t * ppos)
-{
-	struct seq_file *m = file->private_data;
-	struct acpi_thermal *tz = m->private;
-
-	char *limit_string;
-	int num, critical, hot, passive;
-	int *active;
-	int i = 0;
-
-
-	limit_string = kzalloc(ACPI_THERMAL_MAX_LIMIT_STR_LEN, GFP_KERNEL);
-	if (!limit_string)
-		return -ENOMEM;
-
-	active = kmalloc(ACPI_THERMAL_MAX_ACTIVE * sizeof(int), GFP_KERNEL);
-	if (!active) {
-		kfree(limit_string);
-		return -ENOMEM;
-	}
-
-	if (!tz || (count > ACPI_THERMAL_MAX_LIMIT_STR_LEN - 1)) {
-		count = -EINVAL;
-		goto end;
-	}
-
-	if (copy_from_user(limit_string, buffer, count)) {
-		count = -EFAULT;
-		goto end;
-	}
-
-	limit_string[count] = '\0';
-
-	num = sscanf(limit_string, "%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d",
-		     &critical, &hot, &passive,
-		     &active[0], &active[1], &active[2], &active[3], &active[4],
-		     &active[5], &active[6], &active[7], &active[8],
-		     &active[9]);
-	if (!(num >= 5 && num < (ACPI_THERMAL_MAX_ACTIVE + 3))) {
-		count = -EINVAL;
-		goto end;
-	}
-
-	tz->trips.critical.temperature = CELSIUS_TO_KELVIN(critical);
-	tz->trips.hot.temperature = CELSIUS_TO_KELVIN(hot);
-	tz->trips.passive.temperature = CELSIUS_TO_KELVIN(passive);
-	for (i = 0; i < num - 3; i++) {
-		if (!(tz->trips.active[i].flags.valid))
-			break;
-		tz->trips.active[i].temperature = CELSIUS_TO_KELVIN(active[i]);
-	}
-
-      end:
-	kfree(active);
-	kfree(limit_string);
-	return count;
-}
-
 static int acpi_thermal_cooling_seq_show(struct seq_file *seq, void *offset)
 {
 	struct acpi_thermal *tz = seq->private;
-- 
1.5.0.1.771.g77e6f

