From: len.brown@intel.com (Len Brown)
Subject: Linux/ACPI vs ACPICA audit -- 20060210
Date: Fri, 10 Feb 2006 20:08:09 -0500
Message-ID: <43ED38F9.nail8ZD110H7S@se7525gp2.hsd1.ma.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr15.intel.com ([192.55.52.69]:49325 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751218AbWBKBIM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Feb 2006 20:08:12 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr005.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k1B18BXt025634
	for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2006 01:08:11 GMT
Received: from fmssmxvs041.fm.intel.com (fmssmxvs041.fm.intel.com [132.233.42.126])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k1B18BHx011519
	for <linux-acpi@vger.kernel.org>; Sat, 11 Feb 2006 01:08:11 GMT
Received: from se7525gp2.hsd1.ma.comcast.net ([10.127.57.55])
 by fmssmxvs041.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006021017080909824
 for <linux-acpi@vger.kernel.org>; Fri, 10 Feb 2006 17:08:09 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

For the files that Linux gets from ACPICA, this diff shows how Linux
has diverged from upstream.

acpica-unix-20060210.audit.diff:# 43 files changed, 297 insertions(+), 67 deletions(-)
acpica-unix-20060127.audit.diff:# 44 files changed, 297 insertions(+), 71 deletions(-)
acpica-unix-20051216.audit.diff:# 43 files changed, 295 insertions(+), 55 deletions(-)
acpica-unix-20051202.audit.diff:# 44 files changed, 328 insertions(+), 94 deletions(-)
acpica-unix-20051117.audit.diff:# 44 files changed, 328 insertions(+), 94 deletions(-)

# 142 ACPICA files
# drivers/acpi/dispatcher/dswload.c  |    1 
# drivers/acpi/dispatcher/dswstate.c |    4 +
# drivers/acpi/events/evxface.c      |   60 ++++++++++++++++-
# drivers/acpi/events/evxfevnt.c     |   18 +++++
# drivers/acpi/events/evxfregn.c     |    6 +
# drivers/acpi/executer/excreate.c   |    2 
# drivers/acpi/hardware/hwgpe.c      |    2 
# drivers/acpi/hardware/hwregs.c     |    8 ++
# drivers/acpi/hardware/hwsleep.c    |   29 ++------
# drivers/acpi/hardware/hwtimer.c    |    5 +
# drivers/acpi/namespace/nsdump.c    |    6 +
# drivers/acpi/namespace/nsparse.c   |    2 
# drivers/acpi/namespace/nsxfeval.c  |   14 +++
# drivers/acpi/namespace/nsxfname.c  |    8 ++
# drivers/acpi/namespace/nsxfobj.c   |    8 ++
# drivers/acpi/parser/pstree.c       |    3 
# drivers/acpi/parser/psutils.c      |    4 +
# drivers/acpi/resources/rsinfo.c    |    3 
# drivers/acpi/resources/rsutils.c   |    2 
# drivers/acpi/resources/rsxface.c   |   14 +++
# drivers/acpi/tables/tbconvrt.c     |   13 +++
# drivers/acpi/tables/tbxface.c      |    7 +
# drivers/acpi/tables/tbxfroot.c     |    4 +
# drivers/acpi/utilities/utalloc.c   |   10 +-
# drivers/acpi/utilities/utdebug.c   |   14 +++
# drivers/acpi/utilities/utglobal.c  |   10 +-
# drivers/acpi/utilities/utobject.c  |    2 
# drivers/acpi/utilities/utstate.c   |    1 
# drivers/acpi/utilities/utxface.c   |    7 +
# include/acpi/acdebug.h             |    2 
# include/acpi/acdispat.h            |    2 
# include/acpi/achware.h             |    4 +
# include/acpi/acinterp.h            |    2 
# include/acpi/acmacros.h            |   12 ---
# include/acpi/acnamesp.h            |    4 +
# include/acpi/acparser.h            |    4 +
# include/acpi/acpiosxf.h            |   17 +++-
# include/acpi/acpixf.h              |   24 ++++++
# include/acpi/acresrc.h             |    2 
# include/acpi/actbl.h               |    3 
# include/acpi/acutils.h             |    4 +
# include/acpi/platform/acenv.h      |    4 -
# include/acpi/platform/aclinux.h    |   13 +++
# 43 files changed, 297 insertions(+), 67 deletions(-)

diff -Nau acpica-unix-20060210/drivers/acpi/hardware/hwregs.c linux-acpi-2.6/drivers/acpi/hardware/hwregs.c
--- acpica-unix-20060210/drivers/acpi/hardware/hwregs.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/hardware/hwregs.c	2006-02-10 17:59:08.000000000 -0500
@@ -43,6 +43,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acevents.h>
@@ -218,6 +220,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_sleep_type_data);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_hw_get_register_bit_mask
@@ -308,6 +312,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_register);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_set_register
@@ -469,6 +475,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_set_register);
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_hw_register_read
diff -Nau acpica-unix-20060210/drivers/acpi/hardware/hwsleep.c linux-acpi-2.6/drivers/acpi/hardware/hwsleep.c
--- acpica-unix-20060210/drivers/acpi/hardware/hwsleep.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/hardware/hwsleep.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 #include <acpi/acpi.h>
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -92,6 +93,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector(acpi_physical_address * physical_address)
 {
@@ -116,6 +118,7 @@
 
 	return_ACPI_STATUS(AE_OK);
 }
+#endif
 
 /*******************************************************************************
  *
@@ -216,7 +219,7 @@
  *
  ******************************************************************************/
 
-acpi_status acpi_enter_sleep_state(u8 sleep_state)
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 {
 	u32 PM1Acontrol;
 	u32 PM1Bcontrol;
@@ -254,17 +257,6 @@
 		return_ACPI_STATUS(status);
 	}
 
-	if (sleep_state != ACPI_STATE_S5) {
-
-		/* Disable BM arbitration */
-
-		status = acpi_set_register(ACPI_BITREG_ARB_DISABLE,
-					   1, ACPI_MTX_DO_NOT_LOCK);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-
 	/*
 	 * 1) Disable/Clear all GPEs
 	 * 2) Enable all wakeup GPEs
@@ -386,6 +378,8 @@
 	return_ACPI_STATUS(AE_OK);
 }
 
+EXPORT_SYMBOL(acpi_enter_sleep_state);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state_s4bios
@@ -399,7 +393,7 @@
  *
  ******************************************************************************/
 
-acpi_status acpi_enter_sleep_state_s4bios(void)
+acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void)
 {
 	u32 in_value;
 	acpi_status status;
@@ -449,6 +443,8 @@
 	return_ACPI_STATUS(AE_OK);
 }
 
