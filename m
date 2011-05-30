From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPI: Fixes device power states array overflow
Date: Mon, 30 May 2011 21:42:41 +0800
Message-ID: <1306762961.2244.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13321 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab1E3NnH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 30 May 2011 09:43:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Dan Carpenter <error27@gmail.com>

Commit 28c2103 added new state ACPI_STATE_D3_COLD, so the device power
states array must be expanded by one also.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 include/acpi/acpi_bus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a10ef5..ff246e8 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -210,7 +210,7 @@ struct acpi_device_power_state {
 struct acpi_device_power {
 	int state;		/* Current state */
 	struct acpi_device_power_flags flags;
-	struct acpi_device_power_state states[4];	/* Power states (D0-D3) */
+	struct acpi_device_power_state states[5];	/* Power states (D0-D3Cold) */
 };
 
 /* Performance Management */
-- 
1.7.2.3



