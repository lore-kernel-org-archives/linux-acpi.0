From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hp dv8000t dead on resume from RAM
Date: Tue, 8 Aug 2006 22:30:54 +0200
Message-ID: <200608082230.54788.rjw@sisk.pl>
References: <1155057311.44d8c69f3f2fc@webmail.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:21977 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932227AbWHHUbv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Aug 2006 16:31:51 -0400
In-Reply-To: <1155057311.44d8c69f3f2fc@webmail.stanford.edu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brannon Barrett Klopfer <bklopfer@stanford.edu>
Cc: linux-acpi@vger.kernel.org, acpi@linux.intel.com

On Tuesday 08 August 2006 19:15, Brannon Barrett Klopfer wrote:
> Howdy,
> 
> My hp dv8000t (core duo) is completely dead on resume from RAM (no caps
> lock, sysrq, netconsole,
> nothing). I've tried a recent (2.6.18-rc4) kernel running almost entirely
> naked, so to speak (~990K) -- no support for:
> 
> SMP
> preempt
> modules
> networking (+ enet drivers, unless running netconsole)
> USB and SATA (not at same time; rootfs is either usb drive or SATA [ext2/3])
> FireWire
> cpufreq
> framebuffer (vga=0)
> audio
> PCMCIA
> IDE (for cdrom)
> 
> I've tried both native SATA (ahci) and legacy (ata_piix), but same result
> w/both -- completely dead on resume from RAM. Blindly entering commands
> does nothing, and running "$suspend ; $shutdown" does nothing either. I've
> also tried with and without noapic, and a number of other kernel
> paramaters, but nothing seems to work.
> 
> Be more than happy to try out patches, etc. to get this thing working.
> Additionally, if someone could point me to that "beep on resume" patch,
> that'd be great.

First, please apply the appended patch and try the following:

(1)
# echo testproc > /sys/power/disk
# echo disk > /sys/power/state

This should turn off the non-boot CPU, freeze all processes, wait for 5
seconds and then thaw the processes and the CPU.

(2)
# echo test > /sys/power/disk
# echo disk > /sys/power/state

This should turn off the non-boot CPU, freeze all processes, shrink
memory, suspend all devices, wait for 5 seconds, resume the devices etc.
IOW it does everything that's needed for a suspend except for actually
suspending.

Greetings,
Rafael

---
 include/linux/pm.h  |    4 +++-
 kernel/power/disk.c |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 31 insertions(+), 10 deletions(-)

Index: linux-2.6.18-rc3-mm2/include/linux/pm.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/include/linux/pm.h
+++ linux-2.6.18-rc3-mm2/include/linux/pm.h
@@ -116,7 +116,9 @@ typedef int __bitwise suspend_disk_metho
 #define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
 #define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
 #define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 5)
+#define	PM_DISK_TEST		((__force suspend_disk_method_t) 5)
+#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
Index: linux-2.6.18-rc3-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/disk.c
+++ linux-2.6.18-rc3-mm2/kernel/power/disk.c
@@ -70,7 +70,7 @@ static inline void platform_finish(void)
 
 static int prepare_processes(void)
 {
-	int error;
+	int error = 0;
 
 	pm_prepare_console();
 
@@ -83,6 +83,12 @@ static int prepare_processes(void)
 		goto thaw;
 	}
 
+	if (pm_disk_mode == PM_DISK_TESTPROC) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto thaw;
+	}
+
 	/* Free memory before shutting down devices. */
 	if (!(error = swsusp_shrink_memory()))
 		return 0;
@@ -119,11 +125,19 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
+	if (pm_disk_mode == PM_DISK_TESTPROC)
+		goto Thaw;
+
 	error = device_suspend(PMSG_FREEZE);
 	if (error) {
 		printk("Some devices failed to suspend\n");
-		unprepare_processes();
-		return error;
+		goto Thaw;
+	}
+
+	if (pm_disk_mode == PM_DISK_TEST) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto Done;
 	}
 
 	pr_debug("PM: snapshotting memory.\n");
@@ -139,15 +153,16 @@ int pm_suspend_disk(void)
 			power_down(pm_disk_mode);
 		else {
 			swsusp_free();
-			unprepare_processes();
-			return error;
+			goto Thaw;
 		}
-	} else
+	} else {
 		pr_debug("PM: Image restored successfully.\n");
+	}
 
 	swsusp_free();
  Done:
 	device_resume();
+ Thaw:
 	unprepare_processes();
 	return error;
 }
@@ -241,6 +256,8 @@ static const char * const pm_disk_modes[
 	[PM_DISK_PLATFORM]	= "platform",
 	[PM_DISK_SHUTDOWN]	= "shutdown",
 	[PM_DISK_REBOOT]	= "reboot",
+	[PM_DISK_TEST]		= "test",
+	[PM_DISK_TESTPROC]	= "testproc",
 };
 
 /**
@@ -295,17 +312,19 @@ static ssize_t disk_store(struct subsyst
 		}
 	}
 	if (mode) {
-		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT)
+		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT ||
+		     mode == PM_DISK_TEST || mode == PM_DISK_TESTPROC) {
 			pm_disk_mode = mode;
-		else {
+		} else {
 			if (pm_ops && pm_ops->enter &&
 			    (mode == pm_ops->pm_disk_mode))
 				pm_disk_mode = mode;
 			else
 				error = -EINVAL;
 		}
-	} else
+	} else {
 		error = -EINVAL;
+	}
 
 	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
 		 pm_disk_modes[mode]);
