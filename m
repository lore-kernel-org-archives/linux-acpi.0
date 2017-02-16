From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] acpi: Fix the check handle in case of declaring processors using the Device operator
Date: Thu, 16 Feb 2017 18:38:12 +0800
Message-ID: <1487241492-30005-2-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1487241492-30005-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1487241492-30005-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

In ACPI spec, we can declare processors using both Processor and
Device operator. And before we use the ACPI table, we should check
the correctness for all processors in ACPI namespace.

But, Currently, the check handle is just include only the processors
which are declared by Processor operator. It misses the processors
declared by Device operator.

The patch adds the case of Device operator.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 drivers/acpi/acpi_processor.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 3de3b6b..ff569cb 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -638,25 +638,43 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 						  void **rv)
 {
 	acpi_status status;
+	acpi_object_type acpi_type;
+	unsigned long long uid;
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 
-	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
-	if (ACPI_FAILURE(status))
-		acpi_handle_info(handle, "Not get the processor object\n");
-	else
-		processor_validated_ids_update(object.processor.proc_id);
+	status = acpi_get_type(handle, &acpi_type);
+	switch (acpi_type) {
+	case ACPI_TYPE_PROCESSOR:
+		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			acpi_handle_info(handle, "Not get the processor object\n");
+		else
+			processor_validated_ids_update(
+						object.processor.proc_id);
+		break;
+	case ACPI_TYPE_DEVICE:
+		status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
+		if (ACPI_FAILURE(status))
+			return false;
+		processor_validated_ids_update(uid);
+		break;
+	default:
+		return false;
+	}
 
 	return AE_OK;
 }
 
-static void __init acpi_processor_check_duplicates(void)
+void __init acpi_processor_check_duplicates(void)
 {
-	/* Search all processor nodes in ACPI namespace */
+	/* check the correctness for all processors in ACPI namespace */
 	acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
 						ACPI_UINT32_MAX,
 						acpi_processor_ids_walk,
 						NULL, NULL, NULL);
+	acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID, acpi_processor_ids_walk,
+						NULL, NULL);
 }
 
 bool __init acpi_processor_validate_proc_id(int proc_id)
-- 
2.5.5
