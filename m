From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/23] ACPICA: Fix to make _SST method optional
Date: Wed, 11 Jun 2008 03:59:23 -0400
Message-ID: <633251ad1f5d159f84dd3ba47e3bff844631b54e.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:59222 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbYFKH7i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:38 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A00GVHGK8Y1Y6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:52:57 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes a problem introduced in 20080514 where the status of
execution of _SST is incorrectly returned to the caller. _SST
is optional, and if it is AE_NOT_FOUND, the exception should be
ignored.

http://www.acpica.org/bugzilla/show_bug.cgi?id=716

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index d9937e0..dba3cfb 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -223,15 +223,17 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 		break;
 	}
 
-	/* Set the system indicators to show the desired sleep state. */
-
+	/*
+	 * Set the system indicators to show the desired sleep state.
+	 * _SST is an optional method (return no error if not found)
+	 */
 	status = acpi_evaluate_object(NULL, METHOD_NAME__SST, &arg_list, NULL);
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 		ACPI_EXCEPTION((AE_INFO, status,
 				"While executing method _SST"));
 	}
 
-	return_ACPI_STATUS(status);
+	return_ACPI_STATUS(AE_OK);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
-- 
1.5.6.rc2.23.gea81e

