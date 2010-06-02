From: yakui.zhao@intel.com
Subject: [PATCH] ACPI: Fix the incorrect calculation about C-state idle time
Date: Wed,  2 Jun 2010 11:04:09 +0800
Message-ID: <1275447849-25761-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:50875 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269Ab0FBDHN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Jun 2010 23:07:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Venkatesh Pallipadi <venki@google.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The C-state idle time is not calculated correctly, which will return the wrong
residency time in C-state. It will have the following effects:
   1.  The system can't choose the deeper C-state when it is idle next time.
Of course the system power is increased. E.g. On one server machine about 40W
idle power is increased.
   2.  The powertop shows that it will stay in C0 running state about 95% time
although the system is idle at most time.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Reported-by: Yu Zhidong <zhidong.yu@intel.com>
Tested-by: Yu Zhidong <zhidong.yu@intel.com>
CC: Venkatesh Pallipadi <venki@google.com>
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
1.5.4.5

