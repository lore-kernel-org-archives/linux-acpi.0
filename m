From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/8] thinkpad-acpi: log initial state of rfkill switches
Date: Tue, 15 Dec 2009 21:51:07 -0200
Message-ID: <1260921073-7686-3-git-send-email-hmh@hmh.eng.br>
References: <1260921073-7686-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55470 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754950AbZLOXvU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 18:51:20 -0500
In-Reply-To: <1260921073-7686-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Josip Rodin <joy+kernel@entuzijast.net>

We already log the initial state of the hardware rfkill switch (WLSW),
might as well log the state of the softswitches as well.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Josip Rodin <joy+kernel@entuzijast.net>
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
1.6.5.4

