From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [PATCH 2/8] cpuidle: menu governor and hrtimer compile fix
Date: Wed, 6 Jun 2007 13:50:36 -0700
Message-ID: <20070606205036.GB23906@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3923 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934955AbXFFUyS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jun 2007 16:54:18 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Adam Belay <abelay@novell.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Shaohua Li <shaohua.li@intel.com>, linux-acpi@vger.kernel.org



Compile fix for menu governor.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.22-rc-mm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-2.6.22-rc-mm.orig/drivers/cpuidle/governors/menu.c	2007-06-01 16:25:49.000000000 -0700
+++ linux-2.6.22-rc-mm/drivers/cpuidle/governors/menu.c	2007-06-05 17:52:33.000000000 -0700
@@ -11,8 +11,8 @@
 #include <linux/latency.h>
 #include <linux/time.h>
 #include <linux/ktime.h>
-#include <linux/tick.h>
 #include <linux/hrtimer.h>
+#include <linux/tick.h>
 
 #define BM_HOLDOFF	20000	/* 20 ms */
 
