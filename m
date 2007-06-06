From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH 8/8] cpuidle: first round of documentation updates
Date: Wed, 6 Jun 2007 13:56:41 -0700
Message-ID: <20070606205641.GH23906@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936144AbXFFVAj@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Adam Belay <abelay@novell.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



Documentation changes based on Pavel's feedback.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.22-rc-mm/Documentation/cpuidle/sysfs.txt
===================================================================
--- linux-2.6.22-rc-mm.orig/Documentation/cpuidle/sysfs.txt	2007-06-06 11:33:25.000000000 -0700
+++ linux-2.6.22-rc-mm/Documentation/cpuidle/sysfs.txt	2007-06-06 11:35:37.000000000 -0700
@@ -4,14 +4,22 @@
 
 				cpuidle sysfs
 
-System global cpuidle information are under
+System global cpuidle related information and tunables are under
 /sys/devices/system/cpu/cpuidle
 
 The current interfaces in this directory has self-explanatory names:
+* current_driver_ro
+* current_governor_ro
+
+With cpuidle_sysfs_switch boot option (meant for developer testing)
+following objects are visible instead.
 * available_drivers
 * available_governors
 * current_driver
 * current_governor
+In this case user can switch the driver, governor at run time by writing
+onto current_driver and current_governor.
+
 
 Per logical CPU specific cpuidle information are under
 /sys/devices/system/cpu/cpuX/cpuidle
@@ -19,9 +27,9 @@
 
 Under this percpu directory, there is a directory for each idle state supported
 by the driver, which in turn has
-* latency
-* power
-* time
-* usage
+* latency : Latency to exit out of this idle state (in microseconds)
+* power : Power consumed while in this idle state (in milliwatts)
+* time : Total time spent in this idle state (in microseconds)
+* usage : Number of times this state was entered (count)
 
 
Index: linux-2.6.22-rc-mm/Documentation/cpuidle/governor.txt
===================================================================
--- linux-2.6.22-rc-mm.orig/Documentation/cpuidle/governor.txt	2007-06-06 11:33:25.000000000 -0700
+++ linux-2.6.22-rc-mm/Documentation/cpuidle/governor.txt	2007-06-06 11:33:34.000000000 -0700
@@ -11,12 +11,16 @@
 cpuidle governor is policy routine that decides what idle state to enter at
 any given time. cpuidle core uses different callbacks to governor while
 handling idle entry.
-* select_state callback where governor can determine next idle state to enter
-* prepare_idle callback is called before entering an idle state
-* scan callback is called after a driver forces redetection of the states
+* select_state() callback where governor can determine next idle state to enter
+* prepare_idle() callback is called before entering an idle state
+* scan() callback is called after a driver forces redetection of the states
 
 More than one governor can be registered at the same time and
-user can switch between drivers using /sysfs interface.
+user can switch between drivers using /sysfs interface (when supported).
+
+More than one governor part is supported for developers to easily experiment
+with different governors. By default, most optimal governor based on your
+kernel configuration and platform will be selected by cpuidle.
 
 Interfaces:
 int cpuidle_register_governor(struct cpuidle_governor *gov);
Index: linux-2.6.22-rc-mm/Documentation/cpuidle/core.txt
===================================================================
--- linux-2.6.22-rc-mm.orig/Documentation/cpuidle/core.txt	2007-06-06 11:33:25.000000000 -0700
+++ linux-2.6.22-rc-mm/Documentation/cpuidle/core.txt	2007-06-06 11:33:34.000000000 -0700
@@ -12,6 +12,6 @@
 standardized infrastructure to support independent development of
 governors and drivers.
 
-cpuidle resides under /drivers/cpuidle.
+cpuidle resides under drivers/cpuidle.
 
 
Index: linux-2.6.22-rc-mm/Documentation/cpuidle/driver.txt
===================================================================
--- linux-2.6.22-rc-mm.orig/Documentation/cpuidle/driver.txt	2007-06-06 11:33:25.000000000 -0700
+++ linux-2.6.22-rc-mm/Documentation/cpuidle/driver.txt	2007-06-06 11:33:34.000000000 -0700
@@ -7,16 +7,21 @@
 
 
 
-cpuidle driver supports capability detection for a particular system. The
-init and exit routines will be called for each online CPU, with a percpu
-cpuidle_driver object and driver should fill in cpuidle_states inside
-cpuidle_driver depending on the CPU capability.
+cpuidle driver hooks into the cpuidle infrastructure and does the
+architecture/platform dependent part of CPU idle states. Driver
+provides the platform idle state detection capability and also
+has mechanisms in place to support actusl entry-exit into a CPU idle state.
+
+cpuidle driver supports capability detection for a platform using the
+init and exit routines. They will be called for each online CPU, with a
+percpu cpuidle_driver object and driver should fill in cpuidle_states
+inside cpuidle_driver depending on the CPU capability.
 
 Driver can handle dynamic state changes (like battery<->AC), by calling
 force_redetect interface.
 
 It is possible to have more than one driver registered at the same time and
-user can switch between drivers using /sysfs interface.
+user can switch between drivers using /sysfs interface (when enabled).
 
 Interfaces:
 int cpuidle_register_driver(struct cpuidle_driver *drv);
