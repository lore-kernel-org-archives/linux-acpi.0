From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/23] ACPI: EC: Use msleep instead of udelay while waiting for
 event.
Date: Wed, 11 Jun 2008 03:59:09 -0400
Message-ID: <158b6d203aa16eeb668cca85f8f5eba3763c1d1c.1213171095.git.len.brown@intel.com>
References: <1213171166-3951-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:65151 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbYFKH7j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jun 2008 03:59:39 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2A0081HGV5URH2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 11 Jun 2008 02:59:29 -0500 (CDT)
In-reply-to: <1213171166-3951-1-git-send-email-lenb@kernel.org>
In-reply-to: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
References: <cfa9e14b544aa588467ff3340e4e5c7d5d97ed50.1213171095.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

http://bugzilla.kernel.org/show_bug.cgi?id=10724

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 0924992..5622aee 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -194,7 +194,7 @@ static int acpi_ec_wait(struct acpi_ec *ec, enum ec_event event, int force_poll)
 		while (time_before(jiffies, delay)) {
 			if (acpi_ec_check_status(ec, event))
 				return 0;
-			udelay(ACPI_EC_UDELAY);
+			msleep(1);
 		}
 	}
 	pr_err(PREFIX "acpi_ec_wait timeout, status = 0x%2.2x, event = %s\n",
-- 
1.5.6.rc2.23.gea81e

