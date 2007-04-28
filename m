From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/9] ACPI: thinkpad-acpi: do not arm fan watchdog if it would not work
Date: Fri, 27 Apr 2007 22:00:10 -0300
Message-ID: <11777220172659-git-send-email-hmh@hmh.eng.br>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56484 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932173AbXD1BAX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Apr 2007 21:00:23 -0400
In-Reply-To: <11777220172751-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Do not enable/rearm the fan control safety watchdog if we would not be able
to do anything to the fan anyway.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/misc/thinkpad_acpi.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7dc3a22..f824259 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3197,6 +3197,9 @@ static void fan_watchdog_reset(void)
 {
 	static int fan_watchdog_active = 0;
 
+	if (fan_control_access_mode == TPACPI_FAN_WR_NONE)
+		return;
+
 	if (fan_watchdog_active)
 		cancel_delayed_work(&fan_watchdog_task);
 
-- 
1.5.1

