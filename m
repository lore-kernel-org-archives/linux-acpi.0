From: Len Brown <lenb@kernel.org>
Subject: [PATCH 002/171] ACPI: EC: Restore udelay in poll mode
Date: Tue, 29 Apr 2008 04:43:53 -0400
Message-ID: <e6e82a3087e6dad619149246082c910623ea9c36.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:16639 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757719AbYD2Iok (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:44:40 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

This fixes keyboard event handling on some systems.

Note that this delay was thought unnecessary, and removed
from linux-2.6.20 with 50c1e1138cb94f6aca0f8555777edbcefe0324e2
'ACPI: ec: Drop udelay() from poll mode. Loop by reading status field instead.'

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7222a18..828c752 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -73,6 +73,7 @@ enum ec_event {
 
 #define ACPI_EC_DELAY		500	/* Wait 500ms max. during EC ops */
 #define ACPI_EC_UDELAY_GLK	1000	/* Wait 1ms max. to get global lock */
+#define ACPI_EC_UDELAY		100	/* Wait 100us before polling EC again */
 
 enum {
 	EC_FLAGS_WAIT_GPE = 0,		/* Don't check status until GPE arrives */
@@ -227,6 +228,7 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
 				goto end;
+			udelay(ACPI_EC_UDELAY);
 		}
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout,"
-- 
1.5.5.1.99.gf0ec4

