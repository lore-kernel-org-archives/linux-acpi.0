From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/8] thinkpad-acpi: don't ask about brightness_mode for fw. 1V and 1R
Date: Sat, 12 Sep 2009 15:22:11 -0300
Message-ID: <1252779738-7459-2-git-send-email-hmh@hmh.eng.br>
References: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55548 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754558AbZILSWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Sep 2009 14:22:22 -0400
In-Reply-To: <1252779738-7459-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org

X40 (firmware 1V) and T41 (firmware 1R) have been confirmed to work
well with the new defaults, so we can stop pestering people to confirm
that fact.

For now, whitelist just these two firmware types.  It is best to have
at least one more firmware type confirmed for Radeon 9xxx and Intel
GMA-2 ThinkPads before removing the confirmation requests entirely.

Reported-by: Robert de Rooy <robert.de.rooy@gmail.com>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index e856008..d287283 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5655,16 +5655,16 @@ static const struct tpacpi_quirk brightness_quirk_table[] __initconst = {
 	/* Models with ATI GPUs known to require ECNVRAM mode */
 	TPACPI_Q_IBM('1', 'Y', TPACPI_BRGHT_Q_EC),	/* T43/p ATI */
 
-	/* Models with ATI GPUs (waiting confirmation) */
-	TPACPI_Q_IBM('1', 'R', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+	/* Models with ATI GPUs that can use ECNVRAM */
+	TPACPI_Q_IBM('1', 'R', TPACPI_BRGHT_Q_EC),
 	TPACPI_Q_IBM('1', 'Q', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 	TPACPI_Q_IBM('7', '6', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 	TPACPI_Q_IBM('7', '8', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 
-	/* Models with Intel Extreme Graphics 2 (waiting confirmation) */
+	/* Models with Intel Extreme Graphics 2 */
+	TPACPI_Q_IBM('1', 'U', TPACPI_BRGHT_Q_NOEC),
 	TPACPI_Q_IBM('1', 'V', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
 	TPACPI_Q_IBM('1', 'W', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
-	TPACPI_Q_IBM('1', 'U', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
 
 	/* Models with Intel GMA900 */
 	TPACPI_Q_IBM('7', '0', TPACPI_BRGHT_Q_NOEC),	/* T43, R52 */
-- 
1.6.3.3

