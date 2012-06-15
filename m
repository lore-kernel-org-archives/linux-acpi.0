From: Tony Zelenoff <antonz@parallels.com>
Subject: [PATCH v2] acpi: resource conflict check must handle disabled state
Date: Fri, 15 Jun 2012 12:35:43 +0400
Message-ID: <1339749343-1029652-1-git-send-email-antonz@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay.parallels.com ([195.214.232.42]:60301 "EHLO
	relay.parallels.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2FOIfs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jun 2012 04:35:48 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, antonz@parallels.com

If acpi disabled via kernel parameter, then resource checks
should report no conflicts instead of reporting error.

Really, for intel chipsets there is lpc_pci driver, which checks
proper resource allocation via acpi_check_resource_conflict.

When you specify acpi=off to the kernel parameters the check inside
lpc_pci is done regardless of the parameter as it is done in all
other drivers.

So, the acpi_check_resource_conflict must not report any errors
to the caller is acpi is disabled.

kernel log error sample:
ACPI Exception: AE_BAD_PARAMETER, Thread 920463680 could not acquire
Mutex [0x1] (20120320/utmutex-276)

[v2]
* wrote better comment to patch

Signed-off-by: Tony Zelenoff <antonz@parallels.com>
---
 drivers/acpi/osl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c3881b2..a05baa1 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1360,6 +1360,8 @@ int acpi_check_resource_conflict(const struct resource *res)
 	u8 warn = 0;
 	int clash = 0;
 
+	if (acpi_disabled)
+		return 0;
 	if (acpi_enforce_resources == ENFORCE_RESOURCES_NO)
 		return 0;
 	if (!(res->flags & IORESOURCE_IO) && !(res->flags & IORESOURCE_MEM))
-- 
1.7.1

