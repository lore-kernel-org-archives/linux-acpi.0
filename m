From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH 1/2] fix some errors in aggregator device driver
Date: Mon, 14 Dec 2009 09:42:28 +0800
Message-ID: <1260754949-11239-2-git-send-email-gong.chen@linux.intel.com>
References: <1260754949-11239-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:31630 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750994AbZLNBkT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 13 Dec 2009 20:40:19 -0500
In-Reply-To: <1260754949-11239-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, Chen Gong <gong.chen@linux.intel.com>

There are some fixes listed below:
1. When met a bogus BIOS, the return value of cpu number maybe is
   a negative value so that acpi_pad_pur get an unexpected result.
2. the return value of function acpi_pad_idle_cpus is useless.
3. enhance the process of create_power_saving_task/destroy_power_saving_task
4. Add more error checks when evaluating _PUR object.
5. one typo fix

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
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
1.6.5.2.143.g8cc62

