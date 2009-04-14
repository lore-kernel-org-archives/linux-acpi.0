From: yakui_zhao <yakui.zhao@intel.com>
Subject: [PATCH]: ACPI: Delete the evaluation of _GTS/_BFS object
Date: Tue, 14 Apr 2009 10:38:16 +0800
Message-ID: <1239676696.5564.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37650 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZDNCg4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:36:56 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

From: Zhao Yakui <yakui.zhao@intel.com>

According to the ACPI 3.0b spec the _GTS/_BFS object is defined, in which the
specific function can be performed.  And the _GTS object should be evaluated
just prior to setting the SLP_EN register.

But on most boxes there is no _GTS/_BFS object. And even when they exists,
they won't be evaluated on windows XP/Vista. 

At the same time on one box there exists the _GTS object, in which the EC
is accessed. If EC access is deleted in _GTS object, the S3/S4/S5 can work
well. In fact this bug is also related with the incorrect EC working mode.
In the course of suspend/resume/shutdown the polling mode should be used
and the udelay should be used instead of msleep because the timer interrupt
is disabled.

But it will be easier to delete the _GTS/_BFS object.

http://bugzilla.kernel.org/show_bug.cgi?id=13041

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/acpi/acpica/hwsleep.c |   27 ---------------------------
 1 file changed, 27 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/hwsleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/hwsleep.c	2009-04-09 14:09:25.000000000 +0800
+++ linux-2.6/drivers/acpi/acpica/hwsleep.c	2009-04-13 10:14:08.000000000 +0800
@@ -230,8 +230,6 @@
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
 	u32 in_value;
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE(acpi_enter_sleep_state);
@@ -278,17 +276,6 @@
 		return_ACPI_STATUS(status);
 	}
 
-	/* Execute the _GTS method */
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = sleep_state;
-
-	status = acpi_evaluate_object(NULL, METHOD_NAME__GTS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		return_ACPI_STATUS(status);
-	}
 
 	/* Get current value of PM1A control */
 
@@ -462,8 +449,6 @@
  ******************************************************************************/
 acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 {
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
 	acpi_status status;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
@@ -513,18 +498,6 @@
 		}
 	}
 
-	/* Execute the _BFS method */
-
-	arg_list.count = 1;
-	arg_list.pointer = &arg;
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = sleep_state;
-
-	status = acpi_evaluate_object(NULL, METHOD_NAME__BFS, &arg_list, NULL);
-	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
-		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
-	}
-
 	return_ACPI_STATUS(status);
 }
 


