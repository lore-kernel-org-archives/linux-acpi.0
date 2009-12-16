From: Len Brown <lenb@kernel.org>
Subject: [PATCH 009/103] thinkpad-acpi: fix default brightness_mode for R50e/R51
Date: Wed, 16 Dec 2009 03:35:20 -0500
Message-ID: <a9f8eacca4e9e8693de9b896c1fa7aadaa9402e8.1260952471.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:40756 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbZLPIhF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 03:37:05 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00FGHL9SMMWJ@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 02:37:05 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

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
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

