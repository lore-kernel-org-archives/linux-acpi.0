From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/22] cpuidle take2: Basic documentation for cpuidle
Date: Fri,  9 Mar 2007 23:00:40 -0500
Message-ID: <11734992634177-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:16045 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752837AbXCJEBE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:04 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <c5bb38e598e68202e0d6f08b3fe0f30f12999357.1173498651.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Adam Belay <abelay@novell.com>, Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Documentation for cpuidle infrastructure

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Adam Belay <abelay@novell.com>
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/cpuidle/core.txt     |   17 +++++++++++++++++
 Documentation/cpuidle/driver.txt   |   24 ++++++++++++++++++++++++
 Documentation/cpuidle/governor.txt |   24 ++++++++++++++++++++++++
 Documentation/cpuidle/sysfs.txt    |   27 +++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/cpuidle/core.txt
 create mode 100644 Documentation/cpuidle/driver.txt
 create mode 100644 Documentation/cpuidle/governor.txt
 create mode 100644 Documentation/cpuidle/sysfs.txt

diff --git a/Documentation/cpuidle/core.txt b/Documentation/cpuidle/core.txt
new file mode 100644
index 0000000..e686cfc
--- /dev/null
+++ b/Documentation/cpuidle/core.txt
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
+cpuidle resides under /drivers/cpuidle.
+
+
diff --git a/Documentation/cpuidle/driver.txt b/Documentation/cpuidle/driver.txt
new file mode 100644
index 0000000..2dbee4b
--- /dev/null
+++ b/Documentation/cpuidle/driver.txt
@@ -0,0 +1,24 @@
+
+
+		Supporting multiple CPU idle levels in kernel
+
+				cpuidle drivers
+
+
+
+
+cpuidle driver supports capability detection for a particular system. The
+init and exit routines will be called for each online CPU, with a percpu
+cpuidle_driver object and driver should fill in cpuidle_states inside
+cpuidle_driver depending on the CPU capability.
+
+Driver can handle dynamic state changes (like battery<->AC), by calling
+force_redetect interface.
+
+It is possible to have more than one driver registered at the same time and
+user can switch between drivers using /sysfs interface.
+
+Interfaces:
+int cpuidle_register_driver(struct cpuidle_driver *drv);
+void cpuidle_unregister_driver(struct cpuidle_driver *drv);
+int cpuidle_force_redetect(struct cpuidle_device *dev);
diff --git a/Documentation/cpuidle/governor.txt b/Documentation/cpuidle/governor.txt
new file mode 100644
index 0000000..a0fc3e5
--- /dev/null
+++ b/Documentation/cpuidle/governor.txt
@@ -0,0 +1,24 @@
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
+any given time. cpuidle core uses different callbacks to governor while
+handling idle entry.
+* select_state callback where governor can determine next idle state to enter
+* prepare_idle callback is called before entering an idle state
+* scan callback is called after a driver forces redetection of the states
+
+More than one governor can be registered at the same time and
+user can switch between drivers using /sysfs interface.
+
+Interfaces:
+int cpuidle_register_governor(struct cpuidle_governor *gov);
+void cpuidle_unregister_governor(struct cpuidle_governor *gov);
+
diff --git a/Documentation/cpuidle/sysfs.txt b/Documentation/cpuidle/sysfs.txt
new file mode 100644
index 0000000..7fbf644
--- /dev/null
+++ b/Documentation/cpuidle/sysfs.txt
@@ -0,0 +1,27 @@
+
+
+		Supporting multiple CPU idle levels in kernel
+
+				cpuidle sysfs
+
+System global cpuidle information are under
+/sys/devices/system/cpu/cpuidle
+
+The current interfaces in this directory has self-explanatory names:
+* available_drivers
+* available_governors
+* current_driver
+* current_governor
+
+Per logical CPU specific cpuidle information are under
+/sys/devices/system/cpu/cpuX/cpuidle
+for each online cpu X
+
+Under this percpu directory, there is a directory for each idle state supported
+by the driver, which in turn has
+* latency
+* power
+* time
+* usage
+
+
-- 
1.5.0.3.310.g05ef5
