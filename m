From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date: Fri,  4 May 2018 16:08:42 +0800
Message-ID: <1525421322-23431-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

According to current implementation of acpi_pad driver,
it does not make sense to spawn any power saving threads
on the cpus which are already idle - it might bring
unnecessary overhead on these idle cpus and causes power
waste. So verify the condition that if the number of 'busy'
cpus exceeds the amount of the 'forced idle' cpus - This is
applicable due to round-robin attribute of the power saving
threads, otherwise ignore the setting/ACPI notification.

Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
Suggested-by: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/acpi_pad.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f7..190aa36 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -253,13 +253,36 @@ static void set_power_saving_task_num(unsigned int num)
 			destroy_power_saving_task();
 	}
 }
+/*
+ * Extra acpi_pad threads should not be created until
+ * the requested idle count is less than/equals to the
+ * number of the busy cpus - it does not make sense to
+ * throttle the idle cpus.
+ */
+static bool idle_cpu_valid(unsigned int num_cpus)
+{
+	int busy_nr = 0, i = 0;
+
+	for_each_online_cpu(i) {
+		/*
+		 * In case the acpi_pad threads are treated as
+		 * idle in the future(as intel_powerclamp),
+		 * the pad_busy_cpus_bits should be checked too.
+		 */
+		if (!idle_cpu(i))
+			busy_nr++;
+	}
+
+	return (busy_nr >= num_cpus) ? true : false;
+}
 
 static void acpi_pad_idle_cpus(unsigned int num_cpus)
 {
 	get_online_cpus();
 
 	num_cpus = min_t(unsigned int, num_cpus, num_online_cpus());
-	set_power_saving_task_num(num_cpus);
+	if (idle_cpu_valid(num_cpus))
+		set_power_saving_task_num(num_cpus);
 
 	put_online_cpus();
 }
-- 
2.7.4