+EXPORT_SYMBOL(acpi_enter_sleep_state_s4bios);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_leave_sleep_state
@@ -580,13 +576,6 @@
 			      [ACPI_EVENT_POWER_BUTTON].status_register_id, 1,
 			      ACPI_MTX_DO_NOT_LOCK);
 
-	/* Enable BM arbitration */
-
-	status = acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_LOCK);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
 	arg.integer.value = ACPI_SST_WORKING;
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
diff -Nau acpica-unix-20060210/drivers/acpi/hardware/hwtimer.c linux-acpi-2.6/drivers/acpi/hardware/hwtimer.c
--- acpica-unix-20060210/drivers/acpi/hardware/hwtimer.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/hardware/hwtimer.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,7 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
 #include <acpi/acpi.h>
 
 #define _COMPONENT          ACPI_HARDWARE
@@ -102,6 +103,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_timer);
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_get_timer_duration
@@ -180,3 +183,5 @@
 	*time_elapsed = (u32) quotient;
 	return_ACPI_STATUS(status);
 }
+
+EXPORT_SYMBOL(acpi_get_timer_duration);
diff -Nau acpica-unix-20060210/drivers/acpi/hardware/hwgpe.c linux-acpi-2.6/drivers/acpi/hardware/hwgpe.c
--- acpica-unix-20060210/drivers/acpi/hardware/hwgpe.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/hardware/hwgpe.c	2006-02-10 17:59:08.000000000 -0500
@@ -132,6 +132,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info * gpe_event_info,
 		       acpi_event_status * event_status)
@@ -188,6 +189,7 @@
       unlock_and_exit:
 	return (status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /******************************************************************************
  *
diff -Nau acpica-unix-20060210/drivers/acpi/events/evxfevnt.c linux-acpi-2.6/drivers/acpi/events/evxfevnt.c
--- acpica-unix-20060210/drivers/acpi/events/evxfevnt.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/events/evxfevnt.c	2006-02-10 17:59:08.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
@@ -191,6 +193,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_enable_event);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_set_gpe_type
@@ -232,6 +236,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_set_gpe_type);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enable_gpe
@@ -282,6 +288,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_enable_gpe);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_disable_gpe
@@ -384,6 +392,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_disable_event);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_clear_event
@@ -419,6 +429,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_clear_event);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_clear_gpe
@@ -466,6 +478,7 @@
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_event_status
@@ -557,6 +570,7 @@
 	}
 	return_ACPI_STATUS(status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
@@ -652,6 +666,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_install_gpe_block);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_remove_gpe_block
@@ -705,3 +721,5 @@
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
+
+EXPORT_SYMBOL(acpi_remove_gpe_block);
diff -Nau acpica-unix-20060210/drivers/acpi/events/evxface.c linux-acpi-2.6/drivers/acpi/events/evxface.c
--- acpica-unix-20060210/drivers/acpi/events/evxface.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/events/evxface.c	2006-02-10 17:59:08.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acevents.h>
@@ -61,6 +63,7 @@
  * DESCRIPTION: Saves the pointer to the handler function
  *
  ******************************************************************************/
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler)
 {
 	acpi_status status;
@@ -87,6 +90,7 @@
 	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	return_ACPI_STATUS(status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
@@ -135,7 +139,9 @@
 	acpi_gbl_fixed_event_handlers[event].handler = handler;
 	acpi_gbl_fixed_event_handlers[event].context = context;
 
-	status = acpi_enable_event(event, 0);
+	status = acpi_clear_event(event);
+	if (ACPI_SUCCESS(status))
+		status = acpi_enable_event(event, 0);
 	if (ACPI_FAILURE(status)) {
 		ACPI_WARNING((AE_INFO, "Could not enable fixed event %X",
 			      event));
@@ -155,6 +161,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_install_fixed_event_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_remove_fixed_event_handler
@@ -208,6 +216,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_remove_fixed_event_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_notify_handler
@@ -374,6 +384,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_install_notify_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_remove_notify_handler
@@ -436,6 +448,15 @@
 			goto unlock_and_exit;
 		}
 
+		/* Make sure all deferred tasks are completed */
+
+		(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+		acpi_os_wait_events_complete(NULL);
+		status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
 		if (handler_type & ACPI_SYSTEM_NOTIFY) {
 			acpi_gbl_system_notify.node = NULL;
 			acpi_gbl_system_notify.handler = NULL;
@@ -476,9 +497,16 @@
 				status = AE_BAD_PARAMETER;
 				goto unlock_and_exit;
 			}
+			/* Make sure all deferred tasks are completed */
 
-			/* Remove the handler */
+			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+			acpi_os_wait_events_complete(NULL);
+			status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
 
+			/* Remove the handler */
 			obj_desc->common_notify.system_notify = NULL;
 			acpi_ut_remove_reference(notify_obj);
 		}
@@ -490,9 +518,16 @@
 				status = AE_BAD_PARAMETER;
 				goto unlock_and_exit;
 			}
+			/* Make sure all deferred tasks are completed */
 
-			/* Remove the handler */
+			(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
+			acpi_os_wait_events_complete(NULL);
+			status = acpi_ut_acquire_mutex(ACPI_MTX_NAMESPACE);
+			if (ACPI_FAILURE(status)) {
+				return_ACPI_STATUS(status);
+			}
 
+			/* Remove the handler */
 			obj_desc->common_notify.device_notify = NULL;
 			acpi_ut_remove_reference(notify_obj);
 		}
@@ -503,6 +538,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_remove_notify_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_install_gpe_handler
@@ -596,6 +633,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_install_gpe_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_remove_gpe_handler
@@ -663,6 +702,15 @@
 		goto unlock_and_exit;
 	}
 
+	/* Make sure all deferred tasks are completed */
+
+	(void)acpi_ut_release_mutex(ACPI_MTX_EVENTS);
+	acpi_os_wait_events_complete(NULL);
+	status = acpi_ut_acquire_mutex(ACPI_MTX_EVENTS);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	/* Remove the handler */
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
@@ -686,6 +734,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_remove_gpe_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_acquire_global_lock
@@ -724,6 +774,8 @@
 	return (status);
 }
 
