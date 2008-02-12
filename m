From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH] CPU_IDLE: Documentation for CPU_IDLE
Date: Mon, 11 Feb 2008 17:55:45 -0800
Message-ID: <20080212015545.GA1691@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16057 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbYBLBzq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 20:55:46 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


Documentation for cpuidle infrastructure. This patch was submitted once
a while back. But, somehow got dropped or never made it upstream.

Resending with updates.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.25-rc/Documentation/cpuidle/core.txt
===================================================================
--- /dev/null
+++ linux-2.6.25-rc/Documentation/cpuidle/core.txt
@@ -0,0 +1,17 @@
+
+		Supporting multiple CPU idle levels in kernel
+
+				cpuidle
+
+General Information:
+
+Various CPUs today support multiple idle levels that are differentiated
+by varying exit latencies and power consumption during idle.
+cpuidle is a generic in-kernel infrastructure that separates
+idle policy (governor) from idle mechanism (driver) and provides a
+standardized infrastructure to support independent development of
+governors and drivers.
+
+cpuidle resides under drivers/cpuidle.
+
+
Index: linux-2.6.25-rc/Documentation/cpuidle/driver.txt
===================================================================
--- /dev/null
+++ linux-2.6.25-rc/Documentation/cpuidle/driver.txt
@@ -0,0 +1,32 @@
+
+
+		Supporting multiple CPU idle levels in kernel
+
+				cpuidle drivers
+
+
+
+
+cpuidle driver hooks into the cpuidle infrastructure and handles the
+architecture/platform dependent part of CPU idle states. Driver
+provides the platform idle state detection capability and also
+has mechanisms in place to support actual entry-exit into CPU idle states.
+
+cpuidle driver initializes the cpuidle_device structure for each CPU device
+and registers with cpuidle using cpuidle_register_device.
+
+It can also support the dynamic changes (like battery <-> AC), by using
+cpuidle_pause_and_lock, cpuidle_disable_device and cpuidle_enable_device,
+cpuidle_resume_and_unlock.
+
+Interfaces:
+extern int cpuidle_register_driver(struct cpuidle_driver *drv);
+extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
+extern int cpuidle_register_device(struct cpuidle_device *dev);
+extern void cpuidle_unregister_device(struct cpuidle_device *dev);
+
+extern void cpuidle_pause_and_lock(void);
+extern void cpuidle_resume_and_unlock(void);
+extern int cpuidle_enable_device(struct cpuidle_device *dev);
+extern void cpuidle_disable_device(struct cpuidle_device *dev);
+
Index: linux-2.6.25-rc/Documentation/cpuidle/sysfs.txt
===================================================================
--- /dev/null
+++ linux-2.6.25-rc/Documentation/cpuidle/sysfs.txt
@@ -0,0 +1,81 @@
+
+
+		Supporting multiple CPU idle levels in kernel
+
+				cpuidle sysfs
+
+System global cpuidle related information and tunables are under
+/sys/devices/system/cpu/cpuidle
+
+The current interfaces in this directory has self-explanatory names:
+* current_driver
+* current_governor_ro
+
+With cpuidle_sysfs_switch boot option (meant for developer testing)
+following objects are visible instead.
+* current_driver
+* available_governors
+* current_governor
+In this case user can switch the governor at run time by writing
+onto current_governor.
+
+
+Per logical CPU specific cpuidle information are under
+/sys/devices/system/cpu/cpuX/cpuidle
+for each online cpu X
+
+--------------------------------------------------------------------------------
+# ls -lR /sys/devices/system/cpu/cpu0/cpuidle/
+/sys/devices/system/cpu/cpu0/cpuidle/:
+total 0
+drwxr-xr-x 2 root root 0 Feb  8 10:42 state0
+drwxr-xr-x 2 root root 0 Feb  8 10:42 state1
+drwxr-xr-x 2 root root 0 Feb  8 10:42 state2
+drwxr-xr-x 2 root root 0 Feb  8 10:42 state3
+
+/sys/devices/system/cpu/cpu0/cpuidle/state0:
+total 0
+-r--r--r-- 1 root root 4096 Feb  8 10:42 desc
+-r--r--r-- 1 root root 4096 Feb  8 10:42 latency
+-r--r--r-- 1 root root 4096 Feb  8 10:42 name
+-r--r--r-- 1 root root 4096 Feb  8 10:42 power
+-r--r--r-- 1 root root 4096 Feb  8 10:42 time
+-r--r--r-- 1 root root 4096 Feb  8 10:42 usage
+
+/sys/devices/system/cpu/cpu0/cpuidle/state1:
+total 0
+-r--r--r-- 1 root root 4096 Feb  8 10:42 desc
+-r--r--r-- 1 root root 4096 Feb  8 10:42 latency
+-r--r--r-- 1 root root 4096 Feb  8 10:42 name
+-r--r--r-- 1 root root 4096 Feb  8 10:42 power
+-r--r--r-- 1 root root 4096 Feb  8 10:42 time
+-r--r--r-- 1 root root 4096 Feb  8 10:42 usage
+
+/sys/devices/system/cpu/cpu0/cpuidle/state2:
+total 0
+-r--r--r-- 1 root root 4096 Feb  8 10:42 desc
+-r--r--r-- 1 root root 4096 Feb  8 10:42 latency
+-r--r--r-- 1 root root 4096 Feb  8 10:42 name
+-r--r--r-- 1 root root 4096 Feb  8 10:42 power
+-r--r--r-- 1 root root 4096 Feb  8 10:42 time
+-r--r--r-- 1 root root 4096 Feb  8 10:42 usage
+
+/sys/devices/system/cpu/cpu0/cpuidle/state3:
+total 0
+-r--r--r-- 1 root root 4096 Feb  8 10:42 desc
+-r--r--r-- 1 root root 4096 Feb  8 10:42 latency
+-r--r--r-- 1 root root 4096 Feb  8 10:42 name
+-r--r--r-- 1 root root 4096 Feb  8 10:42 power
+-r--r--r-- 1 root root 4096 Feb  8 10:42 time
+-r--r--r-- 1 root root 4096 Feb  8 10:42 usage
+--------------------------------------------------------------------------------
+
+
+* desc : Small description about the idle state (string)
+* latency : Latency to exit out of this idle state (in microseconds)
+* name : Name of the idle state (string)
+* power : Power consumed while in this idle state (in milliwatts)
+* time : Total time spent in this idle state (in microseconds)
+* usage : Number of times this state was entered (count)
+
+
Index: linux-2.6.25-rc/Documentation/cpuidle/governor.txt
===================================================================
--- /dev/null
+++ linux-2.6.25-rc/Documentation/cpuidle/governor.txt
@@ -0,0 +1,30 @@
+
+
+
+		Supporting multiple CPU idle levels in kernel
+
+				cpuidle governors
+
+
+
+
+cpuidle governor is policy routine that decides what idle state to enter at
+any given time. cpuidle core uses different callbacks to the governor.
+
+* enable() to enable governor for a particular device
+* disable() to disable governor for a particular device
+* select() to select an idle state to enter
+* reflect() called after returning from the idle state, which can be used
+  by the governor for some record keeping.
+
+More than one governor can be registered at the same time and
+user can switch between drivers using /sysfs interface (when enabled).
+More than one governor part is supported for developers to easily experiment
+with different governors. By default, most optimal governor based on your
+kernel configuration and platform will be selected by cpuidle.
+
+Interfaces:
+extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
+struct cpuidle_governor
+
Index: linux-2.6.25-rc/Documentation/00-INDEX
===================================================================
--- linux-2.6.25-rc.orig/Documentation/00-INDEX
+++ linux-2.6.25-rc/Documentation/00-INDEX
@@ -106,6 +106,8 @@ cpu-hotplug.txt
 	- document describing CPU hotplug support in the Linux kernel.
 cpu-load.txt
 	- document describing how CPU load statistics are collected.
+cpuidle/
+	- info on CPU_IDLE, CPU idle state management subsystem.
 cpusets.txt
 	- documents the cpusets feature; assign CPUs and Mem to a set of tasks.
 cputopology.txt
