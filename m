From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [Xen-devel] Re: Paravirtualizing bits of acpi access
Date: Mon, 23 Mar 2009 22:14:41 -0700
Message-ID: <49C86C41.1060803@goop.org>
References: <49C484B7.20100@goop.org> <200903231920.12991.rjw@sisk.pl> <49C7DDDC.2050103@goop.org> <200903232127.40683.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:56744 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbZCXFOo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 24 Mar 2009 01:14:44 -0400
In-Reply-To: <200903232127.40683.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Brown, Len" <len.brown@intel.com>, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Cihula, Joseph" <joseph.cihula@intel.com>

Rafael J. Wysocki wrote:
> Yes, that may be better.
>   

How does this look now?  I had a second look at the Xen-hooks, and found 
that they were mostly unnecessary (they were preventing useless code 
from running, but there's no harm in letting it run).

The result is below.  Does this look reasonable?

Thanks,
    J

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 7c243a2..8ebda00 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -12,6 +12,9 @@
 #include <asm/segment.h>
 #include <asm/desc.h>
 
+#include <xen/acpi.h>
+#include <asm/xen/hypervisor.h>
+
 #include "realmode/wakeup.h"
 #include "sleep.h"
 
@@ -25,6 +28,34 @@ static unsigned long acpi_realmode;
 static char temp_stack[4096];
 #endif
 
+/* 
+ * Override final register write when entering sleep state so we can
+ * direct it to a hypercall in the Xen case.
+ */
+acpi_status arch_acpi_enter_sleep_state(u8 sleep_state, u32
+					PM1Acontrol, u32 PM1Bcontrol)
+{
+	acpi_status ret;
+
+	if (xen_pv_acpi()) {
+		int err;
+
+		err = acpi_notify_hypervisor_state(sleep_state,
+						   PM1Acontrol, PM1Bcontrol);
+
+		ret = AE_OK;
+		if (err) {
+			ACPI_DEBUG_PRINT((ACPI_DB_INIT,
+					  "Hypervisor failure [%d]\n", err));
+			ret = AE_ERROR;
+		}
+	} else
+		ret = default_acpi_enter_sleep_state(sleep_state,
+						     PM1Acontrol, PM1Bcontrol);
+
+	return ret;
+}
+
 /**
  * acpi_save_state_mem - save kernel state
  *
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index a2af2a4..6196a7e 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -209,6 +209,83 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
 
+/*
+ * Default implementation of final register write to enter sleep
+ * state, available for architecture versions to call if necessary.
+ */
+acpi_status default_acpi_enter_sleep_state(u8 sleep_state, u32
+					   PM1Acontrol, u32 PM1Bcontrol)
+{
+	acpi_status status;
+	u32 in_value;
+
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
+					PM1Acontrol);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
+					PM1Bcontrol);
+
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	if (sleep_state > ACPI_STATE_S3) {
+		struct acpi_bit_register_info *sleep_enable_reg_info;
+
+		/*
+		 * We wanted to sleep > S3, but it didn't happen (by virtue of the
+		 * fact that we are still executing!)
+		 *
+		 * Wait ten seconds, then try again. This is to get S4/S5 to work on
+		 * all machines.
+		 *
+		 * We wait so long to allow chipsets that poll this reg very slowly to
+		 * still read the right value. Ideally, this block would go
+		 * away entirely.
+		 */
+		acpi_os_stall(10000000);
+
+		sleep_enable_reg_info =
+			acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_ENABLE);
+
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1_CONTROL,
+						sleep_enable_reg_info->
+						access_bit_mask);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+	}
+
+	/* Wait until we enter sleep state */
+
+	do {
+		status = acpi_get_register_unlocked(ACPI_BITREG_WAKE_STATUS,
+						    &in_value);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
+		/* Spin until we wake */
+
+	} while (!in_value);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+/* 
+ * Weak version of final write to enter sleep state, so that
+ * architectures can override it.
+ */
+acpi_status __weak arch_acpi_enter_sleep_state(u8 sleep_state,
+					    u32 PM1Acontrol, u32 PM1Bcontrol)
+{
+	return default_acpi_enter_sleep_state(sleep_state,
+					      PM1Acontrol, PM1Bcontrol);
+}
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_enter_sleep_state
@@ -227,7 +304,6 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	u32 PM1Bcontrol;
 	struct acpi_bit_register_info *sleep_type_reg_info;
 	struct acpi_bit_register_info *sleep_enable_reg_info;
-	u32 in_value;
 	struct acpi_object_list arg_list;
 	union acpi_object arg;
 	acpi_status status;
