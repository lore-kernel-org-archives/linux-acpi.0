From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH] acpi: thermal: Remove create_workqueue
Date: Tue, 7 Jun 2016 08:45:40 +0530
Message-ID: <20160607031540.GA15147@Karyakshetra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36850 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbcFGDPp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Jun 2016 23:15:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

alloc_workqueue replaces deprecated create_workqueue().

A dedicated workqueue has been used since the workqueue
acpi_thermal_pm_queue with workitem &tz->thermal_check_work
(maps to acpi_thermal_check_fn), is involved in thermal zone polling.
Wallclock time is actually important and getting delayed in handling
critical temperature event can actually lead to unnecessary hardware
damage. So while this is not used during memory reclaim, we still want
forward progress guarantee and be generally snappy in servicing it.
Hence, WQ_MEM_RECLAIM and WQ_HIGHPRI have been used here.

Since there are only a fixed number of work items, explicit concurrency
limit is unnecessary here.

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/acpi/thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 82707f9..f4ebe39 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1259,7 +1259,8 @@ static int __init acpi_thermal_init(void)
 		return -ENODEV;
 	}

-	acpi_thermal_pm_queue = create_workqueue("acpi_thermal_pm");
+	acpi_thermal_pm_queue = alloc_workqueue("acpi_thermal_pm",
+						WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
 	if (!acpi_thermal_pm_queue)
 		return -ENODEV;

--
2.1.4

