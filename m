From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 1/2] ACPI: allow enable/disable/clear ACPI interrupts
	in user space
Date: Fri, 20 Jun 2008 09:42:47 +0800
Message-ID: <1213926167.3001.9.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42284 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbYFTBmF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 19 Jun 2008 21:42:05 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

From: Zhang Rui <rui.zhang@intel.com>

Allow users to enable/disable/clear a specific & valid GPE/Fixed Event in user space.

Note: This is useful for debugging, especially for some interrupt storm issues.

Note: All wakeup GPEs are disabled and they can not be enabled at runtime, and we mark them as invalid.
      All GPEs that don't have a _Lxx/_Exx method are marked as invalid.
      All Fixed Events that don't have an event handler are marked as invalid and they can't be enabled
      until an event handler is registered.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ling Ming <ming.m.lin@intel.com>
---
 Documentation/ABI/testing/sysfs-firmware-acpi |  127 +++++++++++++------
 drivers/acpi/events/evxfevnt.c                |   18 ++
 drivers/acpi/hardware/hwgpe.c                 |    2 
 drivers/acpi/system.c                         |  169 ++++++++++++++++++++++++--
 include/acpi/achware.h                        |    2 
 include/acpi/acpixf.h                         |    4 
 6 files changed, 258 insertions(+), 64 deletions(-)

Index: linux-2.6/drivers/acpi/system.c
===================================================================
--- linux-2.6.orig/drivers/acpi/system.c	2008-06-20 08:55:38.000000000 +0800
+++ linux-2.6/drivers/acpi/system.c	2008-06-20 09:27:00.000000000 +0800
@@ -167,7 +167,13 @@
 #define COUNT_ERROR 2	/* other */
 #define NUM_COUNTERS_EXTRA 3
 
-static u32 *all_counters;
+#define ACPI_EVENT_VALID	0x01
+struct event_counter {
+	u32 count;
+	u32 flags;
+};
+
+static struct event_counter *all_counters;
 static u32 num_gpes;
 static u32 num_counters;
 static struct attribute **all_attrs;
@@ -202,9 +208,44 @@
 	return count;
 }
 
+static int get_gpe_device(int index, acpi_handle *handle)
+{
+	struct acpi_gpe_xrupt_info *gpe_xrupt_info;
+	struct acpi_gpe_block_info *gpe_block;
+	acpi_cpu_flags flags;
+	struct acpi_namespace_node *node;
+
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
+
+	gpe_xrupt_info = acpi_gbl_gpe_xrupt_list_head;
+	while (gpe_xrupt_info) {
+		gpe_block = gpe_xrupt_info->gpe_block_list_head;
+		node = gpe_block->node;
+		while (gpe_block) {
+			index -= gpe_block->register_count *
+			    ACPI_GPE_REGISTER_WIDTH;
+			if (index < 0) {
+				acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+				/* return NULL if it's FADT GPE */
+				if (node->type != ACPI_TYPE_DEVICE)
+					*handle = NULL;
+				else
+					*handle = node;
+				return 0;
+			}
+			node = gpe_block->node;
+			gpe_block = gpe_block->next;
+		}
+		gpe_xrupt_info = gpe_xrupt_info->next;
+	}
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
+
+	return -ENODEV;
+}
+
 static void delete_gpe_attr_array(void)
 {
-	u32 *tmp = all_counters;
+	struct event_counter *tmp = all_counters;
 
 	all_counters = NULL;
 	kfree(tmp);
@@ -230,9 +271,10 @@
 		return;
 
 	if (gpe_number < num_gpes)
-		all_counters[gpe_number]++;
+		all_counters[gpe_number].count++;
 	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR]++;
+		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
+					count++;
 
 	return;
 }
@@ -243,44 +285,144 @@
 		return;
 
 	if (event_number < ACPI_NUM_FIXED_EVENTS)
-		all_counters[num_gpes + event_number]++;
+		all_counters[num_gpes + event_number].count++;
 	else
-		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR]++;
+		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
+				count++;
 
 	return;
 }
 