+EXPORT_SYMBOL(acpi_acquire_global_lock);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_release_global_lock
@@ -747,3 +799,5 @@
 	status = acpi_ev_release_global_lock();
 	return (status);
 }
+
+EXPORT_SYMBOL(acpi_release_global_lock);
diff -Nau acpica-unix-20060210/drivers/acpi/events/evxfregn.c linux-acpi-2.6/drivers/acpi/events/evxfregn.c
--- acpica-unix-20060210/drivers/acpi/events/evxfregn.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/events/evxfregn.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acevents.h>
@@ -112,6 +114,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_install_address_space_handler);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_remove_address_space_handler
@@ -237,3 +241,5 @@
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
+
+EXPORT_SYMBOL(acpi_remove_address_space_handler);
diff -Nau acpica-unix-20060210/drivers/acpi/parser/pstree.c linux-acpi-2.6/drivers/acpi/parser/pstree.c
--- acpica-unix-20060210/drivers/acpi/parser/pstree.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/parser/pstree.c	2006-02-10 17:59:08.000000000 -0500
@@ -174,6 +174,7 @@
 	}
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_depth_next
@@ -305,3 +306,5 @@
 	return (child);
 }
 #endif
+
+#endif				/*  ACPI_FUTURE_USAGE  */
diff -Nau acpica-unix-20060210/drivers/acpi/parser/psutils.c linux-acpi-2.6/drivers/acpi/parser/psutils.c
--- acpica-unix-20060210/drivers/acpi/parser/psutils.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/parser/psutils.c	2006-02-10 17:59:08.000000000 -0500
@@ -139,10 +139,12 @@
 		/* The generic op (default) is by far the most common (16 to 1) */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_cache);
+		memset(op, 0, sizeof(struct acpi_parse_obj_common));
 	} else {
 		/* Extended parseop */
 
 		op = acpi_os_acquire_object(acpi_gbl_ps_node_ext_cache);
+		memset(op, 0, sizeof(struct acpi_parse_obj_named));
 	}
 
 	/* Initialize the Op */
@@ -211,6 +213,7 @@
 /*
  * Get op's name (4-byte name segment) or 0 if unnamed
  */
+#ifdef ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object * op)
 {
 
@@ -224,6 +227,7 @@
 
 	return (op->named.name);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*
  * Set op's name
diff -Nau acpica-unix-20060210/drivers/acpi/tables/tbconvrt.c linux-acpi-2.6/drivers/acpi/tables/tbconvrt.c
--- acpica-unix-20060210/drivers/acpi/tables/tbconvrt.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/tables/tbconvrt.c	2006-02-10 17:59:08.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
 
@@ -61,6 +63,9 @@
 acpi_tb_convert_fadt2(struct fadt_descriptor_rev2 *local_fadt,
 		      struct fadt_descriptor_rev2 *original_fadt);
 
+u8 acpi_fadt_is_v1;
+EXPORT_SYMBOL(acpi_fadt_is_v1);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_tb_get_table_count
@@ -221,6 +226,7 @@
 
 	/* ACPI 1.0 FACS */
 	/* The BIOS stored FADT should agree with Revision 1.0 */
+	acpi_fadt_is_v1 = 1;
 
 	/*
 	 * Copy the table header and the common part of the tables.
@@ -252,9 +258,12 @@
 	/*
 	 * Processor Performance State Control. This is the value OSPM writes to
 	 * the SMI_CMD register to assume processor performance state control
-	 * responsibility. There isn't any equivalence in 1.0, leave it zeroed.
+	 * responsibility. There isn't any equivalence in 1.0, but as many 1.x
+	 * ACPI tables contain _PCT and _PSS we also keep this value, unless
+	 * acpi_strict is set.
 	 */
-	local_fadt->pstate_cnt = 0;
+	if (acpi_strict)
+		local_fadt->pstate_cnt = 0;
 
 	/*
 	 * Support for the _CST object and C States change notification.
diff -Nau acpica-unix-20060210/drivers/acpi/tables/tbxfroot.c linux-acpi-2.6/drivers/acpi/tables/tbxfroot.c
--- acpica-unix-20060210/drivers/acpi/tables/tbxfroot.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/tables/tbxfroot.c	2006-02-10 17:59:08.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/actables.h>
 
@@ -368,6 +370,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_firmware_table);
+
 /* TBD: Move to a new file */
 
 #if ACPI_MACHINE_WIDTH != 16
diff -Nau acpica-unix-20060210/drivers/acpi/tables/tbxface.c linux-acpi-2.6/drivers/acpi/tables/tbxface.c
--- acpica-unix-20060210/drivers/acpi/tables/tbxface.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/tables/tbxface.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/actables.h>
@@ -121,6 +123,7 @@
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_load_table
@@ -324,6 +327,8 @@
 	return_ACPI_STATUS(status);
 }
 
+#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_table
@@ -414,3 +419,5 @@
 	ACPI_MEMCPY((void *)ret_buffer->pointer, (void *)tbl_ptr, table_length);
 	return_ACPI_STATUS(AE_OK);
 }
+
+EXPORT_SYMBOL(acpi_get_table);
diff -Nau acpica-unix-20060210/drivers/acpi/dispatcher/dswstate.c linux-acpi-2.6/drivers/acpi/dispatcher/dswstate.c
--- acpica-unix-20060210/drivers/acpi/dispatcher/dswstate.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/dispatcher/dswstate.c	2006-02-10 17:59:08.000000000 -0500
@@ -65,6 +65,8 @@
 				  struct acpi_walk_state *walk_state);
 #endif
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ds_result_remove
@@ -127,6 +129,8 @@
 	return (AE_OK);
 }
 
