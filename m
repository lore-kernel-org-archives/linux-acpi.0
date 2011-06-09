From: "lan,Tianyu" <tianyu.lan@intel.com>
Subject: [PATCH] ACPI: Fix a spelling mistake in the
 acpi_bus_get_power_flags()
Date: Thu, 09 Jun 2011 15:09:28 +0800
Message-ID: <1307603368.15256.38.camel@lantianyu-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63172 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619Ab1FIHS1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Jun 2011 03:18:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

ACPI: Fix a spelling mistake in the acpi_bus_get_power_flags()

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c  2011-06-09 14:32:34.642512998
+0800
+++ linux-2.6/drivers/acpi/scan.c   2011-06-09 14:32:57.622513002 +0800
@@ -873,7 +873,7 @@
        struct acpi_device_power_state *ps = &device->power.states[i];
        char object_name[5] = { '_', 'P', 'R', '0' + i, '\0' };
 
-       /* Evaluate "_PRx" to se if power resources are referenced */
+       /* Evaluate "_PRx" to see if power resources are referenced */
        acpi_evaluate_reference(device->handle, object_name, NULL,
                    &ps->resources);
        if (ps->resources.count) {


