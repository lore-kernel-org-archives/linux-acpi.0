From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI: sysfs: Prevent get_status() from returning acpi_status
Date: Tue, 12 Mar 2019 10:30:29 +0100
Message-ID: <53542709.3ZnE1UDn36@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The return value of get_status() is passed to user space on errors,
so it should not return acpi_status values then.  Make it return
error values that are meaningful for user space instead.

This also makes a Clang warning regarding the initialization of a
local variable in get_status() go away.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Resend with a proper changelog and tags from Nathan.

---
 drivers/acpi/sysfs.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

Index: linux-pm/drivers/acpi/sysfs.c
===================================================================
--- linux-pm.orig/drivers/acpi/sysfs.c
+++ linux-pm/drivers/acpi/sysfs.c
@@ -648,26 +648,29 @@ static void acpi_global_event_handler(u3
 	}
 }
 
-static int get_status(u32 index, acpi_event_status *status,
+static int get_status(u32 index, acpi_event_status *ret,
 		      acpi_handle *handle)
 {
-	int result;
+	acpi_status status;
 
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
 		return -EINVAL;
 
 	if (index < num_gpes) {
-		result = acpi_get_gpe_device(index, handle);
-		if (result) {
+		status = acpi_get_gpe_device(index, handle);
+		if (ACPI_FAILURE(status)) {
 			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
 					"Invalid GPE 0x%x", index));
-			return result;
+			return -ENXIO;
 		}
-		result = acpi_get_gpe_status(*handle, index, status);
-	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
-		result = acpi_get_event_status(index - num_gpes, status);
+		status = acpi_get_gpe_status(*handle, index, ret);
+	} else {
+		status = acpi_get_event_status(index - num_gpes, ret);
+	}
+	if (ACPI_FAILURE(status))
+		return -EIO;
 
-	return result;
+	return 0;
 }
 
 static ssize_t counter_show(struct kobject *kobj,