+static int get_status(u32 index, acpi_event_status *status, acpi_handle *handle)
+{
+	int result = 0;
+
+	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
+		goto end;
+
+	if (index < num_gpes) {
+		result = get_gpe_device(index, handle);
+		if (result) {
+			ACPI_EXCEPTION((AE_INFO, AE_NOT_FOUND,
+				"Invalid GPE 0x%x\n", index));
+			goto end;
+		}
+		result = acpi_get_gpe_status(*handle, index,
+						ACPI_NOT_ISR, status);
+	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
+		result = acpi_get_event_status(index - num_gpes, status);
+
+	/*
+	 * sleep/power button GPE/Fixed Event is enabled after acpi_system_init,
+	 * check the status at runtime and mark it as valid once it's enabled
+	 */
+	if (!result && (*status & ACPI_EVENT_FLAG_ENABLED))
+		all_counters[index].flags |= ACPI_EVENT_VALID;
+end:
+	return result;
+}
+
 static ssize_t counter_show(struct kobject *kobj,
 	struct kobj_attribute *attr, char *buf)
 {
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI] =
+	int index = attr - counter_attrs;
+	int size;
+	acpi_handle handle;
+	acpi_event_status status;
+	int result = 0;
+
+	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
 		acpi_irq_handled;
-	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE] =
+	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
 		acpi_gpe_count;
 
