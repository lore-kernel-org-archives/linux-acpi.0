From: Len Brown <len.brown@intel.com>
Subject: [PATCH 2/9] ACPI: resolve HP nx6125 S3 immediate wakeup regression
Date: Tue, 20 Mar 2007 11:27:04 -0400
Message-ID: <11744044323692-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9682 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933812AbXCTP1c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:32 -0400
In-Reply-To: <11744044323719-git-send-email-len.brown@intel.com>
Message-Id: <1d99967badac599c0d1db0b45c99e073e8e98cd4.1174404136.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>

Moving disable GPEs from enter_sleep up into sleep_prepare fixed
the disabled SCI on S4 on Acer laptops.

However, it caused an immediate S3 resume on the HP nx6125.
Apparently, on the HP, a GPE was getting re-enabled after
the prepare, but before the enter.

Close that window by restoring the GPE disable on enter.
This is redundant in most cases, but closes this window,
where S3 and S4 paths differ.

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Ray Lee <ray-lk@madrabbit.org>
---
 drivers/acpi/hardware/hwsleep.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index 8fa9312..c84b1fa 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -300,6 +300,11 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	/*
 	 * 2) Enable all wakeup GPEs
 	 */
+	status = acpi_hw_disable_all_gpes();
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
 	acpi_gbl_system_awake_and_running = FALSE;
 
 	status = acpi_hw_enable_all_wakeup_gpes();
-- 
1.5.0.3.382.g34572
