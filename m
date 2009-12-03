From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/8] thinkpad-acpi: fix default brightness_mode for R50e/R51
Date: Thu,  3 Dec 2009 09:41:18 -0200
Message-ID: <1259840485-2516-2-git-send-email-hmh@hmh.eng.br>
References: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45833 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752654AbZLCLl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 06:41:28 -0500
In-Reply-To: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org

According to a report, the R50e wants EC-based brightness control,
even if it uses an Intel GPU.  The current driver default was reported
to not work at all.

This bug can be worked around by the "brightness_mode=3" module
parameter.

Change the default of the R50e and R51 2xxx models (which use the same
EC firmware, 1V) to TPACPI_BRGHT_Q_EC, but keep TPACPI_BRGHT_Q_ASK set
for now, as I'd like to get more reports.

This fixes a regression caused by commit
59fe4fe34d7afdf63208124f313be9056feaa2f4,
"thinkpad-acpi: fix incorrect use of TPACPI_BRGHT_MODE_ECNVRAM"

Kernel 2.6.31 also needs this fix.

Reported-by: Ferenc Wagner <wferi@niif.hu>
Tested-by: Ferenc Wagner <wferi@niif.hu>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: stable@kernel.org
---
 drivers/platform/x86/thinkpad_acpi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index a848c7e..9c6d5a9 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6123,8 +6123,8 @@ static const struct tpacpi_quirk brightness_quirk_table[] __initconst = {
 
 	/* Models with Intel Extreme Graphics 2 */
 	TPACPI_Q_IBM('1', 'U', TPACPI_BRGHT_Q_NOEC),
-	TPACPI_Q_IBM('1', 'V', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
-	TPACPI_Q_IBM('1', 'W', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_NOEC),
+	TPACPI_Q_IBM('1', 'V', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
+	TPACPI_Q_IBM('1', 'W', TPACPI_BRGHT_Q_ASK|TPACPI_BRGHT_Q_EC),
 
 	/* Models with Intel GMA900 */
 	TPACPI_Q_IBM('7', '0', TPACPI_BRGHT_Q_NOEC),	/* T43, R52 */
-- 
1.6.5.2

