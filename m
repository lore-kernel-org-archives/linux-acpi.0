From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI: Untangle a return statement for better readability
Date: Tue, 31 Jul 2012 17:41:08 +0200
Message-ID: <1343749269-41678-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60972 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754555Ab2GaPlS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jul 2012 11:41:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, Thomas Renninger <trenn@suse.de>

No functional change.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 drivers/acpi/numa.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index e56f3be..2a63993 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -304,8 +304,10 @@ int __init acpi_numa_init(void)
 
 	acpi_numa_arch_fixup();
 
-	if (cnt <= 0)
-		return cnt ?: -ENOENT;
+	if (cnt < 0)
+		return cnt;
+	else if (cnt == 0)
+		return -ENOENT;
 	return 0;
 }
 
-- 
1.7.6.1

