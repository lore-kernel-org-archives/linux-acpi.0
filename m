From: Len Brown <lenb@kernel.org>
Subject: [PATCH 98/98] ACPI: get_throttling_state() cannot be larger than
 state_count
Date: Sat, 28 Mar 2009 00:32:13 -0400
Message-ID: <c66ca18f1cddfb5b89b284f2e009faa66d341dfc.1238214620.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27422 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbZC1EeA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:34:00 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH7003LZ8OE3MAH@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:33:51 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

Reported-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_throttling.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index d278381..5f09901 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -783,11 +783,9 @@ static int acpi_get_throttling_state(struct acpi_processor *pr,
 		    (struct acpi_processor_tx_tss *)&(pr->throttling.
 						      states_tss[i]);
 		if (tx->control == value)
-			break;
+			return i;
 	}
-	if (i > pr->throttling.state_count)
-		i = -1;
-	return i;
+	return -1;
 }
 
 static int acpi_get_throttling_value(struct acpi_processor *pr,
-- 
1.6.0.6

