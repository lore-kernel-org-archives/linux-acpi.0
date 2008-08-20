From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc3] acpi: improve /sys/firmware/acpi/interrupts/*
Date: Wed, 20 Aug 2008 12:49:44 -0700
Message-ID: <200808201249.44433.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:24918 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754290AbYHTTtq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2008 15:49:46 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Introduce a new flag showing whether an event has a handler/method.

For all the GPEs and Fixed Events,
 1. ACPI_EVENT_FLAG_HANDLE is cleared, it's an "invalid" ACPI event.
 2. Both ACPI_EVENT_FLAG_HANDLE and ACPI_EVENT_FLAG_DISABLE are set,
    it's "disabled".
 3. Both ACPI_EVENT_FLAG_HANDLE and ACPI_EVENT_FLAG_ENABLE are set,
    it's "enabled".
 4. Both ACPI_EVENT_FLAG_HANDLE and ACPI_EVENT_FLAG_WAKE_ENABLE are set,
    it's "wake_enabled".

Among other things, this prevents incorrect reporting of ACPI events
as being "invalid" when it's really just (temporarily) "disabled".

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
attachment #7 from http://bugzilla.kernel.org/show_bug.cgi?id=11312

It still seems odd to have separate enable/disable flags.  Also, to
treat enable-for-wake as different from normal enable (rather than
just a variant of "enabled").  But this is at least more sensible.

 Documentation/ABI/testing/sysfs-firmware-acpi |   16 ++++++++--------
 drivers/acpi/events/evxfevnt.c                |    6 ++++++
 drivers/acpi/system.c                         |   19 +++++++------------
 include/acpi/actypes.h                        |    1 +
 4 files changed, 22 insertions(+), 20 deletions(-)

--- a/Documentation/ABI/testing/sysfs-firmware-acpi	2008-07-24 18:27:42.000000000 -0700
+++ b/Documentation/ABI/testing/sysfs-firmware-acpi	2008-08-13 01:44:16.000000000 -0700
@@ -89,7 +89,7 @@ Description:
 
 		error - an interrupt that can't be accounted for above.
 
-		invalid: it's either a wakeup GPE or a GPE/Fixed Event that
+		invalid: it's either a GPE or a Fixed Event that
 			doesn't have an event handler.
 
 		disable: the GPE/Fixed Event is valid but disabled.
@@ -117,30 +117,30 @@ Description:
 		and other user space applications so that the machine won't shutdown
 		when pressing the power button.
 		# cat ff_pwr_btn
-		0
+		0	enabled
 		# press the power button for 3 times;
 		# cat ff_pwr_btn
-		3
+		3	enabled
 		# echo disable > ff_pwr_btn
 		# cat ff_pwr_btn
-		disable
+		3	disabled
 		# press the power button for 3 times;
 		# cat ff_pwr_btn
-		disable
+		3	disabled
 		# echo enable > ff_pwr_btn
 		# cat ff_pwr_btn
-		4
+		4	enabled
 		/*
 		 * this is because the status bit is set even if the enable bit is cleared,
 		 * and it triggers an ACPI fixed event when the enable bit is set again
 		 */
 		# press the power button for 3 times;
 		# cat ff_pwr_btn
-		7
+		7	enabled
 		# echo disable > ff_pwr_btn
 		# press the power button for 3 times;
 		# echo clear > ff_pwr_btn	/* clear the status bit */
 		# echo disable > ff_pwr_btn
 		# cat ff_pwr_btn
-		7
+		7	enabled
 
--- a/drivers/acpi/events/evxfevnt.c	2008-07-24 18:27:43.000000000 -0700
+++ b/drivers/acpi/events/evxfevnt.c	2008-08-13 01:44:16.000000000 -0700
@@ -521,6 +521,9 @@ acpi_status acpi_get_event_status(u32 ev
 	if (value)
 		*event_status |= ACPI_EVENT_FLAG_SET;
 
+	if (acpi_gbl_fixed_event_handlers[event].handler)
+		*event_status |= ACPI_EVENT_FLAG_HANDLE;
+
 	return_ACPI_STATUS(status);
 }
 
@@ -571,6 +574,9 @@ acpi_get_gpe_status(acpi_handle gpe_devi
 
 	status = acpi_hw_get_gpe_status(gpe_event_info, event_status);
 
+	if (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
+		*event_status |= ACPI_EVENT_FLAG_HANDLE;
+
       unlock_and_exit:
 	if (flags & ACPI_NOT_ISR) {
 		(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
--- a/drivers/acpi/system.c	2008-07-24 18:27:43.000000000 -0700
+++ b/drivers/acpi/system.c	2008-08-13 01:44:16.000000000 -0700
@@ -168,7 +168,6 @@ static int acpi_system_sysfs_init(void)
 #define COUNT_ERROR 2	/* other */
 #define NUM_COUNTERS_EXTRA 3
 
-#define ACPI_EVENT_VALID	0x01
 struct event_counter {
 	u32 count;
 	u32 flags;
@@ -313,12 +312,6 @@ static int get_status(u32 index, acpi_ev
 	} else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
 		result = acpi_get_event_status(index - num_gpes, status);
 
-	/*
-	 * sleep/power button GPE/Fixed Event is enabled after acpi_system_init,
-	 * check the status at runtime and mark it as valid once it's enabled
-	 */
-	if (!result && (*status & ACPI_EVENT_FLAG_ENABLED))
-		all_counters[index].flags |= ACPI_EVENT_VALID;
 end:
 	return result;
 }
@@ -347,12 +340,14 @@ static ssize_t counter_show(struct kobje
 	if (result)
 		goto end;
 
-	if (!(all_counters[index].flags & ACPI_EVENT_VALID))
-		size += sprintf(buf + size, "  invalid");
+	if (!(status & ACPI_EVENT_FLAG_HANDLE))
+		size += sprintf(buf + size, "	invalid");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
-		size += sprintf(buf + size, "	enable");
+		size += sprintf(buf + size, "	enabled");
+	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
+		size += sprintf(buf + size, "	wake_enabled");
 	else
-		size += sprintf(buf + size, "  disable");
+		size += sprintf(buf + size, "	disabled");
 
 end:
 	size += sprintf(buf + size, "\n");
@@ -386,7 +381,7 @@ static ssize_t counter_set(struct kobjec
 	if (result)
 		goto end;
 
-	if (!(all_counters[index].flags & ACPI_EVENT_VALID)) {
+	if (!(status & ACPI_EVENT_FLAG_HANDLE)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_WARN,
 			"Can not change Invalid GPE/Fixed Event status\n"));
 		return -EINVAL;
--- a/include/acpi/actypes.h	2008-07-24 18:27:53.000000000 -0700
+++ b/include/acpi/actypes.h	2008-08-13 01:44:16.000000000 -0700
@@ -525,6 +525,7 @@ typedef u32 acpi_event_status;
 #define ACPI_EVENT_FLAG_ENABLED         (acpi_event_status) 0x01
 #define ACPI_EVENT_FLAG_WAKE_ENABLED    (acpi_event_status) 0x02
 #define ACPI_EVENT_FLAG_SET             (acpi_event_status) 0x04
+#define ACPI_EVENT_FLAG_HANDLE          (acpi_event_status) 0x08
 
 /*
  * General Purpose Events (GPE)
