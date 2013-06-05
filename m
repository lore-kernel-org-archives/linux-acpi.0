From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V2 2/2] ACPI / EC: Add HP Folio 13 to ec_dmi_table in order to skip DSDT scan
Date: Wed,  5 Jun 2013 10:27:51 +0800
Message-ID: <1370399271-6340-2-git-send-email-tianyu.lan@intel.com>
References: <1370399271-6340-1-git-send-email-tianyu.lan@intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1370399271-6340-1-git-send-email-tianyu.lan@intel.com>
Sender: stable-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, "3.9+" <stable@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

HP Folio 13's BIOS defines CMOS RTC Operation Region and the EC's
_REG method will access that region.  To allow the CMOS RTC region
handler to be installed before the EC _REG method is first invoked,
add ec_skip_dsdt_scan() as HP Folio 13's callback to ec_dmi_table.

[rjw: Changelog]
References: https://bugzilla.kernel.org/show_bug.cgi?id=54621
Reported-and-tested-by: Stefan Nagy <public@stefan-nagy.at>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Cc: 3.9+ <stable@vger.kernel.org>
---
 drivers/acpi/ec.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index edc0081..80403c1 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -983,6 +983,10 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
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
