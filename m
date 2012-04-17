From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 2/6] ACPI: Set D3cold state as default device sleep state
Date: Tue, 17 Apr 2012 13:47:52 +0800
Message-ID: <1334641676-14566-3-git-send-email-ming.m.lin@intel.com>
References: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:49201 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab2DQFsM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 01:48:12 -0400
In-Reply-To: <1334641676-14566-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.og>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Huang Ying <huang.ying.caritas@gmail.com>, Aaron Lu <aaron.lu@amd.com>

D3cold state is returned if no other preferred power state is found.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/sleep.c    |    2 +-
 include/acpi/acpi_bus.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 1d661b5..1fcfb78 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -705,7 +705,7 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 	 * _S0W, we will use the value from _S0W
 	 */
 	d_min = ACPI_STATE_D0;
-	d_max = ACPI_STATE_D3;
+	d_max = ACPI_STATE_D3_COLD;
 
 	/*
 	 * If present, _SxD methods return the minimum D-state (highest power
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f1c8ca6..2db51aa 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -389,7 +389,7 @@ static inline int acpi_pm_device_sleep_state(struct device *d, int *p)
 {
 	if (p)
 		*p = ACPI_STATE_D0;
-	return ACPI_STATE_D3;
+	return ACPI_STATE_D3_COLD;
 }
 #endif
 
-- 
1.7.2.5

