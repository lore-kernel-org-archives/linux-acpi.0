From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] ACPI / ACPICA: Collect event statistics in respective event structures
Date: Tue, 4 Jan 2011 00:59:10 +0100
Message-ID: <201101040059.10615.rjw@sisk.pl>
References: <1292218766.10384.96.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54058 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab1ADAAE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jan 2011 19:00:04 -0500
In-Reply-To: <1292218766.10384.96.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Fixed event and GPE statistics are collected with the help of two
functions, acpi_os_fixed_event_count and acpi_os_gpe_count(), that
ACPICA expects the host OS to define.  Thus every host OS that wants
to collect such statistics has to provide its own functions for this
purpose, which is going to lead to unnecessary code duplication in
the long run.  Moreover, the interfaces used by host OSes to get
event status information can be extended in a straightforward way
to also return the event statistics provided that those statistics
are collected at the ACPICA level.

Extend struct acpi_gpe_event_info and struct acpi_fixed_event_info
so that event statistics can be stored in these structures.  Modify
acpi_ev_gpe_dispatch() and acpi_ev_fixed_event_dispatch() so that
they increment GPE and fixed event counters, respectively, instead of
calling acpi_os_gpe_count() and acpi_os_fixed_event_count().  Add
functions allowing the host OS to modify the GPE and event counters
and functions.  Add total GPE event counter and functions for
manipulating it.

Modify acpi_get_event_status() and acpi_get_gpe_status() to return
current values of the appropriate event counters, if necessary, in
addition to the "usual" event status information.

Rework the kernel's code reporting GPE and fixed event statistics
through sysfs to take the above changes into account.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi Len,

This patch is a replacement for
http://git.kernel.org/?p=linux/kernel/git/lenb/linux-acpi-2.6.git;a=commit;h=c891ca193fa2449945c3ba00cd125b5f50c0337d

It should apply on top of your tree with the ACPICA branch removed, rebased
on top of the Linus' tree and reapplied (including
https://patchwork.kernel.org/patch/449211/ instead of the original).

In case it doesn't, I can post my version of the ACPICA branch (rebased on top
of the Linus' tree and with a couple of fixes), so please let me know.

Thanks,
Rafael

---
 drivers/acpi/acpica/aclocal.h  |    7 ++
 drivers/acpi/acpica/evevent.c  |    3 -
 drivers/acpi/acpica/evgpe.c    |   37 ++++++++++++++
 drivers/acpi/acpica/evxfevnt.c |   33 ++++++++++++
 drivers/acpi/acpica/evxfgpe.c  |   44 ++++++++++++++++-
 drivers/acpi/scan.c            |    2 
 drivers/acpi/sysfs.c           |  105 +++++++++++++++--------------------------
 include/acpi/acpiosxf.h        |    3 -
 include/acpi/acpixf.h          |   14 ++++-
 9 files changed, 173 insertions(+), 75 deletions(-)

