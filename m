From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.31,32.stable] thinkpad-acpi: fix default brightness_mode
 for R50e/R51
Date: Wed, 16 Dec 2009 23:04:23 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912162301501.10371@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:46173 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935545AbZLQEEZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 23:04:25 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUS00AJN3BCVA65@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 22:04:25 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

upstream a9f8eacca4e9e8693de9b896c1fa7aadaa9402e8 

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
1.6.6.rc2.5.g49666

