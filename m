From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Paravirtualizing bits of acpi access
Date: Fri, 20 Mar 2009 23:09:59 -0700
Message-ID: <49C484B7.20100@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080502090001080103080404"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:36260 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752072AbZCUGKE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Mar 2009 02:10:04 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, Xen-devel <xen-devel@lists.xensource.com>, the arch/x86 maintainers <x86@kernel.org>

This is a multi-part message in MIME format.
--------------080502090001080103080404
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Len,

I have a patch here ported from the linux2.6.18-xen tree to make host S3 
suspend work under Xen (attached).

The salient part is this:

--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -46,6 +46,9 @@
 #include "accommon.h"
 #include "actables.h"
 
+#include <xen/acpi.h>
+#include <asm/xen/hypervisor.h>
+
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
 
@@ -337,14 +340,19 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
-					PM1Acontrol);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	if (!xen_pv_domain()) {
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
+						PM1Acontrol);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
+						PM1Bcontrol);
+	} else
+		status = acpi_notify_hypervisor_state(sleep_state,
+						      PM1Acontrol, PM1Bcontrol);
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
-					PM1Bcontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}


where acpi_notify_hypervisor_state() more or less maps directly onto a 
Xen hypercall, which in turn performs the corresponding acpi operation 
from within Xen.

I'm guessing you won't find this patch appealing as-is because it sticks 
a great big if (xen) into an otherwise arch (and OS?) independent piece 
of code.  In this particular instance, its fairly easy to envisage 
encapsulating these two register writes into their own function which 
architectures can override, which makes it fairly easy for me to put a 
Xen hook in somewhere on the arch/x86 side of the fence.

But because Xen ends up doing the low-level cpu state save/restore, 
several other parts of the S3 suspend path can be skipped on the Linux 
side.  I'm wondering if you have any thoughts about how that can be 
done, or if putting the Xen code in as-is is acceptable?

(BTW, xen_pv_domain() expands to a constant 0 when Xen isn't enabled in 
the config, so the Xen-dependent bits will collapse down to nothing.  
But it is defined in asm/xen/hypervisor.h, which is only present on x86 
and ia64 architectures; on the other hand, believe those are the only 
architectures using acpi.)

Thanks,
    J

--------------080502090001080103080404
Content-Type: text/x-patch;
 name="xen-s3-sleep.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xen-s3-sleep.patch"

>From 7bdec2cce7de8fb41207238c61f3075220c70a55 Mon Sep 17 00:00:00 2001
From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Date: Mon, 23 Feb 2009 00:06:06 -0800
Subject: [PATCH] xen: Enable ACPI sleep in Xen

Open CONFIG_ACPI_SLEEP in xenlinux, to enable ACPI based
power management. Basically, user can trigger power event
now by "echo *** > /sys/power/state". Also gear to pm
interface defined between xenlinux and Xen.

Also sync to xen interface headers consequently

[ From http://xenbits.xensource.com/linux-2.6.18-xen.hg
 change c68699484a65 ]

Signed-off-by Ke Yu <ke.yu@intel.com>
Signed-off-by Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 7c243a2..a89de8d 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -12,6 +12,8 @@
 #include <asm/segment.h>
 #include <asm/desc.h>
 
+#include <asm/xen/hypervisor.h>
+
 #include "realmode/wakeup.h"
 #include "sleep.h"
 
@@ -37,6 +39,9 @@ int acpi_save_state_mem(void)
 {
 	struct wakeup_header *header;
 
+	if (xen_pv_domain())
+		return 0;	/* Xen will do this for us */
+
 	if (!acpi_realmode) {
 		printk(KERN_ERR "Could not allocate memory during boot, "
 		       "S3 disabled\n");
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index a2af2a4..bf719f1 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -46,6 +46,9 @@
 #include "accommon.h"
 #include "actables.h"
 
+#include <xen/acpi.h>
+#include <asm/xen/hypervisor.h>
+
 #define _COMPONENT          ACPI_HARDWARE
 ACPI_MODULE_NAME("hwsleep")
 
@@ -337,14 +340,19 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 
 	ACPI_FLUSH_CPU_CACHE();
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
-					PM1Acontrol);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
+	if (!xen_pv_domain()) {
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1A_CONTROL,
+						PM1Acontrol);
+		if (ACPI_FAILURE(status)) {
+			return_ACPI_STATUS(status);
+		}
+
+		status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
+						PM1Bcontrol);
+	} else
+		status = acpi_notify_hypervisor_state(sleep_state,
+						      PM1Acontrol, PM1Bcontrol);
 
-	status = acpi_hw_register_write(ACPI_REGISTER_PM1B_CONTROL,
-					PM1Bcontrol);
 	if (ACPI_FAILURE(status)) {
 		return_ACPI_STATUS(status);
 	}
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 5192666..c855dec 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -59,7 +59,7 @@ static int acpi_sleep_prepare(u32 acpi_state)
 {
 #ifdef CONFIG_ACPI_SLEEP
 	/* do we have a wakeup address for S2 and S3? */
-	if (acpi_state == ACPI_STATE_S3) {
+	if (!xen_pv_domain() && acpi_state == ACPI_STATE_S3) {
 		if (!acpi_wakeup_address) {
 			return -EFAULT;
 		}
@@ -242,7 +242,16 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 		break;
 
 	case ACPI_STATE_S3:
-		do_suspend_lowlevel();
+		if (!xen_pv_domain())
+			do_suspend_lowlevel();
+		else {
+			/*
+			 * Xen will save and restore CPU context, so
+			 * we can skip that and just go straight to
+			 * the suspend.
+			 */
+			acpi_enter_sleep_state(acpi_state);
+		}
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
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
new file mode 100644
index 0000000..0d1e462
--- /dev/null
+++ b/include/xen/acpi.h
@@ -0,0 +1,9 @@
+#ifndef _XEN_ACPI_H
+#define _XEN_ACPI_H
+
+#include <linux/types.h>
+
+int acpi_notify_hypervisor_state(u8 sleep_state,
+				 u32 pm1a_cnt, u32 pm1b_cnd);
+
+#endif	/* _XEN_ACPI_H */

--------------080502090001080103080404--
