From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] acpi: run _OSC after ACPI_FULL_INITIALIZATION
Date: Mon, 16 Jul 2012 16:30:21 +0800
Message-ID: <1342427421.3628.216.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:14656 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195Ab2GPIaX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Jul 2012 04:30:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

_OSC method may exist in module level code,
so it must be called after ACPI_FULL_INITIALIZATION

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/bus.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index adceafd..3532d52 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -980,8 +980,6 @@ static int __init acpi_bus_init(void)
 	status = acpi_ec_ecdt_probe();
 	/* Ignore result. Not having an ECDT is not fatal. */
 
-	acpi_bus_osc_support();
-
 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
 	if (ACPI_FAILURE(status)) {
 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
@@ -989,6 +987,12 @@ static int __init acpi_bus_init(void)
 	}
 
 	/*
+	 * _OSC method may exist in module level code,
+	 * so it must be run after ACPI_FULL_INITIALIZATION
+	 */
+	acpi_bus_osc_support();
+
+	/*
 	 * _PDC control method may load dynamic SSDT tables,
 	 * and we need to install the table handler before that.
 	 */
-- 
1.7.10



