From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] ACPI processor: Remove unneeded cpuidle_unregister_driver call
Date: Tue, 17 Jan 2012 17:35:22 +0100
Message-ID: <1326818122-570-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40895 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755086Ab2AQQf1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 11:35:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: deepthi@linux.vnet.ibm.com, Thomas Renninger <trenn@suse.de>

Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab registering
and unregistering cpuidle is done in processor_idle.c.
Unregistering via:
acpi_bus_unregister_driver(&acpi_processor_driver)
   -> acpi_processor_remove()
      -> acpi_processor_power_exit()

Remove not needed cpuidle_unregister_driver() call from
acpi_processor_exit

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 drivers/acpi/processor_driver.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 2a211a9..c0f875a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -827,8 +827,6 @@ static void __exit acpi_processor_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
-	cpuidle_unregister_driver(&acpi_idle_driver);
-
 	return;
 }
 
-- 
1.7.6.1

