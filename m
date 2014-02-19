From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Patch v2 2/5] acpi_pad: use acpi_evaluate_ost() to replace open-coded version
Date: Wed, 19 Feb 2014 14:02:16 +0800
Message-ID: <1392789739-32317-2-git-send-email-jiang.liu@linux.intel.com>
References: <1392789739-32317-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392789739-32317-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use public function acpi_evaluate_ost() to replace open-coded
version of evaluating ACPI _OST method.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/acpi_pad.c |   24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index df96a0f..37d7302 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -408,28 +408,14 @@ static int acpi_pad_pur(acpi_handle handle)
 	return num;
 }
 
-/* Notify firmware how many CPUs are idle */
-static void acpi_pad_ost(acpi_handle handle, int stat,
-	uint32_t idle_cpus)
-{
-	union acpi_object params[3] = {
-		{.type = ACPI_TYPE_INTEGER,},
-		{.type = ACPI_TYPE_INTEGER,},
-		{.type = ACPI_TYPE_BUFFER,},
-	};
-	struct acpi_object_list arg_list = {3, params};
-
-	params[0].integer.value = ACPI_PROCESSOR_AGGREGATOR_NOTIFY;
-	params[1].integer.value =  stat;
-	params[2].buffer.length = 4;
-	params[2].buffer.pointer = (void *)&idle_cpus;
-	acpi_evaluate_object(handle, "_OST", &arg_list, NULL);
-}
-
 static void acpi_pad_handle_notify(acpi_handle handle)
 {
 	int num_cpus;
 	uint32_t idle_cpus;
+	struct acpi_buffer param = {
+		.length = 4,
+		.pointer = (void *)&idle_cpus,
+	};
 
 	mutex_lock(&isolated_cpus_lock);
 	num_cpus = acpi_pad_pur(handle);
@@ -439,7 +425,7 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 	}
 	acpi_pad_idle_cpus(num_cpus);
 	idle_cpus = acpi_pad_idle_cpus_num();
-	acpi_pad_ost(handle, 0, idle_cpus);
+	acpi_evaluate_ost(handle, ACPI_PROCESSOR_AGGREGATOR_NOTIFY, 0, &param);
 	mutex_unlock(&isolated_cpus_lock);
 }
 
-- 
1.7.10.4
