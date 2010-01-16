From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/16] acpi_pad: fix error checks
Date: Sat, 16 Jan 2010 02:32:52 -0500
Message-ID: <3b8cb427e9281790f36e847e46cb1d005a50cec0.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:54669 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab0APHdN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:13 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00IPGWZAGCE3@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:11 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Chen Gong <gong.chen@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Chen Gong <gong.chen@linux.intel.com>

There are some fixes listed below:
1. When met a bogus BIOS, the return value of cpu number maybe is
   a negative value so that acpi_pad_pur get an unexpected result.
2. the return value of function acpi_pad_idle_cpus is useless.
3. enhance the process of create_power_saving_task/destroy_power_saving_task
4. Add more error checks when evaluating _PUR object.
5. one typo fix

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
Acked-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpi_pad.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 0d2cdb8..a7bd49f 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -207,7 +207,7 @@ static int power_saving_thread(void *data)
 		 * the mechanism only works when all CPUs have RT task running,
 		 * as if one CPU hasn't RT task, RT task from other CPUs will
 		 * borrow CPU time from this CPU and cause RT task use > 95%
-		 * CPU time. To make 'avoid staration' work, takes a nap here.
+		 * CPU time. To make 'avoid starvation' work, takes a nap here.
 		 */
 		if (do_sleep)
 			schedule_timeout_killable(HZ * idle_pct / 100);
@@ -221,14 +221,18 @@ static struct task_struct *ps_tsks[NR_CPUS];
 static unsigned int ps_tsk_num;
 static int create_power_saving_task(void)
 {
+	int rc = -ENOMEM;
+
 	ps_tsks[ps_tsk_num] = kthread_run(power_saving_thread,
 		(void *)(unsigned long)ps_tsk_num,
 		"power_saving/%d", ps_tsk_num);
-	if (ps_tsks[ps_tsk_num]) {
+	rc = IS_ERR(ps_tsks[ps_tsk_num]) ? PTR_ERR(ps_tsks[ps_tsk_num]) : 0;
+	if (!rc)
 		ps_tsk_num++;
-		return 0;
-	}
-	return -EINVAL;
+	else
+		ps_tsks[ps_tsk_num] = NULL;
+
+	return rc;
 }
 
 static void destroy_power_saving_task(void)
@@ -236,6 +240,7 @@ static void destroy_power_saving_task(void)
 	if (ps_tsk_num > 0) {
 		ps_tsk_num--;
 		kthread_stop(ps_tsks[ps_tsk_num]);
+		ps_tsks[ps_tsk_num] = NULL;
 	}
 }
 
@@ -252,7 +257,7 @@ static void set_power_saving_task_num(unsigned int num)
 	}
 }
 
-static int acpi_pad_idle_cpus(unsigned int num_cpus)
+static void acpi_pad_idle_cpus(unsigned int num_cpus)
 {
 	get_online_cpus();
 
@@ -260,7 +265,6 @@ static int acpi_pad_idle_cpus(unsigned int num_cpus)
 	set_power_saving_task_num(num_cpus);
 
 	put_online_cpus();
-	return 0;
 }
 
 static uint32_t acpi_pad_idle_cpus_num(void)
@@ -368,19 +372,21 @@ static void acpi_pad_remove_sysfs(struct acpi_device *device)
 static int acpi_pad_pur(acpi_handle handle, int *num_cpus)
 {
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	acpi_status status;
 	union acpi_object *package;
 	int rev, num, ret = -EINVAL;
 
-	status = acpi_evaluate_object(handle, "_PUR", NULL, &buffer);
-	if (ACPI_FAILURE(status))
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_PUR", NULL, &buffer)))
+		return -EINVAL;
+
+	if (!buffer.length || !buffer.pointer)
 		return -EINVAL;
+
 	package = buffer.pointer;
 	if (package->type != ACPI_TYPE_PACKAGE || package->package.count != 2)
 		goto out;
 	rev = package->package.elements[0].integer.value;
 	num = package->package.elements[1].integer.value;
-	if (rev != 1)
+	if (rev != 1 || num < 0)
 		goto out;
 	*num_cpus = num;
 	ret = 0;
@@ -409,7 +415,7 @@ static void acpi_pad_ost(acpi_handle handle, int stat,
 
 static void acpi_pad_handle_notify(acpi_handle handle)
 {
-	int num_cpus, ret;
+	int num_cpus;
 	uint32_t idle_cpus;
 
 	mutex_lock(&isolated_cpus_lock);
@@ -417,12 +423,9 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 		mutex_unlock(&isolated_cpus_lock);
 		return;
 	}
-	ret = acpi_pad_idle_cpus(num_cpus);
+	acpi_pad_idle_cpus(num_cpus);
 	idle_cpus = acpi_pad_idle_cpus_num();
-	if (!ret)
-		acpi_pad_ost(handle, 0, idle_cpus);
-	else
-		acpi_pad_ost(handle, 1, 0);
+	acpi_pad_ost(handle, 0, idle_cpus);
 	mutex_unlock(&isolated_cpus_lock);
 }
 
-- 
1.6.0.6

