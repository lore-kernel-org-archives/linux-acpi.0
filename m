From: Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
Subject: Re: [PM]/proc/acpi/alarm halfway working
Date: Fri, 10 Oct 2003 15:34:35 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310101532550.3605-100000@cherise>
References: <20030927234630.GA32525@hell.org.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030927234630.GA32525-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


> I've just tested 2.6.0-test5-mm4, it seems that the /proc/acpi/alarm
> has ceased to deadlock my laptop and actually started to work as
> expected. The only drawback is:
> #v+
> irq 9: nobody cared!

Sorry it's taken so long to reply, but I've finally had a chance to track 
this down. Could you try the following patch and let me know if it fixes 
the problem for you? 

Thanks,


	Pat

===== drivers/acpi/utilities/utglobal.c 1.28 vs edited =====
--- 1.28/drivers/acpi/utilities/utglobal.c	Sun Jul 13 16:07:33 2003
+++ edited/drivers/acpi/utilities/utglobal.c	Thu Oct  9 14:27:16 2003
@@ -358,7 +358,7 @@
 	/* ACPI_EVENT_GLOBAL        */  {ACPI_BITREG_GLOBAL_LOCK_STATUS,    ACPI_BITREG_GLOBAL_LOCK_ENABLE,  ACPI_BITMASK_GLOBAL_LOCK_STATUS,    ACPI_BITMASK_GLOBAL_LOCK_ENABLE},
 	/* ACPI_EVENT_POWER_BUTTON  */  {ACPI_BITREG_POWER_BUTTON_STATUS,   ACPI_BITREG_POWER_BUTTON_ENABLE, ACPI_BITMASK_POWER_BUTTON_STATUS,   ACPI_BITMASK_POWER_BUTTON_ENABLE},
 	/* ACPI_EVENT_SLEEP_BUTTON  */  {ACPI_BITREG_SLEEP_BUTTON_STATUS,   ACPI_BITREG_SLEEP_BUTTON_ENABLE, ACPI_BITMASK_SLEEP_BUTTON_STATUS,   ACPI_BITMASK_SLEEP_BUTTON_ENABLE},
-	/* ACPI_EVENT_RTC           */  {ACPI_BITREG_RT_CLOCK_STATUS,       ACPI_BITREG_RT_CLOCK_ENABLE,     0,                                  0},
+	/* ACPI_EVENT_RTC           */  {ACPI_BITREG_RT_CLOCK_STATUS,       ACPI_BITREG_RT_CLOCK_ENABLE,	ACPI_BITMASK_RT_CLOCK_STATUS,	ACPI_BITMASK_RT_CLOCK_ENABLE},
 };
 
 /*****************************************************************************
===== drivers/acpi/sleep/proc.c 1.7 vs edited =====
--- 1.7/drivers/acpi/sleep/proc.c	Wed Sep 10 09:27:28 2003
+++ edited/drivers/acpi/sleep/proc.c	Fri Oct 10 10:05:36 2003
@@ -1,3 +1,4 @@
+#include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
@@ -370,6 +371,14 @@
 };
 
 
+static u32 rtc_handler(void * context)
+{
+	acpi_set_register(ACPI_BITREG_RT_CLOCK_STATUS, 1, ACPI_MTX_LOCK);
+	acpi_set_register(ACPI_BITREG_RT_CLOCK_ENABLE, 0, ACPI_MTX_LOCK);
+	return IRQ_HANDLED;
+}
+
+
 static int acpi_sleep_proc_init(void)
 {
 	struct proc_dir_entry	*entry = NULL;
@@ -385,6 +394,8 @@
 		S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
+
+	acpi_install_fixed_event_handler(ACPI_EVENT_RTC, rtc_handler, NULL);
 	return 0;
 }
 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
