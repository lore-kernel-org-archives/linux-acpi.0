From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFC Patch v1 5/6] acpi_processor: use acpi_evaluate_pad() to replace open-coded version
Date: Mon, 17 Feb 2014 13:02:52 +0800
Message-ID: <1392613373-11003-5-git-send-email-jiang.liu@linux.intel.com>
References: <1392613271-10912-1-git-send-email-jiang.liu@linux.intel.com>
 <1392613373-11003-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392613373-11003-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Use public function acpi_evaluate_pad() to replace open-coded
version of evaluating ACPI _OST method.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/acpi/processor_perflib.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index ff90054..cfc8aba 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -156,17 +156,9 @@ static int acpi_processor_get_platform_limit(struct acpi_processor *pr)
  */
 static void acpi_processor_ppc_ost(acpi_handle handle, int status)
 {
-	union acpi_object params[2] = {
-		{.type = ACPI_TYPE_INTEGER,},
-		{.type = ACPI_TYPE_INTEGER,},
-	};
-	struct acpi_object_list arg_list = {2, params};
-
-	if (acpi_has_method(handle, "_OST")) {
-		params[0].integer.value = ACPI_PROCESSOR_NOTIFY_PERFORMANCE;
-		params[1].integer.value =  status;
-		acpi_evaluate_object(handle, "_OST", &arg_list, NULL);
-	}
+	if (acpi_has_method(handle, "_OST"))
+		acpi_evaluate_ost(handle, ACPI_PROCESSOR_NOTIFY_PERFORMANCE,
+				  status, NULL);
 }
 
 int acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
-- 
1.7.10.4
