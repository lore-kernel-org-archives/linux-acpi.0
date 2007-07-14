From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: ACPI: thinkpad_acpi: use bool for boolean parameters
Date: Sat, 14 Jul 2007 11:12:05 -0300
Message-ID: <11844223362208-git-send-email-hmh@hmh.eng.br>
References: <11844223322928-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:32861 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758356AbXGNOMW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Jul 2007 10:12:22 -0400
In-Reply-To: <11844223322928-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Some of the module parameters are boolean in nature.  Make it so in fact.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 78e4110..44aa8c9 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4444,10 +4444,10 @@ static u32 dbg_level;
 module_param_named(debug, dbg_level, uint, 0);
 
 static int force_load;
-module_param(force_load, int, 0);
+module_param(force_load, bool, 0);
 
 static int fan_control_allowed;
-module_param_named(fan_control, fan_control_allowed, int, 0);
+module_param_named(fan_control, fan_control_allowed, bool, 0);
 
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
-- 
1.5.2.1

