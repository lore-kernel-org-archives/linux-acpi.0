From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Fix PATCH 2/2] ACPI/EC: Add HP Folio 13 into ec_dmi_table in order to skip DSDT scan
Date: Wed, 29 May 2013 20:04:00 +0800
Message-ID: <1369829040-31029-2-git-send-email-tianyu.lan@intel.com>
References: <1369829040-31029-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47531 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965976Ab3E2MKW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 May 2013 08:10:22 -0400
In-Reply-To: <1369829040-31029-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, public@stefan-nagy.at, stable@vger.kernel.org

HP Folio 13's bios defines CMOS RTC operation region and EC _REG
method will access this region. In order to make CMOS RTC region
handler to be installed before EC _REG method being invoked, this
patch is to add ec_skip_dsdt_scan as HP Folio 13 entry's callback
into ec_dmi_table.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=54621
Cc: stable@vger.kernel.org
Reported-and-tested-by: Stefan Nagy <public@stefan-nagy.at>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/ec.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index aabf4fe..42ab7c5 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -994,6 +994,10 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	ec_enlarge_storm_threshold, "CLEVO hardware", {
 	DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
 	DMI_MATCH(DMI_PRODUCT_NAME, "M720T/M730T"),}, NULL},
+	{
+	ec_skip_dsdt_scan, "HP Folio 13", {
+	DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+	DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13"),}, NULL},
 	{},
 };
 
-- 
1.7.10.4

