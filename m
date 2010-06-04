From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] ACPI: Fix the incorrect calculation about C-state idle time
Date: Fri, 04 Jun 2010 15:47:24 -0400
Message-ID: <157317ba3ec3e5a4d9683b8d24ba40b4f8f3296b.1275680785.git.len.brown@intel.com>
References: <1275680845-8352-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:52791 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0FDTrs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Jun 2010 15:47:48 -0400
Received: from localhost.localdomain ([unknown] [98.118.125.200])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3I008Y29N6Y6L5@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 04 Jun 2010 14:47:31 -0500 (CDT)
In-reply-to: <1275680845-8352-1-git-send-email-lenb@kernel.org>
In-reply-to: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
References: <d5a64513c6a171262082c250592c062e97a2c693.1275680785.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The C-state idle time is not calculated correctly, which will return the wrong
residency time in C-state. It will have the following effects:
   1.  The system can't choose the deeper C-state when it is idle next time.
Of course the system power is increased. E.g. On one server machine about 40W
idle power is increased.
   2.  The powertop shows that it will stay in C0 running state about 95% time
although the system is idle at most time.

2.6.35-rc1 regression caused-by: 2da513f582a96c053aacc2c92873978d2ea7abff
(ACPI: Minor cleanup eliminating redundant PMTIMER_TICKS to NS conversion)

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reported-by: Yu Zhidong <zhidong.yu@intel.com>
Tested-by: Yu Zhidong <zhidong.yu@intel.com>
Acked-by: Venkatesh Pallipadi <venki@google.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2e8c27d..6b38a6b 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1022,7 +1022,7 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		spin_unlock(&c3_lock);
 	}
 	kt2 = ktime_get_real();
-	idle_time_ns = ktime_to_us(ktime_sub(kt2, kt1));
+	idle_time_ns = ktime_to_ns(ktime_sub(kt2, kt1));
 	idle_time = idle_time_ns;
 	do_div(idle_time, NSEC_PER_USEC);
 
-- 
1.6.0.6