+#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ds_result_pop
diff -Nau acpica-unix-20060210/drivers/acpi/dispatcher/dswload.c linux-acpi-2.6/drivers/acpi/dispatcher/dswload.c
--- acpica-unix-20060210/drivers/acpi/dispatcher/dswload.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/dispatcher/dswload.c	2006-02-10 17:59:08.000000000 -0500
@@ -1113,6 +1113,7 @@
 				   ACPI_NS_DONT_OPEN_SCOPE, walk_state,
 				   &(new_node));
 		if (ACPI_SUCCESS(status)) {
+
 			/*
 			 * Make sure that what we found is indeed a method
 			 * We didn't search for a method on purpose, to see if the name
diff -Nau acpica-unix-20060210/drivers/acpi/resources/rsinfo.c linux-acpi-2.6/drivers/acpi/resources/rsinfo.c
--- acpica-unix-20060210/drivers/acpi/resources/rsinfo.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/resources/rsinfo.c	2006-02-02 17:15:59.000000000 -0500
@@ -116,6 +116,7 @@
 	acpi_rs_convert_ext_address64	/* 0x0B, ACPI_RESOURCE_NAME_EXTENDED_ADDRESS64 */
 };
 
+#ifdef ACPI_FUTURE_USAGE
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)
 
 /* Dispatch table for resource dump functions */
@@ -140,7 +141,7 @@
 	acpi_rs_dump_generic_reg,	/* ACPI_RESOURCE_TYPE_GENERIC_REGISTER */
 };
 #endif
-
+#endif	/* ACPI_FUTURE_USAGE */
 /*
  * Base sizes for external AML resource descriptors, indexed by internal type.
  * Includes size of the descriptor header (1 byte for small descriptors,
diff -Nau acpica-unix-20060210/drivers/acpi/resources/rsutils.c linux-acpi-2.6/drivers/acpi/resources/rsutils.c
--- acpica-unix-20060210/drivers/acpi/resources/rsutils.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/resources/rsutils.c	2006-02-10 17:59:08.000000000 -0500
@@ -553,6 +553,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_rs_get_prs_method_data(acpi_handle handle, struct acpi_buffer *ret_buffer)
 {
@@ -583,6 +584,7 @@
 	acpi_ut_remove_reference(obj_desc);
 	return_ACPI_STATUS(status);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20060210/drivers/acpi/resources/rsxface.c linux-acpi-2.6/drivers/acpi/resources/rsxface.c
--- acpica-unix-20060210/drivers/acpi/resources/rsxface.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/resources/rsxface.c	2006-02-10 17:59:08.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acresrc.h>
 
@@ -167,6 +169,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_current_resources);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_possible_resources
@@ -188,6 +192,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_possible_resources(acpi_handle device_handle,
 			    struct acpi_buffer *ret_buffer)
@@ -215,6 +220,9 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_possible_resources);
+#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_walk_resources
@@ -309,6 +317,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_walk_resources);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_set_current_resources
@@ -346,6 +356,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_set_current_resources);
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_resource_to_address64
@@ -405,6 +417,8 @@
 	return (AE_OK);
 }
 
+EXPORT_SYMBOL(acpi_resource_to_address64);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_vendor_resource
diff -Nau acpica-unix-20060210/drivers/acpi/executer/excreate.c linux-acpi-2.6/drivers/acpi/executer/excreate.c
--- acpica-unix-20060210/drivers/acpi/executer/excreate.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/executer/excreate.c	2006-02-02 17:15:59.000000000 -0500
@@ -63,7 +63,7 @@
  * DESCRIPTION: Create a new named alias
  *
  ******************************************************************************/
-acpi_status acpi_ex_create_alias(struct acpi_walk_state * walk_state)
+acpi_status acpi_ex_create_alias(struct acpi_walk_state *walk_state)
 {
 	struct acpi_namespace_node *target_node;
 	struct acpi_namespace_node *alias_node;
diff -Nau acpica-unix-20060210/drivers/acpi/namespace/nsparse.c linux-acpi-2.6/drivers/acpi/namespace/nsparse.c
--- acpica-unix-20060210/drivers/acpi/namespace/nsparse.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/namespace/nsparse.c	2006-02-02 17:15:59.000000000 -0500
@@ -62,7 +62,7 @@
  *
  ******************************************************************************/
 acpi_status
-acpi_ns_one_complete_parse(u8 pass_number, struct acpi_table_desc *table_desc)
+acpi_ns_one_complete_parse(u8 pass_number, struct acpi_table_desc * table_desc)
 {
 	union acpi_parse_object *parse_root;
 	acpi_status status;
diff -Nau acpica-unix-20060210/drivers/acpi/namespace/nsxfobj.c linux-acpi-2.6/drivers/acpi/namespace/nsxfobj.c
--- acpica-unix-20060210/drivers/acpi/namespace/nsxfobj.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/namespace/nsxfobj.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -99,6 +101,8 @@
 	return (status);
 }
 
+EXPORT_SYMBOL(acpi_get_type);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_parent
@@ -158,6 +162,8 @@
 	return (status);
 }
 
+EXPORT_SYMBOL(acpi_get_parent);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_next_object
@@ -236,3 +242,5 @@
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return (status);
 }
+
+EXPORT_SYMBOL(acpi_get_next_object);
diff -Nau acpica-unix-20060210/drivers/acpi/namespace/nsdump.c linux-acpi-2.6/drivers/acpi/namespace/nsdump.c
--- acpica-unix-20060210/drivers/acpi/namespace/nsdump.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/namespace/nsdump.c	2006-02-10 17:59:08.000000000 -0500
@@ -585,6 +585,7 @@
 	return (AE_OK);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_objects
@@ -623,6 +624,7 @@
 				     acpi_ns_dump_one_object, (void *)&info,
 				     NULL);
 }
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*******************************************************************************
  *
@@ -694,5 +696,5 @@
 			     ACPI_OWNER_ID_MAX, search_handle);
 	return_VOID;
 }
-#endif
-#endif
+#endif				/* _ACPI_ASL_COMPILER */
+#endif				/* defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER) */
diff -Nau acpica-unix-20060210/drivers/acpi/namespace/nsxfeval.c linux-acpi-2.6/drivers/acpi/namespace/nsxfeval.c
--- acpica-unix-20060210/drivers/acpi/namespace/nsxfeval.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/namespace/nsxfeval.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 #include <acpi/acinterp.h>
@@ -69,11 +71,12 @@
  *              be valid (non-null)
  *
  ******************************************************************************/
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_evaluate_object_typed(acpi_handle handle,
 			   acpi_string pathname,
-			   struct acpi_object_list * external_params,
-			   struct acpi_buffer * return_buffer,
+			   struct acpi_object_list *external_params,
+			   struct acpi_buffer *return_buffer,
 			   acpi_object_type return_type)
 {
 	acpi_status status;
@@ -139,6 +142,7 @@
 	return_buffer->length = 0;
 	return_ACPI_STATUS(AE_TYPE);
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
@@ -352,6 +356,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_evaluate_object);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_walk_namespace
@@ -418,6 +424,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_walk_namespace);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_get_device_callback
@@ -584,6 +592,8 @@
 	return_ACPI_STATUS(status);
 }
 
