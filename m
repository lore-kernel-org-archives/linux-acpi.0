From: Dirk Meul <dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: [PATCH] reenable rtc alarm interrupt in acpi_power_off
Date: Mon, 10 Nov 2003 19:41:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1068489717.1312.6.camel@aragorn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_5gWw9jDeQ47aOfDfnW3D7Q)"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary_(ID_5gWw9jDeQ47aOfDfnW3D7Q)
Content-type: text/plain
Content-transfer-encoding: 7BIT

Hello!

I need attached patch for powering on my computer by the RTC alarm
clock. The lines are copied from drivers/acpi/sleep/proc.c. With this
patch i'm able to set the wakeup time with /proc/acpi/alarm. Without
this patch this will only work for S1, so it maybe that i will need a
similar patch for S3.

Regards,
-- 
                           /"\
Dirk Meul                  \ /    ASCII Ribbon Campaign
dirk.meul-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org    X     Against HTML Mail
                           / \

--Boundary_(ID_5gWw9jDeQ47aOfDfnW3D7Q)
Content-type: text/x-patch; name=fix-rtc-alarm-interrupt.diff; charset=UTF-8
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=fix-rtc-alarm-interrupt.diff

--- linux-2.6.0-test9/drivers/acpi/sleep/poweroff.c	2003-09-28 02:51:07.000000000 +0200
+++ linux-2.6.0-test9-dm2/drivers/acpi/sleep/poweroff.c	2003-11-10 18:30:28.000000000 +0100
@@ -9,12 +9,25 @@
 #include <linux/init.h>
 #include <acpi/acpi_bus.h>
 
+#ifdef CONFIG_X86
+#include <linux/mc146818rtc.h>
+#endif
+
 static void
 acpi_power_off (void)
 {
+	unsigned char rtc_control = 0;
+	
 	printk("%s called\n",__FUNCTION__);
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();
+	/* enable the rtc alarm interrupt */
+	rtc_control = CMOS_READ(RTC_CONTROL);
+	if (!(rtc_control & RTC_AIE)) {
+		rtc_control |= RTC_AIE;
+		CMOS_WRITE(rtc_control,RTC_CONTROL);
+		CMOS_READ(RTC_INTR_FLAGS);
+	}
 	acpi_enter_sleep_state(ACPI_STATE_S5);
 }
 

--Boundary_(ID_5gWw9jDeQ47aOfDfnW3D7Q)--


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
