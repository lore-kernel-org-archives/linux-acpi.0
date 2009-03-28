From: Len Brown <lenb@kernel.org>
Subject: [PATCH 41/98] ACPICA: FADT: Fix extraneous length mismatch warning
Date: Sat, 28 Mar 2009 00:31:16 -0400
Message-ID: <aab61b676a024d3527f6201e2b31285a96f7a1d2.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27072 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbZC1Ect (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:49 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700LAC8MLL9UI@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:46 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Incorrect register length mismatch between the 32 and 64 bit
registers in some cases. Code was was checking the wrong pointer
for non-zero, should be looking at the address within the GAS
structure.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/tbfadt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
index af8fbe1..ff89cfe 100644
--- a/drivers/acpi/acpica/tbfadt.c
+++ b/drivers/acpi/acpica/tbfadt.c
@@ -491,7 +491,8 @@ static void acpi_tb_validate_fadt(void)
 		 * For each extended field, check for length mismatch between the
 		 * legacy length field and the corresponding 64-bit X length field.
 		 */
-		if (address64 && (address64->bit_width != ACPI_MUL_8(length))) {
+		if (address64->address &&
+		    (address64->bit_width != ACPI_MUL_8(length))) {
 			ACPI_WARNING((AE_INFO,
 				      "32/64X length mismatch in %s: %d/%d",
 				      name, ACPI_MUL_8(length),
-- 
1.6.0.6

