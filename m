From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/22] cpuidle: build fix for !CPU_IDLE
Date: Fri,  9 Mar 2007 23:00:44 -0500
Message-ID: <11734992661467-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:27693 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752848AbXCJEBI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:08 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <d98b2065c5ac31a35cbdfe9b47d421352f96fc3f.1173498653.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Fix the compile issues when CPU_IDLE is not configured.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Adam Belay <abelay@novell.com>
Cc: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/linux/cpuidle.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index d26a82e..4a41f42 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -130,10 +130,21 @@ struct cpuidle_driver {
 	struct module 		*owner;
 };
 
+#ifdef CONFIG_CPU_IDLE
+
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
 extern int cpuidle_force_redetect(struct cpuidle_device *dev);
 
+#else
+
+static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
+{return 0;}
+static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
+static inline int cpuidle_force_redetect(struct cpuidle_device *dev)
+{return 0;}
+
+#endif
 
 /******************************
  * CPUIDLE GOVERNOR INTERFACE *
@@ -153,8 +164,20 @@ struct cpuidle_governor {
 	struct module 		*owner;
 };
 
+#ifdef CONFIG_CPU_IDLE
+
 extern int cpuidle_register_governor(struct cpuidle_governor *gov);
 extern void cpuidle_unregister_governor(struct cpuidle_governor *gov);
 extern int cpuidle_get_bm_activity(void);
 
+#else
+
+static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
+{return 0;}
+static inline void cpuidle_unregister_governor(struct cpuidle_governor *gov) { }
+static inline int cpuidle_get_bm_activity(void)
+{return 0;}
+
+#endif
+
 #endif /* _LINUX_CPUIDLE_H */
-- 
1.5.0.3.310.g05ef5