+EXPORT_SYMBOL(acpi_get_devices);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_attach_data
diff -Nau acpica-unix-20060210/drivers/acpi/namespace/nsxfname.c linux-acpi-2.6/drivers/acpi/namespace/nsxfname.c
--- acpica-unix-20060210/drivers/acpi/namespace/nsxfname.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/namespace/nsxfname.c	2006-02-10 17:59:08.000000000 -0500
@@ -42,6 +42,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -124,6 +126,8 @@
 	return (status);
 }
 
+EXPORT_SYMBOL(acpi_get_handle);
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_get_name
@@ -200,6 +204,8 @@
 	return (status);
 }
 
+EXPORT_SYMBOL(acpi_get_name);
+
 /******************************************************************************
  *
  * FUNCTION:    acpi_get_object_info
@@ -346,3 +352,5 @@
 	}
 	return (status);
 }
+
+EXPORT_SYMBOL(acpi_get_object_info);
diff -Nau acpica-unix-20060210/drivers/acpi/utilities/utxface.c linux-acpi-2.6/drivers/acpi/utilities/utxface.c
--- acpica-unix-20060210/drivers/acpi/utilities/utxface.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/utilities/utxface.c	2006-02-02 17:15:59.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 #include <acpi/acevents.h>
 #include <acpi/acnamesp.h>
@@ -346,6 +348,7 @@
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 /*******************************************************************************
  *
  * FUNCTION:    acpi_subsystem_status
@@ -453,6 +456,8 @@
 	return_ACPI_STATUS(AE_OK);
 }
 
+EXPORT_SYMBOL(acpi_get_system_info);
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_install_initialization_handler
@@ -484,6 +489,8 @@
 	return AE_OK;
 }
 
+#endif				/*  ACPI_FUTURE_USAGE  */
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_purge_cached_objects
diff -Nau acpica-unix-20060210/drivers/acpi/utilities/utdebug.c linux-acpi-2.6/drivers/acpi/utilities/utdebug.c
--- acpica-unix-20060210/drivers/acpi/utilities/utdebug.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/utilities/utdebug.c	2006-02-10 17:59:08.000000000 -0500
@@ -41,6 +41,8 @@
  * POSSIBILITY OF SUCH DAMAGES.
  */
 
+#include <linux/module.h>
+
 #include <acpi/acpi.h>
 
 #define _COMPONENT          ACPI_UTILITIES
@@ -206,6 +208,8 @@
 	acpi_os_vprintf(format, args);
 }
 
+EXPORT_SYMBOL(acpi_ut_debug_print);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_debug_print_raw
@@ -242,6 +246,8 @@
 	acpi_os_vprintf(format, args);
 }
 
+EXPORT_SYMBOL(acpi_ut_debug_print_raw);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_trace
@@ -271,6 +277,8 @@
 			    component_id, "%s\n", acpi_gbl_fn_entry_str);
 }
 
+EXPORT_SYMBOL(acpi_ut_trace);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_trace_ptr
@@ -394,6 +402,8 @@
 	acpi_gbl_nesting_level--;
 }
 
+EXPORT_SYMBOL(acpi_ut_exit);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_status_exit
@@ -434,6 +444,8 @@
 	acpi_gbl_nesting_level--;
 }
 
+EXPORT_SYMBOL(acpi_ut_status_exit);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_value_exit
@@ -465,6 +477,8 @@
 	acpi_gbl_nesting_level--;
 }
 
+EXPORT_SYMBOL(acpi_ut_value_exit);
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ut_ptr_exit
diff -Nau acpica-unix-20060210/drivers/acpi/utilities/utstate.c linux-acpi-2.6/drivers/acpi/utilities/utstate.c
--- acpica-unix-20060210/drivers/acpi/utilities/utstate.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/utilities/utstate.c	2006-02-10 17:59:08.000000000 -0500
@@ -161,6 +161,7 @@
 	if (state) {
 
 		/* Initialize */
+		memset(state, 0, sizeof(union acpi_generic_state));
 		state->common.data_type = ACPI_DESC_TYPE_STATE;
 	}
 
diff -Nau acpica-unix-20060210/drivers/acpi/utilities/utglobal.c linux-acpi-2.6/drivers/acpi/utilities/utglobal.c
--- acpica-unix-20060210/drivers/acpi/utilities/utglobal.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/utilities/utglobal.c	2006-02-10 17:59:08.000000000 -0500
@@ -43,6 +43,7 @@
 
 #define DEFINE_ACPI_GLOBALS
 
+#include <linux/module.h>
 #include <acpi/acpi.h>
 #include <acpi/acnamesp.h>
 
@@ -142,16 +143,13 @@
  */
 
 /* Debug switch - level and trace mask */
-
-#ifdef ACPI_DEBUG_OUTPUT
 u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
-#else
-u32 acpi_dbg_level = ACPI_NORMAL_DEFAULT;
-#endif
+EXPORT_SYMBOL(acpi_dbg_level);
 
 /* Debug switch - layer (component) mask */
 
-u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT;
+u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
+EXPORT_SYMBOL(acpi_dbg_layer);
 u32 acpi_gbl_nesting_level = 0;
 
 /* Debugger globals */
diff -Nau acpica-unix-20060210/drivers/acpi/utilities/utalloc.c linux-acpi-2.6/drivers/acpi/utilities/utalloc.c
--- acpica-unix-20060210/drivers/acpi/utilities/utalloc.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/utilities/utalloc.c	2006-02-10 17:59:08.000000000 -0500
@@ -101,7 +101,7 @@
 	/* Object Caches, for frequently used objects */
 
 	status =
