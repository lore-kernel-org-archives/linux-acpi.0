From: tianyu.lan@intel.com
Subject: [PATCH] ACPI/EC: Add "ASUSTEK L4R" to quirk list in order to validate ecdt
Date: Mon, 26 Aug 2013 10:19:18 +0800
Message-ID: <1377483558-16968-1-git-send-email-tianyu.lan@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, Daniele Esposti <expo@expobrain.net>, stable@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Lan Tianyu <tianyu.lan@intel.com>

The ecdt of "ASUSTEK L4R" doesn't provide correct command and data
io ports. The dsdt provides right info. So add this machine to quirk
list to validate ecdt and use the EC info in the dsdt.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60765
Reported-and-tested-by: Daniele Esposti <expo@expobrain.net>
CC: Daniele Esposti <expo@expobrain.net>
CC: stable@vger.kernel.org
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/ec.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 7f900e5..ae33004 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -989,6 +989,10 @@ static struct dmi_system_id __initdata ec_dmi_table[] = {
 	ec_skip_dsdt_scan, "HP Folio 13", {
 	DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
 	DMI_MATCH(DMI_PRODUCT_NAME, "HP Folio 13"),}, NULL},
+	{
+	ec_validate_ecdt, "ASUS hardware", {
+	DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek Computer Inc."),
+	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),}, NULL},
 	{},
 };
 
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
