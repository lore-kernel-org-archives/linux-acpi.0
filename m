From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ACPI / PNP: Fix incorrect placement of __initdata
Date: Thu, 22 Aug 2013 13:14:44 +0530
Message-ID: <1377157484-28972-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:64175 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab3HVICL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Aug 2013 04:02:11 -0400
Received: by mail-pa0-f44.google.com with SMTP id fz6so1872523pac.3
        for <linux-acpi@vger.kernel.org>; Thu, 22 Aug 2013 01:02:10 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@sisk.pl, bhelgaas@google.com, lenb@kernel.org, sachin.kamat@linaro.org

__initdata should be placed between the variable name and equal
sign for the variable to be placed in the intended section.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/pnp/pnpacpi/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 34049b0..763e41d 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -358,7 +358,7 @@ static bool acpi_pnp_bus_match(struct device *dev)
 	return dev->bus == &pnp_bus_type;
 }
 
-static struct acpi_bus_type __initdata acpi_pnp_bus = {
+static struct acpi_bus_type acpi_pnp_bus __initdata = {
 	.name	     = "PNP",
 	.match	     = acpi_pnp_bus_match,
 	.find_device = acpi_pnp_find_device,
-- 
1.7.9.5

