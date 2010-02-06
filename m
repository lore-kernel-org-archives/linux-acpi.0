From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/4] thinkpad-acpi: R52 brightness_mode has been confirmed
Date: Sat,  6 Feb 2010 13:30:28 -0200
Message-ID: <1265470230-30797-3-git-send-email-hmh@hmh.eng.br>
References: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45015 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753003Ab0BFPah (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2010 10:30:37 -0500
In-Reply-To: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We can stop pestering users for confirmation of the brightness_mode
default for firmware TP-76.

While at it, add a few missing comments in that quirk table.

Reported-by: Whoopie <whoopie79@gmx.net>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a923132..a3f440c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6139,13 +6139,13 @@ static const struct tpacpi_quirk brightness_quirk_table[] __initconst = {
 	TPACPI_Q_IBM('1', 'Y', TPACPI_BRGHT_Q_EC),	/* T43/p ATI */
 
 	/* Models with ATI GPUs that can use ECNVRAM */
-	TPACPI_Q_IBM('1', 'R', TPACPI_BRGHT_Q_EC),
+	TPACPI_Q_IBM('1', 'R', TPACPI_BRGHT_Q_EC),	/* R50,51 T40-42 */
 	TPACPI_Q_IBM('1', 'Q', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
-	TPACPI_Q_IBM('7', '6', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+	TPACPI_Q_IBM('7', '6', TPACPI_BRGHT_Q_EC),	/* R52 */
 	TPACPI_Q_IBM('7', '8', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 
 	/* Models with Intel Extreme Graphics 2 */
-	TPACPI_Q_IBM('1', 'U', TPACPI_BRGHT_Q_NOEC),
+	TPACPI_Q_IBM('1', 'U', TPACPI_BRGHT_Q_NOEC),	/* X40 */
 	TPACPI_Q_IBM('1', 'V', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 	TPACPI_Q_IBM('1', 'W', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 
-- 
1.6.5.7