@@ -337,54 +413,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
-					PM1Acontrol);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
-					PM1Bcontrol);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	if (sleep_state > ACPI_STATE_S3) {
-		/*
-		 * We wanted to sleep > S3, but it didn't happen (by virtue of the
-		 * fact that we are still executing!)
-		 *
-		 * Wait ten seconds, then try again. This is to get S4/S5 to work on
-		 * all machines.
-		 *
-		 * We wait so long to allow chipsets that poll this reg very slowly to
-		 * still read the right value. Ideally, this block would go
-		 * away entirely.
-		 */
-		acpi_os_stall(10000000);
-
-		status = acpi_hw_register_write(ACPI_REGISTER_PM1_CONTROL,
-						sleep_enable_reg_info->
-						access_bit_mask);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-	}
-
-	/* Wait until we enter sleep state */
-
-	do {
-		status = acpi_get_register_unlocked(ACPI_BITREG_WAKE_STATUS,
-						    &in_value);
-		if (ACPI_FAILURE(status)) {
-			return_ACPI_STATUS(status);
-		}
-
-		/* Spin until we wake */
-
-	} while (!in_value);
-
-	return_ACPI_STATUS(AE_OK);
+	return arch_acpi_enter_sleep_state(sleep_state, PM1Acontrol, PM1Bcontrol);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state)
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5192666..bd1cc1a 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -19,6 +19,8 @@
 
 #include <asm/io.h>
 
+#include <xen/acpi.h>
+
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 #include "sleep.h"
@@ -209,6 +211,21 @@ static int acpi_suspend_begin(suspend_state_t pm_state)
 	return error;
 }
 
+static void do_suspend(void)
+{
+	if (!xen_pv_acpi()) {
+		do_suspend_lowlevel();
+		return;
+	}
+
+	/*
+	 * Xen will save and restore CPU context, so
+	 * we can skip that and just go straight to
+	 * the suspend.
+	 */
+	acpi_enter_sleep_state(ACPI_STATE_S3);
+}
+
 /**
  *	acpi_suspend_enter - Actually enter a sleep state.
  *	@pm_state: ignored
@@ -242,7 +259,7 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		break;
 
 	case ACPI_STATE_S3:
-		do_suspend_lowlevel();
+		do_suspend();
 		break;
 	}
 
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 51cbaa5..0138113 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -76,3 +76,7 @@ config XEN_COMPAT_XENFS
 
 config XEN_XENBUS_FRONTEND
        tristate
+
+config XEN_S3
+       def_bool y
+       depends on XEN_DOM0 && ACPI
\ No newline at end of file
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index bb88673..4b01fc8 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -7,4 +7,6 @@ obj-$(CONFIG_XEN_BALLOON)		+= balloon.o
 obj-$(CONFIG_XEN_DEV_EVTCHN)	+= evtchn.o
 obj-$(CONFIG_XEN_BLKDEV_BACKEND)	+= blkback/
 obj-$(CONFIG_XEN_NETDEV_BACKEND)	+= netback/
-obj-$(CONFIG_XENFS)			+= xenfs/
\ No newline at end of file
+obj-$(CONFIG_XENFS)			+= xenfs/
+
+obj-$(CONFIG_XEN_S3)			+= acpi.o
\ No newline at end of file
diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
new file mode 100644
index 0000000..e6d3d0e
--- /dev/null
+++ b/drivers/xen/acpi.c
@@ -0,0 +1,23 @@
+#include <xen/acpi.h>
+
+#include <xen/interface/platform.h>
+#include <asm/xen/hypercall.h>
+#include <asm/xen/hypervisor.h>
+
+int acpi_notify_hypervisor_state(u8 sleep_state,
+				 u32 pm1a_cnt, u32 pm1b_cnt)
+{
+	struct xen_platform_op op = {
+		.cmd = XENPF_enter_acpi_sleep,
+		.interface_version = XENPF_INTERFACE_VERSION,
+		.u = {
+			.enter_acpi_sleep = {
+				.pm1a_cnt_val = (u16)pm1a_cnt,
+				.pm1b_cnt_val = (u16)pm1b_cnt,
+				.sleep_state = sleep_state,
+			},
+		},
+	};
+
+	return HYPERVISOR_dom0_op(&op);
+}
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index cc40102..f39f396 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -372,6 +372,12 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state);
 
 acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state);
 
+acpi_status __weak arch_acpi_enter_sleep_state(u8 sleep_state,
+					       u32 PM1Acontrol, u32 PM1Bcontrol);
+
+acpi_status default_acpi_enter_sleep_state(u8 sleep_state,
+					   u32 PM1Acontrol, u32 PM1Bcontrol);
+
 acpi_status asmlinkage acpi_enter_sleep_state_s4bios(void);
 
 acpi_status acpi_leave_sleep_state_prep(u8 sleep_state);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
new file mode 100644
index 0000000..fea4cfb
--- /dev/null
+++ b/include/xen/acpi.h
@@ -0,0 +1,23 @@
+#ifndef _XEN_ACPI_H
+#define _XEN_ACPI_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_XEN_S3
+#include <asm/xen/hypervisor.h>
+
+static inline bool xen_pv_acpi(void)
+{
+	return xen_pv_domain();
+}
+#else
+static inline bool xen_pv_acpi(void)
+{
+	return false;
+}
+#endif
+
+int acpi_notify_hypervisor_state(u8 sleep_state,
+				 u32 pm1a_cnt, u32 pm1b_cnd);
+
+#endif	/* _XEN_ACPI_H */