-	    acpi_os_create_cache("Acpi-State", sizeof(union acpi_generic_state),
+	    acpi_os_create_cache("acpi_state", sizeof(union acpi_generic_state),
 				 ACPI_MAX_STATE_CACHE_DEPTH,
 				 &acpi_gbl_state_cache);
 	if (ACPI_FAILURE(status)) {
@@ -109,7 +109,7 @@
 	}
 
 	status =
-	    acpi_os_create_cache("Acpi-Parse",
+	    acpi_os_create_cache("acpi_parse",
 				 sizeof(struct acpi_parse_obj_common),
 				 ACPI_MAX_PARSE_CACHE_DEPTH,
 				 &acpi_gbl_ps_node_cache);
@@ -118,7 +118,7 @@
 	}
 
 	status =
-	    acpi_os_create_cache("Acpi-parse_ext",
+	    acpi_os_create_cache("acpi_parse_ext",
 				 sizeof(struct acpi_parse_obj_named),
 				 ACPI_MAX_EXTPARSE_CACHE_DEPTH,
 				 &acpi_gbl_ps_node_ext_cache);
@@ -127,7 +127,7 @@
 	}
 
 	status =
-	    acpi_os_create_cache("Acpi-Operand",
+	    acpi_os_create_cache("acpi_operand",
 				 sizeof(union acpi_operand_object),
 				 ACPI_MAX_OBJECT_CACHE_DEPTH,
 				 &acpi_gbl_operand_cache);
@@ -733,6 +733,7 @@
  *
  ******************************************************************************/
 
+#ifdef ACPI_FUTURE_USAGE
 void acpi_ut_dump_allocation_info(void)
 {
 /*
@@ -775,6 +776,7 @@
 */
 	return_VOID;
 }
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 /*******************************************************************************
  *
diff -Nau acpica-unix-20060210/drivers/acpi/utilities/utobject.c linux-acpi-2.6/drivers/acpi/utilities/utobject.c
--- acpica-unix-20060210/drivers/acpi/utilities/utobject.c	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/drivers/acpi/utilities/utobject.c	2006-02-10 17:59:08.000000000 -0500
@@ -320,7 +320,7 @@
 	}
 
 	/* Mark the descriptor type */
-
+	memset(object, 0, sizeof(union acpi_operand_object));
 	ACPI_SET_DESCRIPTOR_TYPE(object, ACPI_DESC_TYPE_OPERAND);
 
 	ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS, "%p Size %X\n",
diff -Nau acpica-unix-20060210/include/acpi/acutils.h linux-acpi-2.6/include/acpi/acutils.h
--- acpica-unix-20060210/include/acpi/acutils.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acutils.h	2006-02-10 17:59:08.000000000 -0500
@@ -417,11 +417,13 @@
 				     u16 action,
 				     union acpi_generic_state **state_list);
 
+#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_ut_create_pkg_state_and_push(void *internal_object,
 				  void *external_object,
 				  u16 index,
 				  union acpi_generic_state **state_list);
+#endif				/* ACPI_FUTURE_USAGE */
 
 union acpi_generic_state *acpi_ut_create_control_state(void);
 
@@ -531,7 +533,9 @@
 void
 acpi_ut_free_and_track(void *address, u32 component, char *module, u32 line);
 
+#ifdef	ACPI_FUTURE_USAGE
 void acpi_ut_dump_allocation_info(void);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ut_dump_allocations(u32 component, char *module);
 #endif
diff -Nau acpica-unix-20060210/include/acpi/achware.h linux-acpi-2.6/include/acpi/achware.h
--- acpica-unix-20060210/include/acpi/achware.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/achware.h	2006-02-02 17:15:59.000000000 -0500
@@ -102,9 +102,11 @@
 acpi_hw_clear_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 			struct acpi_gpe_block_info *gpe_block);
 
+#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status * event_status);
+#endif				/* ACPI_FUTURE_USAGE */
 
 acpi_status acpi_hw_disable_all_gpes(void);
 
@@ -116,6 +118,7 @@
 acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block);
 
+#ifdef	ACPI_FUTURE_USAGE
 /*
  * hwtimer - ACPI Timer prototypes
  */
@@ -125,5 +128,6 @@
 
 acpi_status
 acpi_get_timer_duration(u32 start_ticks, u32 end_ticks, u32 * time_elapsed);
+#endif				/* ACPI_FUTURE_USAGE */
 
 #endif				/* __ACHWARE_H__ */
diff -Nau acpica-unix-20060210/include/acpi/acinterp.h linux-acpi-2.6/include/acpi/acinterp.h
--- acpica-unix-20060210/include/acpi/acinterp.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acinterp.h	2006-02-02 17:15:59.000000000 -0500
@@ -365,10 +365,12 @@
 		      u32 num_levels,
 		      char *note, char *module_name, u32 line_number);
 
+#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ex_dump_object_descriptor(union acpi_operand_object *object, u32 flags);
 
 void acpi_ex_dump_namespace_node(struct acpi_namespace_node *node, u32 flags);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * exnames - AML namestring support
diff -Nau acpica-unix-20060210/include/acpi/acnamesp.h linux-acpi-2.6/include/acpi/acnamesp.h
--- acpica-unix-20060210/include/acpi/acnamesp.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acnamesp.h	2006-02-02 17:15:59.000000000 -0500
@@ -145,7 +145,9 @@
 /*
  * nsdump - Namespace dump/print utilities
  */
+#ifdef	ACPI_FUTURE_USAGE
 void acpi_ns_dump_tables(acpi_handle search_base, u32 max_depth);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ns_dump_entry(acpi_handle handle, u32 debug_level);
 
@@ -158,11 +160,13 @@
 acpi_ns_dump_one_object(acpi_handle obj_handle,
 			u32 level, void *context, void **return_value);
 
+#ifdef	ACPI_FUTURE_USAGE
 void
 acpi_ns_dump_objects(acpi_object_type type,
 		     u8 display_type,
 		     u32 max_depth,
 		     acpi_owner_id owner_id, acpi_handle start_handle);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * nseval - Namespace evaluation functions
diff -Nau acpica-unix-20060210/include/acpi/acdebug.h linux-acpi-2.6/include/acpi/acdebug.h
--- acpica-unix-20060210/include/acpi/acdebug.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acdebug.h	2006-02-02 17:15:59.000000000 -0500
@@ -196,8 +196,6 @@
 
 void ACPI_SYSTEM_XFACE acpi_db_execute_thread(void *context);
 
-acpi_status acpi_db_user_commands(char prompt, union acpi_parse_object *op);
-
 /*
  * dbstats - Generation and display of ACPI table statistics
  */
