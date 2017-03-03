From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3 4/5] acpi/processor: Implement DEVICE operator for processor enumeration
Date: Fri, 3 Mar 2017 16:02:26 +0800
Message-ID: <1488528147-2279-5-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, lenb@kernel.org, xiaolong.ye@intel.com, guzheng1@huawei.com, izumi.taku@jp.fujitsu.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

ACPI allows to declare processors either with the PROCESSOR or with the
DEVICE operator. The current implementation handles only the PROCESSOR
operator.

On a system which uses the DEVICE operator for processor enumeration the
evaluation fails.

Check for the ACPI type of the ACPI handle and evaluate PROCESSOR and
DEVICE types separately.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Tested-by: Xiaolong Ye <xiaolong.ye@intel.com>
---
 drivers/acpi/acpi_processor.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5d208a9..9a98d7e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -633,25 +633,50 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 						  void **rv)
 {
 	acpi_status status;
+	acpi_object_type acpi_type;
+	unsigned long long uid;
 	union acpi_object object = { 0 };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 
-	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
-		acpi_handle_info(handle, "Not get the processor object\n");
-	else
-		processor_validated_ids_update(object.processor.proc_id);
+		return false;
+
+	switch (acpi_type) {
+	case ACPI_TYPE_PROCESSOR:
+		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
+		if (ACPI_FAILURE(status))
+			goto err;
+		uid = object.processor.proc_id;
+		break;
+
+	case ACPI_TYPE_DEVICE:
+		status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
+		if (ACPI_FAILURE(status))
+			goto err;
+		break;
+	default:
+		goto err;
+	}
+
+	processor_validated_ids_update(uid);
+	return true;
+
+err:
+	acpi_handle_info(handle, "Invalid processor object\n");
+	return false;
 
-	return AE_OK;
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