Index: linux-2.6/drivers/acpi/acpica/aclocal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
+++ linux-2.6/drivers/acpi/acpica/aclocal.h
@@ -406,6 +406,11 @@ struct acpi_predefined_data {
  *
  ****************************************************************************/
 
+/* Event statistics. */
+struct acpi_event_stats {
+	u32 count;
+};
+
 /* Dispatch info for each GPE -- either a method or handler, cannot be both */
 
 struct acpi_gpe_handler_info {
@@ -432,6 +437,7 @@ struct acpi_gpe_event_info {
 	u8 flags;		/* Misc info about this GPE */
 	u8 gpe_number;		/* This GPE */
 	u8 runtime_count;	/* References to a run GPE */
+	struct acpi_event_stats stats;	/* GPE event statistics */
 };
 
 /* Information about a GPE register pair, one per each status/enable pair in an array */
@@ -501,6 +507,7 @@ struct acpi_fixed_event_info {
 	u8 enable_register_id;
 	u16 status_bit_mask;
 	u16 enable_bit_mask;
+	struct acpi_event_stats stats;	/* Fixed event statistics */
 };
 
 /* Information used during field processing */
Index: linux-2.6/drivers/acpi/acpica/evgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
+++ linux-2.6/drivers/acpi/acpica/evgpe.c
@@ -638,6 +638,7 @@ acpi_status acpi_ev_finish_gpe(struct ac
  *              This function executes at interrupt level.
  *
  ******************************************************************************/
+static struct acpi_event_stats acpi_ev_gpe_stats;
 
 u32
 acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
@@ -648,7 +649,8 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
 
 	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
 
-	acpi_os_gpe_count(gpe_number);
+	gpe_event_info->stats.count++;
+	acpi_ev_gpe_stats.count++;
 
 	/*
 	 * If edge-triggered, clear the GPE status bit now. Note that
@@ -739,3 +741,36 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
 
 	return_UINT32(ACPI_INTERRUPT_HANDLED);
 }
+
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_total_gpe_stats_count
+ *
+ * PARAMETERS:  None
+ *
+ * RETURN:      Current value of the total GPE events counter.
+ *
+ * DESCRIPTION: Return the counted number of GPE events.
+ *
+ ******************************************************************************/
+u32 acpi_total_gpe_stats_count(void)
+{
+	return acpi_ev_gpe_stats.count;
+}
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_total_gpe_stats_count
+ *
+ * PARAMETERS:  gpe_device      - New value of the total GPE events counter.
+ *
+ * RETURN:      None
+ *
+ * DESCRIPTION: Set the total GPE events counter to the given value.
+ *
+ ******************************************************************************/
+void acpi_set_total_gpe_stats_count(u32 count)
+{
+	acpi_ev_gpe_stats.count = count;
+}
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h
+++ linux-2.6/include/acpi/acpixf.h
@@ -283,7 +283,10 @@ acpi_status acpi_disable_event(u32 event
 
 acpi_status acpi_clear_event(u32 event);
 
-acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
+acpi_status acpi_get_event_status(u32 event,
+				  acpi_event_status *event_status, u32 *count);
+
+acpi_status acpi_set_event_stats_count(u32 event, u32 count);
 
 /*
  * GPE Interfaces
@@ -302,7 +305,10 @@ acpi_status acpi_set_gpe_wake_mask(acpi_
 
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
-		    u32 gpe_number, acpi_event_status *event_status);
+		    u32 gpe_number, acpi_event_status *event_status, u32 *count);
+
+acpi_status acpi_set_gpe_stats_count(acpi_handle gpe_device, u32 gpe_number,
+				     u32 count);
 
 acpi_status acpi_disable_all_gpes(void);
 
@@ -319,6 +325,10 @@ acpi_status acpi_remove_gpe_block(acpi_h
 
 acpi_status acpi_update_all_gpes(void);
 
+u32 acpi_total_gpe_stats_count(void);
+
+void acpi_set_total_gpe_stats_count(u32 count);
+
 /*
  * Resource interfaces
  */
Index: linux-2.6/drivers/acpi/sysfs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sysfs.c
+++ linux-2.6/drivers/acpi/sysfs.c
@@ -406,11 +406,9 @@ struct event_counter {
 	u32 flags;
 };
 
-static struct event_counter *all_counters;
 static u32 num_gpes;
 static u32 num_counters;
 static struct attribute **all_attrs;
-static u32 acpi_gpe_count;
 
 static struct attribute_group interrupt_stats_attr_group = {
 	.name = "interrupts",
@@ -420,11 +418,6 @@ static struct kobj_attribute *counter_at
 
 static void delete_gpe_attr_array(void)
 {
-	struct event_counter *tmp = all_counters;
-
-	all_counters = NULL;
-	kfree(tmp);
-
 	if (counter_attrs) {
 		int i;
 
@@ -438,37 +431,7 @@ static void delete_gpe_attr_array(void)
 	return;
 }
 
-void acpi_os_gpe_count(u32 gpe_number)
-{
-	acpi_gpe_count++;
-
-	if (!all_counters)
-		return;
-
-	if (gpe_number < num_gpes)
-		all_counters[gpe_number].count++;
-	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
-			     COUNT_ERROR].count++;
-
-	return;
-}
-
-void acpi_os_fixed_event_count(u32 event_number)
-{
-	if (!all_counters)
-		return;
-
-	if (event_number < ACPI_NUM_FIXED_EVENTS)
-		all_counters[num_gpes + event_number].count++;
-	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
-			     COUNT_ERROR].count++;
-
-	return;
-}
-
-static int get_status(u32 index, acpi_event_status *status,
+static int get_status(u32 index, acpi_event_status *status, u32 *count,
 		      acpi_handle *handle)
 {
 	int result = 0;
@@ -483,9 +446,9 @@ static int get_status(u32 index, acpi_ev
 					"Invalid GPE 0x%x\n", index));
 			goto end;
 		}
-		result = acpi_get_gpe_status(*handle, index, status);
+		result = acpi_get_gpe_status(*handle, index, status, count);
 	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
-		result = acpi_get_event_status(index - num_gpes, status);
+		result = acpi_get_event_status(index - num_gpes, status, count);
 
 end:
 	return result;
@@ -495,27 +458,38 @@ static ssize_t counter_show(struct kobje
 			    struct kobj_attribute *attr, char *buf)
 {
 	int index = attr - counter_attrs;
-	int size;
+	int size = 0;
 	acpi_handle handle;
 	acpi_event_status status;
+	u32 count;
 	int result = 0;
 
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
-	    acpi_irq_handled;
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT].count =
-	    acpi_irq_not_handled;
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
-	    acpi_gpe_count;
-	size = sprintf(buf, "%8d", all_counters[index].count);
-
 	/* "gpe_all" or "sci" */
-	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
+	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS) {
+		index -= num_gpes + ACPI_NUM_FIXED_EVENTS;
+		switch (index) {
+		case COUNT_GPE:
+			count = acpi_total_gpe_stats_count();
+			break;
+		case COUNT_SCI:
+			count = acpi_irq_handled;
+			break;
+		case COUNT_SCI_NOT:
+			count = acpi_irq_not_handled;
+			break;
+		default:
+			goto end;
+		}
+		size = sprintf(buf, "%8d", count);
 		goto end;
+	}
 
-	result = get_status(index, &status, &handle);
+	result = get_status(index, &status, &count, &handle);
 	if (result)
 		goto end;
 
+	size = sprintf(buf, "%8d", count);
+
 	if (!(status & ACPI_EVENT_FLAG_HANDLE))
 		size += sprintf(buf + size, "   invalid");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
@@ -541,21 +515,26 @@ static ssize_t counter_set(struct kobjec
 {
 	int index = attr - counter_attrs;
 	acpi_event_status status;
+	u32 count;
 	acpi_handle handle;
 	int result = 0;
 
 	if (index == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI) {
 		int i;
-		for (i = 0; i < num_counters; ++i)
-			all_counters[i].count = 0;
-		acpi_gpe_count = 0;
+		for (i = 0; i < num_gpes; ++i) {
+			if (!acpi_get_gpe_device(index, &handle))
+				acpi_set_gpe_stats_count(handle, index, 0);
+		}
+		for (i = num_gpes; i < num_gpes + ACPI_NUM_FIXED_EVENTS; ++i)
+			acpi_set_event_stats_count(index, 0);
+		acpi_set_total_gpe_stats_count(0);
 		acpi_irq_handled = 0;
 		acpi_irq_not_handled = 0;
 		goto end;
 	}
 
 	/* show the event status for both GPEs and Fixed Events */
-	result = get_status(index, &status, &handle);
+	result = get_status(index, &status, &count, &handle);
 	if (result)
 		goto end;
 
@@ -576,7 +555,8 @@ static ssize_t counter_set(struct kobjec
 			 (status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_gpe(handle, index);
 		else
-			all_counters[index].count = strtoul(buf, NULL, 0);
+			acpi_set_gpe_stats_count(handle, index,
+						 strtoul(buf, NULL, 0));
 	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
 		int event = index - num_gpes;
 		if (!strcmp(buf, "disable\n") &&
@@ -589,9 +569,9 @@ static ssize_t counter_set(struct kobjec
 			 (status & ACPI_EVENT_FLAG_SET))
 			result = acpi_clear_event(event);
 		else
-			all_counters[index].count = strtoul(buf, NULL, 0);
-	} else
-		all_counters[index].count = strtoul(buf, NULL, 0);
+			acpi_set_event_stats_count(index,
+						   strtoul(buf, NULL, 0));
+	}
 
 	if (ACPI_FAILURE(result))
 		result = -EINVAL;
@@ -603,7 +583,7 @@ void acpi_irq_stats_init(void)
 {
 	int i;
 
-	if (all_counters)
+	if (all_attrs)
 		return;
 
 	num_gpes = acpi_current_gpe_count;
@@ -614,11 +594,6 @@ void acpi_irq_stats_init(void)
 	if (all_attrs == NULL)
 		return;
 
-	all_counters = kzalloc(sizeof(struct event_counter) * (num_counters),
-			       GFP_KERNEL);
-	if (all_counters == NULL)
-		goto fail;
-
 	counter_attrs = kzalloc(sizeof(struct kobj_attribute) * (num_counters),
 				GFP_KERNEL);
 	if (counter_attrs == NULL)
Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
@@ -302,13 +302,15 @@ ACPI_EXPORT_SYMBOL(acpi_clear_event)
  * PARAMETERS:  Event           - The fixed event
  *              event_status    - Where the current status of the event will
  *                                be returned
+ *              count           - Where to store the current event counter value
  *
  * RETURN:      Status
  *
  * DESCRIPTION: Obtains and returns the current status of the event
  *
  ******************************************************************************/
-acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
+acpi_status acpi_get_event_status(u32 event,
+				  acpi_event_status *event_status, u32 *count)
 {
 	acpi_status status = AE_OK;
 	u32 value;
@@ -347,7 +349,36 @@ acpi_status acpi_get_event_status(u32 ev
 	if (acpi_gbl_fixed_event_handlers[event].handler)
 		*event_status |= ACPI_EVENT_FLAG_HANDLE;
 
+	if (count)
+		*count = acpi_gbl_fixed_event_info[event].stats.count;
+
 	return_ACPI_STATUS(status);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_event_status)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_set_event_stats_count
+ *
+ * PARAMETERS:  Event           - The fixed event
+ *              count           - New value of the event counter
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set the event counter of the given fixed event to a new value.
+ *
+ ******************************************************************************/
+acpi_status acpi_set_event_stats_count(u32 event, u32 count)
+{
+	ACPI_FUNCTION_TRACE(acpi_set_event_stats_count);
+
+	if (event > ACPI_EVENT_MAX) {
+		return_ACPI_STATUS(AE_BAD_PARAMETER);
+	}
+
+	acpi_gbl_fixed_event_info[event].stats.count = count;
+
+	return_ACPI_STATUS(AE_OK);
+}
+ACPI_EXPORT_SYMBOL(acpi_set_event_stats_count)
Index: linux-2.6/drivers/acpi/acpica/evxfgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evxfgpe.c
+++ linux-2.6/drivers/acpi/acpica/evxfgpe.c
@@ -372,6 +372,7 @@ ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
  *              gpe_number      - GPE level within the GPE block
  *              event_status    - Where the current status of the event will
  *                                be returned
+ *              count           - Where to store the current event counter value
  *
  * RETURN:      Status
  *
@@ -380,7 +381,7 @@ ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
  ******************************************************************************/
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
-		    u32 gpe_number, acpi_event_status *event_status)
+		    u32 gpe_number, acpi_event_status *event_status, u32 *count)
 {
 	acpi_status status = AE_OK;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -405,6 +406,9 @@ acpi_get_gpe_status(acpi_handle gpe_devi
 	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
 		*event_status |= ACPI_EVENT_FLAG_HANDLE;
 
+	if (count)
+		*count = gpe_event_info->stats.count;
+
       unlock_and_exit:
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
@@ -412,6 +416,44 @@ acpi_get_gpe_status(acpi_handle gpe_devi
 
 ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
 
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_set_gpe_stats_count
+ *
+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number      - GPE level within the GPE block
+ *              count           - New value of the event counter
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Set the event counter of the given GPE to a new value.
+ *
+ ******************************************************************************/
+acpi_status acpi_set_gpe_stats_count(acpi_handle gpe_device, u32 gpe_number,
+				       u32 count)
+{
+	struct acpi_gpe_event_info *gpe_event_info;
+	acpi_cpu_flags flags;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE(acpi_set_gpe_stats_count);
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	/* Ensure that we have a valid GPE number */
+
+	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
+	if (gpe_event_info) {
+		gpe_event_info->stats.count = count;
+	} else {
+		status = AE_BAD_PARAMETER;
+	}
+
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+	return_ACPI_STATUS(status);
+}
+ACPI_EXPORT_SYMBOL(acpi_set_gpe_stats_count)
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_disable_all_gpes
Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -809,7 +809,7 @@ static void acpi_bus_set_run_wake_flags(
 
 	status = acpi_get_gpe_status(device->wakeup.gpe_device,
 					device->wakeup.gpe_number,
-						&event_status);
+						&event_status, NULL);
 	if (status == AE_OK)
 		device->wakeup.flags.run_wake =
 				!!(event_status & ACPI_EVENT_FLAG_HANDLE);
Index: linux-2.6/drivers/acpi/acpica/evevent.c
===================================================================
--- linux-2.6.orig/drivers/acpi/acpica/evevent.c
+++ linux-2.6/drivers/acpi/acpica/evevent.c
@@ -219,7 +219,6 @@ u32 acpi_ev_fixed_event_detect(void)
 			enable_bit_mask)) {
 
 			/* Found an active (signalled) event */
-			acpi_os_fixed_event_count(i);
 			int_status |= acpi_ev_fixed_event_dispatch(i);
 		}
 	}
@@ -245,6 +244,8 @@ static u32 acpi_ev_fixed_event_dispatch(
 
 	ACPI_FUNCTION_ENTRY();
 
+	acpi_gbl_fixed_event_info[event].stats.count++;
+
 	/* Clear the status bit */
 
 	(void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
Index: linux-2.6/include/acpi/acpiosxf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpiosxf.h
+++ linux-2.6/include/acpi/acpiosxf.h
@@ -177,9 +177,6 @@ acpi_os_install_interrupt_handler(u32 gs
 acpi_status
 acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler service_routine);
 
-void acpi_os_gpe_count(u32 gpe_number);
-void acpi_os_fixed_event_count(u32 fixed_event_number);
-
 /*
  * Threads and Scheduling
  */
