From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S1 resume stopped working
Date: Tue, 29 Jun 2004 00:50:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040628225025.GB11333@elf.ucw.cz>
References: <Pine.LNX.4.44.0406171127200.9804-100000@math.cudenver.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0406171127200.9804-100000-o2OswTf4RFv//ikEAC0814dd74u8MsAO@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Tod Morrison <trmorris-CxZjHwuTSy8Y3NgEzsZOoze48wsgrGvP@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I just trying to track down the source of the problem. Currently I can 
> suspend and resume (S1) using the 2.6.5-gentoo kernel as long as I unload 
> the alsa modules first. I just tried the vanilla 2.6.7 kernel with the 
> same config (zcat /proc/config.gz > .config ; make oldconfig ) and cannot 
> resume. Suspend works fine, but on resume I make it as far as "PM: 
> Finishing up." and locks up.
> 
> Anyway, by inserting some pr_debug statements I've tracked it down to a 
> section of code in resume.c where it traverses a list of devices changing 
> their power state and it appears to go through about eight devices before 
> it locks. I'd like to see if I can track down which device is causing the 
> problem, but I don't really know my way around the kernel much any more. 
> Could someone give me an example of how to print out which device I'm at 
> given a "struct device" and maybe something like pr_debug()?
> 
> Of course if anyone just knows what changed between 2.6.5-gentoo and 2.6.7 
> that is causing this, that info would make this exercise unnecessary. :)

Something like this?

--- tmp/linux/drivers/base/power/shutdown.c	2004-06-22 12:36:02.000000000 +0200
+++ linux/drivers/base/power/shutdown.c	2004-06-22 12:37:57.000000000 +0200
@@ -8,6 +8,7 @@
  *
  */
 
+#define DEBUG
 #include <linux/config.h>
 #include <linux/device.h>
 #include <asm/semaphore.h>
@@ -52,14 +53,14 @@
 	struct device * dev;
 	
 	down_write(&devices_subsys.rwsem);
+	printk("Shutting down devices: ");
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
-		pr_debug("shutting down %s: ",dev->bus_id);
 		if (dev->driver && dev->driver->shutdown) {
-			pr_debug("Ok\n");
+			printk("%s, ",dev->bus_id);
 			dev->driver->shutdown(dev);
-		} else
-			pr_debug("Ignored.\n");
+		}
 	}
+	printk("ok\n");
 	up_write(&devices_subsys.rwsem);
 
 	sysdev_shutdown();
--- tmp/linux/drivers/base/power/suspend.c	2004-06-22 12:36:02.000000000 +0200
+++ linux/drivers/base/power/suspend.c	2004-06-22 12:37:57.000000000 +0200
@@ -117,10 +117,13 @@
 	int error = 0;
 	struct device * dev;
 
+	printk("Powering down devices: ");
 	list_for_each_entry_reverse(dev,&dpm_off_irq,power.entry) {
+		printk("%s ", dev->bus_id);
 		if ((error = suspend_device(dev,state)))
 			break;
 	} 
+	printk("ok?\n"); 
 	if (error)
 		goto Error;
 	if ((error = sysdev_suspend(state)))
--- tmp/linux/drivers/base/sys.c	2004-06-22 12:36:02.000000000 +0200
+++ linux/drivers/base/sys.c	2004-06-22 12:37:57.000000000 +0200
@@ -305,18 +305,17 @@
 {
 	struct sysdev_class * cls;
 
-	pr_debug("Suspending System Devices\n");
+	printk("Suspending System Devices: ");
 
 	list_for_each_entry_reverse(cls,&system_subsys.kset.list,
 				    kset.kobj.entry) {
 		struct sys_device * sysdev;
 
-		pr_debug("Suspending type '%s':\n",
-			 kobject_name(&cls->kset.kobj));
+		printk("%s: ", kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			printk(" %s, ",kobject_name(&sysdev->kobj));
 
 			/* Call global drivers first. */
 			list_for_each_entry(drv,&global_drivers,entry) {
@@ -335,6 +334,7 @@
 				cls->suspend(sysdev,state);
 		}
 	}
+	printk("ok\n");
 	return 0;
 }
 
@@ -352,17 +352,16 @@
 {
 	struct sysdev_class * cls;
 
-	pr_debug("Resuming System Devices\n");
+	printk("Resuming System Devices: ");
 
 	list_for_each_entry(cls,&system_subsys.kset.list,kset.kobj.entry) {
 		struct sys_device * sysdev;
 
-		pr_debug("Resuming type '%s':\n",
-			 kobject_name(&cls->kset.kobj));
+		printk("%s: ", kobject_name(&cls->kset.kobj));
 
 		list_for_each_entry(sysdev,&cls->kset.list,kobj.entry) {
 			struct sysdev_driver * drv;
-			pr_debug(" %s\n",kobject_name(&sysdev->kobj));
+			printk(" %s, ",kobject_name(&sysdev->kobj));
 
 			/* First, call the class-specific one */
 			if (cls->resume)
@@ -382,6 +381,7 @@
 
 		}
 	}
+	printk("ok\n");
 	return 0;
 }
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
