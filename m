From: Len Brown <lenb@kernel.org>
Subject: [PATCH 37/37] ACPI: clean up acpi_enter_sleep_state_prep
Date: Wed, 10 Oct 2007 01:06:44 -0400
Message-ID: <1191992804-14965-38-git-send-email-lenb@kernel.org>
References: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37367 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbXJJFHT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 01:07:19 -0400
In-Reply-To: <1191992804-14965-1-git-send-email-lenb@kernel.org>
Message-Id: <6cffd46651b881a11791a7ef4d99f2f20853fcd9.1191992584.git.len.brown@intel.com>
In-Reply-To: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
References: <fd1caaed466de2ee100e250b6c755376eda7ba3b.1191992584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove some redundant code from acpi_enter_sleep_state_prep() and clean up
a comment in there.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/hardware/hwsleep.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
index cf69c00..8181afb 100644
--- a/drivers/acpi/hardware/hwsleep.c
+++ b/drivers/acpi/hardware/hwsleep.c
@@ -234,15 +234,11 @@ acpi_status acpi_enter_sleep_state_prep(u8 sleep_state)
 				"While executing method _SST"));
 	}
 
-	/*
-	 * 1) Disable/Clear all GPEs
-	 */
+	/* Disable/Clear all GPEs */
+
 	status = acpi_hw_disable_all_gpes();
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
 
-	return_ACPI_STATUS(AE_OK);
+	return_ACPI_STATUS(status);
 }
 
 ACPI_EXPORT_SYMBOL(acpi_enter_sleep_state_prep)
-- 
1.5.3.4.206.g58ba4
