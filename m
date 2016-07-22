From: Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] ACPICA: cleanup method properly on error
Date: Fri, 22 Jul 2016 17:35:09 +0200
Message-ID: <1469201709-10518-1-git-send-email-vegard.nossum@oracle.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22512 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbcGVPfU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jul 2016 11:35:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>, stable@vger.kernel.org

If the call to acpi_ds_init_aml_walk() fails, then we have to undo the
walk state push done by acpi_ds_create_walk_state(). Otherwise, the new
walk state (which has just been freed) will remain on the thread's
walk_state_list and be dereferenced in acpi_ps_parse_aml() when we try
to get the new state.

You can observe this when reading e.g.

    /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0F:01/status

Cc: stable@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/acpi/acpica/dsmethod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 47c7b52..44b50a6 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -596,6 +596,8 @@ cleanup:
 	/* On error, we must terminate the method properly */
 
 	acpi_ds_terminate_control_method(obj_desc, next_walk_state);
+	if (thread)
+		acpi_ds_pop_walk_state(thread);
 	acpi_ds_delete_walk_state(next_walk_state);
 
 	return_ACPI_STATUS(status);
-- 
1.9.1