-	return sprintf(buf, "%d\n", all_counters[attr - counter_attrs]);
+	size = sprintf(buf, "%8d", all_counters[index].count);
+
+	/* "gpe_all" or "sci" */
+	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
+		goto end;
+
+	result = get_status(index, &status, &handle);
+	if (result)
+		goto end;
+
+	if (!(all_counters[index].flags & ACPI_EVENT_VALID))
+		size += sprintf(buf + size, "  invalid");
+	else if (status & ACPI_EVENT_FLAG_ENABLED)
+		size += sprintf(buf + size, "   enable");
+	else
+		size += sprintf(buf + size, "  disable");
+
+end:
+	size += sprintf(buf + size, "\n");
+	return result ? result : size;
 }
 
 /*
  * counter_set() sets the specified counter.
  * setting the total "sci" file to any value clears all counters.
+ * enable/disable/clear a gpe/fixed event in user space.
  */
 static ssize_t counter_set(struct kobject *kobj,
 	struct kobj_attribute *attr, const char *buf, size_t size)
 {
 	int index = attr - counter_attrs;
+	acpi_event_status status;
+	acpi_handle handle;
+	int result = 0;
 
 	if (index == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI) {
 		int i;
 		for (i = 0; i < num_counters; ++i)
-			all_counters[i] = 0;
+			all_counters[i].count = 0;
 		acpi_gpe_count = 0;
 		acpi_irq_handled = 0;
+		goto end;
+	}
 
+	/* show the event status for both GPEs and Fixed Events */
+	result = get_status(index, &status, &handle);
+	if (result)
+		goto end;
+
+	if (!(all_counters[index].flags & ACPI_EVENT_VALID)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
+			"Can not change Invalid GPE/Fixed Event status\n"));
+		return -EINVAL;
+	}
+
+	if (index < num_gpes) {
+		if (!strcmp(buf, "disable\n") &&
+				(status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_disable_gpe(handle, index, ACPI_NOT_ISR);
+		else if (!strcmp(buf, "enable\n") &&
+				!(status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_enable_gpe(handle, index,	ACPI_NOT_ISR);
+		else if (!strcmp(buf, "clear\n") &&
+				(status & ACPI_EVENT_FLAG_SET))
+			result = acpi_clear_gpe(handle, index, ACPI_NOT_ISR);
+		else
+			all_counters[index].count = strtoul(buf, NULL, 0);
+	} else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
+		int event = index - num_gpes;
+		if (!strcmp(buf, "disable\n") &&
+				(status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_disable_event(event, ACPI_NOT_ISR);
+		else if (!strcmp(buf, "enable\n") &&
+				!(status & ACPI_EVENT_FLAG_ENABLED))
+			result = acpi_enable_event(event, ACPI_NOT_ISR);
+		else if (!strcmp(buf, "clear\n") &&
+				(status & ACPI_EVENT_FLAG_SET))
+			result = acpi_clear_event(event);
+		else
+			all_counters[index].count = strtoul(buf, NULL, 0);
 	} else
-		all_counters[index] = strtoul(buf, NULL, 0);
+		all_counters[index].count = strtoul(buf, NULL, 0);
 
-	return size;
+	if (ACPI_FAILURE(result))
+		result = -EINVAL;
+end:
+	return result ? result : size;
 }
 
 void acpi_irq_stats_init(void)
@@ -298,7 +440,8 @@
 	if (all_attrs == NULL)
 		return;
 
-	all_counters = kzalloc(sizeof(u32) * (num_counters), GFP_KERNEL);
+	all_counters = kzalloc(sizeof(struct event_counter) * (num_counters),
+				GFP_KERNEL);
 	if (all_counters == NULL)
 		goto fail;
 
Index: linux-2.6/Documentation/ABI/testing/sysfs-firmware-acpi
===================================================================
--- linux-2.6.orig/Documentation/ABI/testing/sysfs-firmware-acpi	2008-06-20 08:55:38.000000000 +0800
+++ linux-2.6/Documentation/ABI/testing/sysfs-firmware-acpi	2008-06-20 09:33:35.000000000 +0800
@@ -29,46 +29,46 @@
 
 		$ cd /sys/firmware/acpi/interrupts
 		$ grep . *
-		error:0
-		ff_gbl_lock:0
-		ff_pmtimer:0
-		ff_pwr_btn:0
-		ff_rt_clk:0
-		ff_slp_btn:0
-		gpe00:0
-		gpe01:0
-		gpe02:0
-		gpe03:0
-		gpe04:0
-		gpe05:0
-		gpe06:0
-		gpe07:0
-		gpe08:0
-		gpe09:174
-		gpe0A:0
-		gpe0B:0
-		gpe0C:0
-		gpe0D:0
-		gpe0E:0
-		gpe0F:0
-		gpe10:0
-		gpe11:60
-		gpe12:0
-		gpe13:0
-		gpe14:0
-		gpe15:0
-		gpe16:0
-		gpe17:0
-		gpe18:0
-		gpe19:7
-		gpe1A:0
-		gpe1B:0
-		gpe1C:0
-		gpe1D:0
-		gpe1E:0
-		gpe1F:0
-		gpe_all:241
-		sci:241
+		error:       0
+		ff_gbl_lock:       0   enable
+		ff_pmtimer:       0  invalid
+		ff_pwr_btn:       0   enable
+		ff_rt_clk:       2  disable
+		ff_slp_btn:       0  invalid
+		gpe00:       0  invalid
+		gpe01:       0   enable
+		gpe02:     108   enable
+		gpe03:       0  invalid
+		gpe04:       0  invalid
+		gpe05:       0  invalid
+		gpe06:       0   enable
+		gpe07:       0   enable
+		gpe08:       0  invalid
+		gpe09:       0  invalid
+		gpe0A:       0  invalid
+		gpe0B:       0  invalid
+		gpe0C:       0  invalid
+		gpe0D:       0  invalid
+		gpe0E:       0  invalid
+		gpe0F:       0  invalid
+		gpe10:       0  invalid
+		gpe11:       0  invalid
+		gpe12:       0  invalid
+		gpe13:       0  invalid
+		gpe14:       0  invalid
+		gpe15:       0  invalid
+		gpe16:       0  invalid
+		gpe17:    1084   enable
+		gpe18:       0   enable
+		gpe19:       0  invalid
+		gpe1A:       0  invalid
+		gpe1B:       0  invalid
+		gpe1C:       0  invalid
+		gpe1D:       0  invalid
+		gpe1E:       0  invalid
+		gpe1F:       0  invalid
+		gpe_all:    1192
+		sci:    1194
 
 		sci - The total number of times the ACPI SCI
 		has claimed an interrupt.
@@ -89,6 +89,13 @@
 
 		error - an interrupt that can't be accounted for above.
 
+		invalid: it's either a wakeup GPE or a GPE/Fixed Event that
+			doesn't have an event handler.
+
+		disable: the GPE/Fixed Event is valid but disabled.
+
+		enable: the GPE/Fixed Event is valid and enabled.
+
 		Root has permission to clear any of these counters.  Eg.
 		# echo 0 > gpe11
 
@@ -97,3 +104,43 @@
 
 		None of these counters has an effect on the function
 		of the system, they are simply statistics.
+
+		Besides this, user can also write specific strings to these files
+		to enable/disable/clear ACPI interrupts in user space, which can be
+		used to	debug some ACPI interrupt storm issues.
+
+		Note that only writting to VALID GPE/Fixed Event is allowed,
+		i.e. user can only change the status of runtime GPE and
+		Fixed Event with event handler installed.
+
+		Let's take power button fixed event for example, please kill acpid
+		and other user space applications so that the machine won't shutdown
+		when pressing the power button.
+		# cat ff_pwr_btn
+		0
+		# press the power button for 3 times;
+		# cat ff_pwr_btn
+		3
+		# echo disable > ff_pwr_btn
+		# cat ff_pwr_btn
+		disable
+		# press the power button for 3 times;
+		# cat ff_pwr_btn
+		disable
+		# echo enable > ff_pwr_btn
+		# cat ff_pwr_btn
+		4
+		/*
+		 * this is because the status bit is set even if the enable bit is cleared,
+		 * and it triggers an ACPI fixed event when the enable bit is set again
+		 */
+		# press the power button for 3 times;
+		# cat ff_pwr_btn
+		7
+		# echo disable > ff_pwr_btn
+		# press the power button for 3 times;
+		# echo clear > ff_pwr_btn	/* clear the status bit */
+		# echo disable > ff_pwr_btn
+		# cat ff_pwr_btn
+		7
+
Index: linux-2.6/drivers/acpi/events/evxfevnt.c
===================================================================
--- linux-2.6.orig/drivers/acpi/events/evxfevnt.c	2008-06-20 08:55:38.000000000 +0800
+++ linux-2.6/drivers/acpi/events/evxfevnt.c	2008-06-20 08:57:52.000000000 +0800
@@ -472,7 +472,6 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
-#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_event_status
@@ -489,6 +488,7 @@
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status)
 {
 	acpi_status status = AE_OK;
+	u32 value;
 
 	ACPI_FUNCTION_TRACE(acpi_get_event_status);
 
@@ -506,7 +506,20 @@
 
 	status =
 	    acpi_get_register(acpi_gbl_fixed_event_info[event].
-			      status_register_id, event_status);
+			      enable_register_id, &value);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	*event_status = value;
+
+	status =
+	    acpi_get_register(acpi_gbl_fixed_event_info[event].
+			      status_register_id, &value);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
+
+	if (value)
+		*event_status |= ACPI_EVENT_FLAG_SET;
 
 	return_ACPI_STATUS(status);
 }
@@ -566,7 +579,6 @@
 }
 
 ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
-#endif				/*  ACPI_FUTURE_USAGE  */
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_gpe_block
Index: linux-2.6/drivers/acpi/hardware/hwgpe.c
===================================================================
--- linux-2.6.orig/drivers/acpi/hardware/hwgpe.c	2008-06-20 08:55:38.000000000 +0800
+++ linux-2.6/drivers/acpi/hardware/hwgpe.c	2008-06-20 08:57:52.000000000 +0800
@@ -138,7 +138,6 @@
  *
  ******************************************************************************/
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 		       acpi_event_status * event_status)
@@ -198,7 +197,6 @@
       unlock_and_exit:
 	return (status);
 }
-#endif				/*  ACPI_FUTURE_USAGE  */
 
 /******************************************************************************
  *
Index: linux-2.6/include/acpi/achware.h
===================================================================
--- linux-2.6.orig/include/acpi/achware.h	2008-06-20 08:55:38.000000000 +0800
+++ linux-2.6/include/acpi/achware.h	2008-06-20 08:57:52.000000000 +0800
@@ -100,11 +100,9 @@
 acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			struct acpi_gpe_block_info *gpe_block);
 
-#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status * event_status);
-#endif				/* ACPI_FUTURE_USAGE */
 
 acpi_status acpi_hw_disable_all_gpes(void);
 
Index: linux-2.6/include/acpi/acpixf.h
===================================================================
--- linux-2.6.orig/include/acpi/acpixf.h	2008-06-20 08:55:38.000000000 +0800
+++ linux-2.6/include/acpi/acpixf.h	2008-06-20 08:57:52.000000000 +0800
@@ -248,9 +248,7 @@
 
 acpi_status acpi_clear_event(u32 event);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
-#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
@@ -260,12 +258,10 @@
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags);
 
-#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number,
 		    u32 flags, acpi_event_status * event_status);
-#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_install_gpe_block(acpi_handle gpe_device,