diff -Nau acpica-unix-20060210/include/acpi/acresrc.h linux-acpi-2.6/include/acpi/acresrc.h
--- acpica-unix-20060210/include/acpi/acresrc.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acresrc.h	2006-02-02 17:15:59.000000000 -0500
@@ -170,8 +170,10 @@
 acpi_status
 acpi_rs_get_crs_method_data(acpi_handle handle, struct acpi_buffer *ret_buffer);
 
+#ifdef	ACPI_FUTURE_USAGE
 acpi_status
 acpi_rs_get_prs_method_data(acpi_handle handle, struct acpi_buffer *ret_buffer);
+#endif				/* ACPI_FUTURE_USAGE */
 
 acpi_status
 acpi_rs_get_method_data(acpi_handle handle,
diff -Nau acpica-unix-20060210/include/acpi/acpixf.h linux-acpi-2.6/include/acpi/acpixf.h
--- acpica-unix-20060210/include/acpi/acpixf.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acpixf.h	2006-02-02 17:15:59.000000000 -0500
@@ -59,20 +59,26 @@
 
 acpi_status acpi_terminate(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_subsystem_status(void);
+#endif
 
 acpi_status acpi_enable(void);
 
 acpi_status acpi_disable(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_system_info(struct acpi_buffer *ret_buffer);
+#endif
 
 const char *acpi_format_exception(acpi_status exception);
 
 acpi_status acpi_purge_cached_objects(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_install_initialization_handler(acpi_init_handler handler, u32 function);
+#endif
 
 /*
  * ACPI Memory managment
@@ -91,6 +97,7 @@
 
 acpi_status acpi_load_tables(void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_load_table(struct acpi_table_header *table_ptr);
 
 acpi_status acpi_unload_table(acpi_table_type table_type);
@@ -98,6 +105,7 @@
 acpi_status
 acpi_get_table_header(acpi_table_type table_type,
 		      u32 instance, struct acpi_table_header *out_table_header);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_get_table(acpi_table_type table_type,
@@ -153,12 +161,14 @@
 		     struct acpi_object_list *parameter_objects,
 		     struct acpi_buffer *return_object_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_evaluate_object_typed(acpi_handle object,
 			   acpi_string pathname,
 			   struct acpi_object_list *external_params,
 			   struct acpi_buffer *return_buffer,
 			   acpi_object_type return_type);
+#endif
 
 acpi_status
 acpi_get_object_info(acpi_handle handle, struct acpi_buffer *return_buffer);
@@ -207,7 +217,9 @@
 			 u32 gpe_number,
 			 u32 type, acpi_event_handler address, void *context);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_install_exception_handler(acpi_exception_handler handler);
+#endif
 
 /*
  * Event interfaces
@@ -226,7 +238,9 @@
 
 acpi_status acpi_clear_event(u32 event);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status acpi_get_event_status(u32 event, acpi_event_status * event_status);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status acpi_set_gpe_type(acpi_handle gpe_device, u32 gpe_number, u8 type);
 
@@ -236,10 +250,12 @@
 
 acpi_status acpi_clear_gpe(acpi_handle gpe_device, u32 gpe_number, u32 flags);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_gpe_status(acpi_handle gpe_device,
 		    u32 gpe_number,
 		    u32 flags, acpi_event_status * event_status);
+#endif				/*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_install_gpe_block(acpi_handle gpe_device,
@@ -265,9 +281,11 @@
 acpi_get_current_resources(acpi_handle device_handle,
 			   struct acpi_buffer *ret_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_possible_resources(acpi_handle device_handle,
 			    struct acpi_buffer *ret_buffer);
+#endif
 
 acpi_status
 acpi_walk_resources(acpi_handle device_handle,
@@ -296,17 +314,19 @@
 acpi_status
 acpi_set_firmware_waking_vector(acpi_physical_address physical_address);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector(acpi_physical_address * physical_address);
+#endif
 
 acpi_status
 acpi_get_sleep_type_data(u8 sleep_state, u8 * slp_typ_a, u8 * slp_typ_b);
 
 acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
-acpi_status acpi_enter_sleep_state(u8 sleep_state);
+acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
 
-acpi_status acpi_enter_sleep_state_s4bios(void);
+acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void);
 
 acpi_status acpi_leave_sleep_state(u8 sleep_state);
 
diff -Nau acpica-unix-20060210/include/acpi/actbl.h linux-acpi-2.6/include/acpi/actbl.h
--- acpica-unix-20060210/include/acpi/actbl.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/actbl.h	2006-02-02 17:15:59.000000000 -0500
@@ -296,6 +296,9 @@
 #include "actbl1.h"		/* Acpi 1.0 table definitions */
 #include "actbl2.h"		/* Acpi 2.0 table definitions */
 
+extern u8 acpi_fadt_is_v1;	/* is set to 1 if FADT is revision 1,
+				 * needed for certain workarounds */
+
 #pragma pack(1)
 /*
  * High performance timer
diff -Nau acpica-unix-20060210/include/acpi/acdispat.h linux-acpi-2.6/include/acpi/acdispat.h
--- acpica-unix-20060210/include/acpi/acdispat.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acdispat.h	2006-02-02 17:15:59.000000000 -0500
@@ -326,9 +326,11 @@
 struct acpi_walk_state *acpi_ds_get_current_walk_state(struct acpi_thread_state
 						       *thread);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ds_result_remove(union acpi_operand_object **object,
 		      u32 index, struct acpi_walk_state *walk_state);
+#endif
 
 acpi_status
 acpi_ds_result_pop(union acpi_operand_object **object,
diff -Nau acpica-unix-20060210/include/acpi/acmacros.h linux-acpi-2.6/include/acpi/acmacros.h
--- acpica-unix-20060210/include/acpi/acmacros.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acmacros.h	2006-02-02 17:15:59.000000000 -0500
@@ -476,14 +476,6 @@
 #define ACPI_ERROR_NAMESPACE(s,e)       acpi_ns_report_error (AE_INFO, s, e);
 #define ACPI_ERROR_METHOD(s,n,p,e)      acpi_ns_report_method_error (AE_INFO, s, n, p, e);
 
-/* Legacy interfaces. Remove when migration is complete */
-
-#define ACPI_REPORT_INFO(fp)            {acpi_ut_report_info (AE_INFO); \
-			  acpi_os_printf fp;}
-#define ACPI_REPORT_ERROR(fp)           {acpi_ut_report_error (AE_INFO); \
-					   acpi_os_printf fp;}
-#define ACPI_REPORT_WARNING(fp)         {acpi_ut_report_warning (AE_INFO); \
-							 acpi_os_printf fp;}
 #else
 
 /* No error messages */
@@ -495,9 +487,6 @@
 #define ACPI_ERROR_NAMESPACE(s,e)
 #define ACPI_ERROR_METHOD(s,n,p,e)
 
-#define ACPI_REPORT_INFO(fp)
-#define ACPI_REPORT_ERROR(fp)
-#define ACPI_REPORT_WARNING(fp)
 #endif
 
 /*
@@ -665,7 +654,6 @@
 #define ACPI_DUMP_STACK_ENTRY(a)
 #define ACPI_DUMP_OPERANDS(a,b,c,d,e)
 #define ACPI_DUMP_ENTRY(a,b)
-#define ACPI_DUMP_TABLES(a,b)
 #define ACPI_DUMP_PATHNAME(a,b,c,d)
 #define ACPI_DUMP_RESOURCE_LIST(a)
 #define ACPI_DUMP_BUFFER(a,b)
diff -Nau acpica-unix-20060210/include/acpi/platform/acenv.h linux-acpi-2.6/include/acpi/platform/acenv.h
--- acpica-unix-20060210/include/acpi/platform/acenv.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/platform/acenv.h	2006-02-02 17:15:59.000000000 -0500
@@ -271,8 +271,8 @@
 /*
  * Storage alignment properties
  */
-#define  _AUPBND                (sizeof (acpi_native_int) - 1)
-#define  _ADNBND                (sizeof (acpi_native_int) - 1)
+#define  _AUPBND                (sizeof (acpi_native_uint) - 1)
+#define  _ADNBND                (sizeof (acpi_native_uint) - 1)
 
 /*
  * Variable argument list macro definitions
diff -Nau acpica-unix-20060210/include/acpi/platform/aclinux.h linux-acpi-2.6/include/acpi/platform/aclinux.h
--- acpica-unix-20060210/include/acpi/platform/aclinux.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/platform/aclinux.h	2006-02-02 17:15:59.000000000 -0500
@@ -64,7 +64,16 @@
 
 /* Type(s) for the OSL */
 
-#define acpi_cache_t kmem_cache_t
+#ifdef ACPI_USE_LOCAL_CACHE
+#define acpi_cache_t	struct acpi_memory_list
+#else
+#include <linux/slab.h>
+#define acpi_cache_t	kmem_cache_t
+#endif
+
+/* Full namespace pathname length limit - arbitrary */
+
+#define ACPI_PATHNAME_MAX              256
 
 #else				/* !__KERNEL__ */
 
@@ -93,4 +102,6 @@
 
 #include "acgcc.h"
 
+#define acpi_cpu_flags unsigned long
+
 #endif				/* __ACLINUX_H__ */
diff -Nau acpica-unix-20060210/include/acpi/acparser.h linux-acpi-2.6/include/acpi/acparser.h
--- acpica-unix-20060210/include/acpi/acparser.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acparser.h	2006-02-02 17:15:59.000000000 -0500
@@ -167,8 +167,10 @@
 
 union acpi_parse_object *acpi_ps_get_arg(union acpi_parse_object *op, u32 argn);
 
+#ifdef	ACPI_FUTURE_USAGE
 union acpi_parse_object *acpi_ps_get_depth_next(union acpi_parse_object *origin,
 						union acpi_parse_object *op);
+#endif				/* ACPI_FUTURE_USAGE */
 
 /*
  * pswalk - parse tree walk routines
@@ -208,7 +210,9 @@
 
 u8 acpi_ps_is_prefix_char(u32 c);
 
+#ifdef	ACPI_FUTURE_USAGE
 u32 acpi_ps_get_name(union acpi_parse_object *op);
+#endif				/* ACPI_FUTURE_USAGE */
 
 void acpi_ps_set_name(union acpi_parse_object *op, u32 name);
 
diff -Nau acpica-unix-20060210/include/acpi/acpiosxf.h linux-acpi-2.6/include/acpi/acpiosxf.h
--- acpica-unix-20060210/include/acpi/acpiosxf.h	2006-02-10 17:56:06.000000000 -0500
+++ linux-acpi-2.6/include/acpi/acpiosxf.h	2006-02-02 17:15:59.000000000 -0500
@@ -121,13 +121,15 @@
 
 acpi_status
 acpi_os_map_memory(acpi_physical_address physical_address,
-		   acpi_size size, void **logical_address);
+		   acpi_size size, void __iomem ** logical_address);
 
