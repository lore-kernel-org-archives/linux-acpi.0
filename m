From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3] acpi/processor: Fix the return value of acpi_processor_ids_walk()
Date: Fri, 24 Aug 2018 10:51:26 +0800
Message-ID: <20180824025126.19231-1-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, rjw@rjwysocki.net, tglx@linutronix.de, rafael@kernel.org, indou.takao@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>
List-Id: linux-acpi@vger.kernel.org

ACPI driver should make sure all the processor IDs in their ACPI Namespace
are unique. the driver performs a depth-first walk of the namespace tree
and calls the acpi_processor_ids_walk() to check the duplicate IDs.

But, the acpi_processor_ids_walk() mistakes the return value. If a
processor is checked, it returns true which causes the walk break
immediately, and other processors will never be checked.

Repace the value with AE_OK which is the standard acpi_status value.
And don't abort the namespace walk even on error.

Fixes 8c8cb30f49b8 ("acpi/processor: Implement DEVICE operator for processor enumeration")
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
Changelog:
  v2 --> v3:
   - Fix a compiler error reported by LKP
  v1 --> v2:
   - Fix the check against duplicate IDs suggested by Rafael.
  
  Now，the duplicate IDs only be found in Ivb42 machine, and we have added this check at 
  linux-4.9. But, we introduced a bug in linux-4.12 by commit 8c8cb30f49b8.

  For resolving the bug, firstly, I removed the check[1]. because Linux will compare
  the coming ID with present processors when it hot-added a physical CPU and will avoid
  using duplicate IDs.

  But, seems we should consider all the possible processors. So, with this patch, All
  the processors with the same IDs will never be hot-plugged.

[1] https://lkml.org/lkml/2018/5/28/213
---
 drivers/acpi/acpi_processor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 449d86d39965..fc447410ae4d 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -643,7 +643,7 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 
 	status = acpi_get_type(handle, &acpi_type);
 	if (ACPI_FAILURE(status))
-		return false;
+		return status;
 
 	switch (acpi_type) {
 	case ACPI_TYPE_PROCESSOR:
@@ -663,11 +663,12 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 	}
 
 	processor_validated_ids_update(uid);
-	return true;
+	return AE_OK;
 
 err:
+	/* Exit on error, but don't abort the namespace walk */
 	acpi_handle_info(handle, "Invalid processor object\n");
-	return false;
+	return AE_OK;
 
 }
 
-- 
2.14.3
