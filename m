From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 4/4] platform/x86: intel_pmc_ipc: Do not create iTCO watchdog when WDAT table exists
Date: Tue, 13 Sep 2016 18:23:36 +0300
Message-ID: <20160913152336.75405-5-mika.westerberg@linux.intel.com>
References: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160913152336.75405-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPI WDAT table is the preferred way to use hardware watchdog over the
native iTCO_wdt. Windows only uses this table for its hardware watchdog
implementation so we should be relatively safe to trust it has been
validated by OEMs.

Prevent iTCO watchdog creation if we detect that there is an ACPI WDAT
table.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index b86e1bcaa055..a511d518206b 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -651,11 +651,15 @@ static int ipc_create_pmc_devices(void)
 {
 	int ret;
 
-	ret = ipc_create_tco_device();
-	if (ret) {
-		dev_err(ipcdev.dev, "Failed to add tco platform device\n");
-		return ret;
+	/* If we have ACPI based watchdog use that instead */
+	if (!acpi_has_watchdog()) {
+		ret = ipc_create_tco_device();
+		if (ret) {
+			dev_err(ipcdev.dev, "Failed to add tco platform device\n");
+			return ret;
+		}
 	}
+
 	ret = ipc_create_punit_device();
 	if (ret) {
 		dev_err(ipcdev.dev, "Failed to add punit platform device\n");
-- 
2.9.3
