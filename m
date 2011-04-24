From: Peter Collingbourne <peter@pcc.me.uk>
Subject: [PATCH v2] ACPI: EC: add another DMI check for ASUS hardware
Date: Sun, 24 Apr 2011 22:09:32 +0100
Message-ID: <1303679372-21619-1-git-send-email-peter@pcc.me.uk>
References: <1303616662-26527-1-git-send-email-peter@pcc.me.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from master.pcc.me.uk ([207.192.74.179]:57645 "EHLO master.pcc.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756668Ab1DXVJt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Apr 2011 17:09:49 -0400
In-Reply-To: <1303616662-26527-1-git-send-email-peter@pcc.me.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Peter Collingbourne <peter@pcc.me.uk>, Len Brown <len.brown@intel.com>

Commit 0adf3c746a73684b3f8c2821a584e1db998f61e9 introduced a regression
by making the ECDT validation test for ASUS hardware more restrictive.
The previous test used the dmi_name_in_vendors function which searches
a number of DMI fields, while the new test checked only the BIOS
vendor, which is known to not match on an ASUS F5GL laptop which
requires ECDT validation.

Add a rule to ec_dmi_table based on an alternative DMI pattern for
ASUS hardware as found elsewhere in the kernel.

Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Peter Collingbourne <peter@pcc.me.uk>
---
Peter Collingbourne wrote:
> Cc: Alexey Starikovskiy <astarikovskiy@suse.de>

Sorry for the noise, wrong person was cc'd as subsystem maintainer.

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
1.7.1

