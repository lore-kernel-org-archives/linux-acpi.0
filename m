From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/5] ACPI processor: Avoid WARN message on processor driver removal
Date: Mon, 12 Sep 2011 01:42:27 +0200
Message-ID: <1315784551-39118-2-git-send-email-trenn@suse.de>
References: <1315784551-39118-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48668 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab1IKXmn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Sep 2011 19:42:43 -0400
In-Reply-To: <1315784551-39118-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>

Only unregister acpi_idle driver if acpi_idle driver got
registered. On latest Nehalem/Sandybridge this is not the case,
but the intel_idle driver is used instead.

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_driver.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index a4e0f1b..9247e67 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -823,7 +823,8 @@ static int __init acpi_processor_init(void)
 	return 0;
 
 out_cpuidle:
-	cpuidle_unregister_driver(&acpi_idle_driver);
+	if (cpuidle_get_driver() == &acpi_idle_driver)
+		cpuidle_unregister_driver(&acpi_idle_driver);
 
 	return result;
 }
@@ -841,7 +842,8 @@ static void __exit acpi_processor_exit(void)
 
 	acpi_bus_unregister_driver(&acpi_processor_driver);
 
-	cpuidle_unregister_driver(&acpi_idle_driver);
+	if (cpuidle_get_driver() == &acpi_idle_driver)
+		cpuidle_unregister_driver(&acpi_idle_driver);
 
 	return;
 }
-- 
1.7.6.1

