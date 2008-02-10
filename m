From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION]fan turns at highspeed after suspend2ram
Date: Sun, 10 Feb 2008 19:54:30 +0100
Message-ID: <200802101954.31061.rjw@sisk.pl>
References: <1202664109.8394.19.camel@mtlp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54404 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338AbYBJS5L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Feb 2008 13:57:11 -0500
In-Reply-To: <1202664109.8394.19.camel@mtlp>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mirco Tischler <mt-ml@gmx.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sunday, 10 of February 2008, Mirco Tischler wrote:
> Hi

Hi,

> I think I found a regression in 2.6.24-git. After waking up from suspend
> 2 ram, the fan of my laptop turns constantly at highest speed. It didn't
> do this in 2.6.24.
> 
> I bisected it down to this commit:
> 
> commit c95d47a868f35cd47643d116a3c680cdaa954df8
> Author: Rafael J. Wysocki <rjw@sisk.pl>
> Date:   Tue Jan 8 00:05:21 2008 +0100
> 
>     ACPI: Separate invocations of _GTS and _BFS from _PTS and _WAK
> 
> Reverting it resolves the problem for me, but I can't say if this makes
> any sense.

Well, _GTS and _BFS are nops on all machines known to me.  However, there's
one more change in there that may break things in (very speculative) theory.

Can you apply the appended patch on top of the current mainline and tetest?

Thanks,
Rafael

---
 drivers/acpi/hardware/hwsleep.c |   72 ++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

Index: linux-2.6/drivers/acpi/hardware/hwsleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/hardware/hwsleep.c
+++ linux-2.6/drivers/acpi/hardware/hwsleep.c
@@ -494,12 +494,47 @@ acpi_status acpi_leave_sleep_state_prep(
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status;
+
+	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
+
+	/* Execute the _BFS method */
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = sleep_state;
+
+	status = acpi_evaluate_object(NULL, METHOD_NAME__BFS, &arg_list, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
+		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
+	}
+
+	return_ACPI_STATUS(status);
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_leave_sleep_state
+ *
+ * PARAMETERS:  sleep_state         - Which sleep state we just exited
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Perform OS-independent ACPI cleanup after a sleep
+ *              Called with interrupts ENABLED.
+ *
+ ******************************************************************************/
+acpi_status acpi_leave_sleep_state(u8 sleep_state)
+{
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
 	u32 PM1Acontrol;
 	u32 PM1Bcontrol;
 
-	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state_prep);
+	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state);
 
 	/*
 	 * Set SLP_TYPE and SLP_EN to state S0.
@@ -546,41 +581,6 @@ acpi_status acpi_leave_sleep_state_prep(
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
-	return_ACPI_STATUS(status);
-}
-
-/*******************************************************************************
- *
- * FUNCTION:    acpi_leave_sleep_state
- *
- * PARAMETERS:  sleep_state         - Which sleep state we just exited
- *
- * RETURN:      Status
- *
- * DESCRIPTION: Perform OS-independent ACPI cleanup after a sleep
- *              Called with interrupts ENABLED.
- *
- ******************************************************************************/
-acpi_status acpi_leave_sleep_state(u8 sleep_state)
-{
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
-	acpi_status status;
-
-	ACPI_FUNCTION_TRACE(acpi_leave_sleep_state);
-
 	/* Ensure enter_sleep_state_prep -> enter_sleep_state ordering */
 
 	acpi_gbl_sleep_type_a = ACPI_SLEEP_TYPE_INVALID;
