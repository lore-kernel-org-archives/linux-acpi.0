From: Len Brown <lenb@kernel.org>
Subject: [PATCH 084/103] thinkpad-acpi: log initial state of rfkill switches
Date: Wed, 16 Dec 2009 03:36:35 -0500
Message-ID: <5451a923bbdcff6ae665947e120af7238b21a9d2.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:47226 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762005AbZLPLGB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 06:06:01 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KUQ00BZPS5OJK34@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 05:05:56 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Josip Rodin <joy+kernel@entuzijast.net>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We already log the initial state of the hardware rfkill switch (WLSW),
might as well log the state of the softswitches as well.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Josip Rodin <joy+kernel@entuzijast.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/thinkpad_acpi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3daf349..05714ab 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -1264,6 +1264,7 @@ static int __init tpacpi_new_rfkill(const enum tpacpi_rfk_id id,
 	struct tpacpi_rfk *atp_rfk;
 	int res;
 	bool sw_state = false;
+	bool hw_state;
 	int sw_status;
 
 	BUG_ON(id >= TPACPI_RFK_SW_MAX || tpacpi_rfkill_switches[id]);
@@ -1298,7 +1299,8 @@ static int __init tpacpi_new_rfkill(const enum tpacpi_rfk_id id,
 			rfkill_init_sw_state(atp_rfk->rfkill, sw_state);
 		}
 	}
-	rfkill_set_hw_state(atp_rfk->rfkill, tpacpi_rfk_check_hwblock_state());
+	hw_state = tpacpi_rfk_check_hwblock_state();
+	rfkill_set_hw_state(atp_rfk->rfkill, hw_state);
 
 	res = rfkill_register(atp_rfk->rfkill);
 	if (res < 0) {
@@ -1311,6 +1313,9 @@ static int __init tpacpi_new_rfkill(const enum tpacpi_rfk_id id,
 	}
 
 	tpacpi_rfkill_switches[id] = atp_rfk;
+
+	printk(TPACPI_INFO "rfkill switch %s: radio is %sblocked\n",
+		name, (sw_state || hw_state) ? "" : "un");
 	return 0;
 }
 
-- 
1.6.0.6

