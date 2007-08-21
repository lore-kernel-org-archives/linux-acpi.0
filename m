From: Adam Belay <abelay@novell.com>
Subject: [PATCH 6/6] CPUIDLE: load ACPI properly when CPUIDLE is disabled
Date: Tue, 21 Aug 2007 18:27:07 -0400
Message-ID: <1187735227.7199.56.camel@callisto.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from peabody.ximian.com ([130.57.169.10]:43646 "EHLO
	peabody.ximian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbXHUWdz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Aug 2007 18:33:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Brown@vger.kernel.org, Len <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Shaohua Li <shaohua.li@intel.com>

This patch changes the registration return codes for when CPUIDLE
support is not compiled into the kernel.  As a result, the ACPI
processor driver will load properly even if CPUIDLE is unavailable.
However, it may be possible to cleanup the ACPI processor driver further
and eliminate some dead code paths.

Please Apply,
Adam

Change Summary:
 cpuidle.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
---

--- a/include/linux/cpuidle.h	2007-08-21 17:33:17.000000000 -0400
+++ b/include/linux/cpuidle.h	2007-08-21 17:30:54.000000000 -0400
@@ -132,16 +132,16 @@
 #else
 
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
-{return -EIO;}
+{return 0;}
 static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
 static inline int cpuidle_register_device(struct cpuidle_device *dev)
-{return -EIO;}
+{return 0;}
 static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
 
 static inline void cpuidle_pause_and_lock(void) { }
 static inline void cpuidle_resume_and_unlock(void) { }
 static inline int cpuidle_enable_device(struct cpuidle_device *dev)
-{return -EIO;}
+{return 0;}
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 
 #endif


