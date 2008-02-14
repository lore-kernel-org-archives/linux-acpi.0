From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/11] cpuidle: Add Documentation
Date: Thu, 14 Feb 2008 02:02:24 -0500
Message-ID: <fe8e288a63f2f3c51c288500282d0eb5cd26a534.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21951 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755646AbYBNHKn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:43 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Documentation for cpuidle infrastructure. (resend)

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Reviewed-by: Randy Dunlap <randy.dunlap@oracle.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/00-INDEX             |    2 +
 Documentation/cpuidle/core.txt     |   23 ++++++++++
 Documentation/cpuidle/driver.txt   |   31 ++++++++++++++
 Documentation/cpuidle/governor.txt |   29 +++++++++++++
 Documentation/cpuidle/sysfs.txt    |   79 ++++++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/cpuidle/core.txt
 create mode 100644 Documentation/cpuidle/driver.txt
 create mode 100644 Documentation/cpuidle/governor.txt
 create mode 100644 Documentation/cpuidle/sysfs.txt

diff --git a/Documentation/00-INDEX b/Documentation/00-INDEX
index 8d55670..30b327a 100644
--- a/Documentation/00-INDEX
+++ b/Documentation/00-INDEX
@@ -109,6 +109,8 @@ cpu-hotplug.txt
 	- document describing CPU hotplug support in the Linux kernel.
 cpu-load.txt
 	- document describing how CPU load statistics are collected.
+cpuidle/
+	- info on CPU_IDLE, CPU idle state management subsystem.
 cpusets.txt
 	- documents the cpusets feature; assign CPUs and Mem to a set of tasks.
 cputopology.txt
diff --git a/Documentation/cpuidle/core.txt b/Documentation/cpuidle/core.txt
new file mode 100644
index 0000000..63ecc5d
--- /dev/null
+++ b/Documentation/cpuidle/core.txt
@@ -0,0 +1,23 @@
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
+Boot options:
+"cpuidle_sysfs_switch"
+enables current_governor interface in /sys/devices/system/cpu/cpuidle/,
+which can be used to switch governors at run time. This boot option
+is meant for developer testing only. In normal usage, kernel picks the
+best governor based on governor ratings.
+SEE ALSO: sysfs.txt in this directory.
diff --git a/Documentation/cpuidle/driver.txt b/Documentation/cpuidle/driver.txt
new file mode 100644
index 0000000..7a9e09e
--- /dev/null
+++ b/Documentation/cpuidle/driver.txt
@@ -0,0 +1,31 @@
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
diff --git a/Documentation/cpuidle/governor.txt b/Documentation/cpuidle/governor.txt
new file mode 100644
index 0000000..12c6bd5
--- /dev/null
+++ b/Documentation/cpuidle/governor.txt
@@ -0,0 +1,29 @@
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
+users can switch between drivers using /sysfs interface (when enabled).
+More than one governor part is supported for developers to easily experiment
+with different governors. By default, most optimal governor based on your
+kernel configuration and platform will be selected by cpuidle.
+
+Interfaces:
+extern int cpuidle_register_governor(struct cpuidle_governor *gov);
+extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
+struct cpuidle_governor
diff --git a/Documentation/cpuidle/sysfs.txt b/Documentation/cpuidle/sysfs.txt
new file mode 100644
index 0000000..50d7b16
--- /dev/null
+++ b/Documentation/cpuidle/sysfs.txt
@@ -0,0 +1,79 @@
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
+In this case users can switch the governor at run time by writing
+to current_governor.
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
-- 
1.5.4.1.122.gaa8d

