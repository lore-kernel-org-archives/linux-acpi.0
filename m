From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/6] ACPI: fix mis-merge -- invoke acpi_unlazy_tlb() only on C3 entry
Date: Wed, 26 Mar 2008 01:13:38 -0400
Message-ID: <996520c1fdd2948addb629be56c9febf2967e02b.1206508358.git.len.brown@intel.com>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:44118 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753018AbYCZFVf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Mar 2008 01:21:35 -0400
In-Reply-To: <1206508420-2755-1-git-send-email-lenb@kernel.org>
In-Reply-To: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
References: <7642d2113098f1270e9f9f0120f44d0035091636.1206508358.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

This original patch
http://ussg.iu.edu/hypermail/linux/kernel/0712.2/1451.html
was intending to add acpi_unlazy_tlb() to acpi_idle_enter_bm(),
which is used for C3 entry.

But it was merged incorrectly as commmit

bde6f5f59c2b2b48a7a849c129d5b48838fe77ee
'x86: voluntary leave_mm before entering ACPI C3'

so the call was instead added to acpi_idle_enter_simple()
(which is C2 entry routine), probably due to identical
context in that function.

Move the call back to acpi_idle_enter_bm().

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e8e2d88..1468f1e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1487,7 +1487,6 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 		return 0;
 	}
 
-	acpi_unlazy_tlb(smp_processor_id());
 	/*
 	 * Must be done before busmaster disable as we might need to
 	 * access HPET !
@@ -1577,6 +1576,8 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 		return 0;
 	}
 
+	acpi_unlazy_tlb(smp_processor_id());
+
 	/* Tell the scheduler that we are going deep-idle: */
 	sched_clock_idle_sleep_event();
 	/*
-- 
1.5.5.rc1.6.g5cc8f