-void acpi_os_unmap_memory(void *logical_address, acpi_size size);
+void acpi_os_unmap_memory(void __iomem * logical_address, acpi_size size);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *logical_address,
 			     acpi_physical_address * physical_address);
+#endif
 
 /*
  * Memory/Object Cache
@@ -149,13 +151,12 @@
  * Interrupt handlers
  */
 acpi_status
-acpi_os_install_interrupt_handler(u32 interrupt_number,
+acpi_os_install_interrupt_handler(u32 gsi,
 				  acpi_osd_handler service_routine,
 				  void *context);
 
 acpi_status
-acpi_os_remove_interrupt_handler(u32 interrupt_number,
-				 acpi_osd_handler service_routine);
+acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler service_routine);
 
 /*
  * Threads and Scheduling
@@ -168,6 +169,8 @@
 
 void acpi_os_wait_events_complete(void *context);
 
+void acpi_os_wait_events_complete(void *context);
+
 void acpi_os_sleep(acpi_integer milliseconds);
 
 void acpi_os_stall(u32 microseconds);
@@ -213,7 +216,9 @@
  */
 u8 acpi_os_readable(void *pointer, acpi_size length);
 
+#ifdef ACPI_FUTURE_USAGE
 u8 acpi_os_writable(void *pointer, acpi_size length);
+#endif
 
 u64 acpi_os_get_timer(void);
 
@@ -228,10 +233,12 @@
 
 void acpi_os_redirect_output(void *destination);
 
+#ifdef ACPI_FUTURE_USAGE
 /*
  * Debug input
  */
 u32 acpi_os_get_line(char *buffer);
+#endif
 
 /*
  * Directory manipulation
