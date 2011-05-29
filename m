From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/18] ACPI: EC: add another DMI check for ASUS hardware
Date: Sun, 29 May 2011 05:44:01 -0400
Message-ID: <af986d101d141f10231ffa7e40ae397dc7356857.1306662156.git.len.brown@intel.com>
References: <1306662253-11071-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:43894 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118Ab1E2JoW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 May 2011 05:44:22 -0400
Received: from arrandale.kernel.org ([unknown] [65.175.202.181])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LLY00D8OB1X7028@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 29 May 2011 04:44:22 -0500 (CDT)
In-reply-to: <1306662253-11071-1-git-send-email-lenb@kernel.org>
In-reply-to: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
References: <b299eb5cde1a91706c450804006c6559b0826df8.1306662156.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Collingbourne <peter@pcc.me.uk>, Len Brown <len.brown@intel.com>

From: Peter Collingbourne <peter@pcc.me.uk>

Commit 0adf3c746a73684b3f8c2821a584e1db998f61e9 introduced a regression
by making the ECDT validation test for ASUS hardware more restrictive.
The previous test used the dmi_name_in_vendors function which searches
a number of DMI fields, while the new test checked only the BIOS
vendor, which is known to not match on an ASUS F5GL laptop which
requires ECDT validation.

Add a rule to ec_dmi_table based on an alternative DMI pattern for
ASUS hardware as found elsewhere in the kernel.

Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index fa848c4..30ca717 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -940,6 +940,9 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	{
 	ec_validate_ecdt, "ASUS hardware", {
 	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
+	{
+	ec_validate_ecdt, "ASUS hardware", {
+	DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc.") }, NULL},
 	{},
 };
 
-- 
1.7.5.3.367.ga9930.dirty

