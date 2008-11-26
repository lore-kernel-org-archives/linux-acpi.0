From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 2/8] acpi: replace return_ACPI_STATUS with return
Date: Wed, 26 Nov 2008 10:53:32 +0800
Message-ID: <1227668012.7702.89.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53703 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752824AbYKZC6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 21:58:53 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

return_ACPI_STATUS is an internal acpica function.
Replace it with return.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/osl.c        |    4 ++--
 drivers/acpi/sleep/proc.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 4be2521..8057a8f 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -737,7 +737,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 
 	dpc = kmalloc(sizeof(struct acpi_os_dpc), GFP_ATOMIC);
 	if (!dpc)
-		return_ACPI_STATUS(AE_NO_MEMORY);
+		return AE_NO_MEMORY;
 
 	dpc->function = function;
 	dpc->context = context;
@@ -758,7 +758,7 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 		status = AE_ERROR;
 		kfree(dpc);
 	}
-	return_ACPI_STATUS(status);
+	return status;
 }
 
 acpi_status acpi_os_execute(acpi_execute_type type,
diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 64e591b..1400510 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -230,10 +230,10 @@ acpi_system_write_alarm(struct file *file,
 	ACPI_FUNCTION_TRACE("acpi_system_write_alarm");
 
 	if (count > sizeof(alarm_string) - 1)
-		return_VALUE(-EINVAL);
+		return -EINVAL;
 
 	if (copy_from_user(alarm_string, buffer, count))
-		return_VALUE(-EFAULT);
+		return -EFAULT;
 
 	alarm_string[count] = '\0';
 
@@ -334,7 +334,7 @@ acpi_system_write_alarm(struct file *file,
 
 	result = 0;
       end:
-	return_VALUE(result ? result : count);
+	return result ? result : count;
 }
 #endif				/* HAVE_ACPI_LEGACY_ALARM */
 


