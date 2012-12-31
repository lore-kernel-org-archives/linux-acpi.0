From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 18/27] ACPICA: Fix possible memory leak in dispatcher error path.
Date: Mon, 31 Dec 2012 08:06:56 +0800
Message-ID: <0c7cd589041658e8a2aa84866a7c170b4fe7c5dc.1356668534.git.lv.zheng@intel.com>
References: <cover.1356668530.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35559 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755200Ab2LaAHF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Dec 2012 19:07:05 -0500
In-Reply-To: <cover.1356668530.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Rafael J Wysocki <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, Tim Gardner <tim.gardner@canonical.com>, Bob Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>

From: Tim Gardner <tim.gardner@canonical.com>

On error, delete mutex object created during method mutex creation.
Reported by tim.gardner@canonical.com.

Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dsmethod.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 54c968a..4e5873a 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -151,6 +151,7 @@ acpi_ds_create_method_mutex(union acpi_operand_object *method_desc)
 
 	status = acpi_os_create_mutex(&mutex_desc->mutex.os_mutex);
 	if (ACPI_FAILURE(status)) {
+		acpi_ut_delete_object_desc(mutex_desc);
 		return_ACPI_STATUS(status);
 	}
 
-- 
1.7.10

