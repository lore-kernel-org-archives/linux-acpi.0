From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/41] ACPI: updates rtc-cmos device platform_data
Date: Tue, 13 Feb 2007 00:49:21 -0500
Message-ID: <11713458083103-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:36316 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751067AbXBMFuK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:10 -0500
In-Reply-To: <11713458071963-git-send-email-lenb@kernel.org>
Message-Id: <a74388e21ef2adbba4450f7b3f05ffe88df630d5.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: David Brownell <david-b@pacbell.net>

Update ACPI to export its RTC extension information through platform_data
to the PNPACPI or platform bus device node used on the system being set up.

This will need to be updated later to provide a firmware hook to handle
system suspend with an alarm pending.

Len notes that "Eventually we may bundle ACPI/PNP/PNPACPI..." but if/when
that happens, ACPI can simplify this without my help.

And until it does, the separate patch creating a platform_device (on all
X86_PC systems, even without ACPI) will be needed.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 7b6c9ff..9950087 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -241,3 +241,92 @@ static int __init init_acpi_device_notify(void)
 }
 
 arch_initcall(init_acpi_device_notify);
+
+
+#if defined(CONFIG_RTC_DRV_CMOS) || defined(CONFIG_RTC_DRV_CMOS_MODULE)
+
+/* Every ACPI platform has a mc146818 compatible "cmos rtc".  Here we find
+ * its device node and pass extra config data.  This helps its driver use
+ * capabilities that the now-obsolete mc146818 didn't have, and informs it
+ * that this board's RTC is wakeup-capable (per ACPI spec).
+ */
+#include <linux/mc146818rtc.h>
+
+static struct cmos_rtc_board_info rtc_info;
+
+
+#ifdef CONFIG_PNPACPI
+
+/* PNP devices are registered in a subsys_initcall();
+ * ACPI specifies the PNP IDs to use.
+ */
+#include <linux/pnp.h>
+
+static int __init pnp_match(struct device *dev, void *data)
+{
+	static const char *ids[] = { "PNP0b00", "PNP0b01", "PNP0b02", };
+	struct pnp_dev *pnp = to_pnp_dev(dev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ids); i++) {
+		if (compare_pnp_id(pnp->id, ids[i]) != 0)
+			return 1;
+	}
+	return 0;
+}
+
+static struct device *__init get_rtc_dev(void)
+{
+	return bus_find_device(&pnp_bus_type, NULL, NULL, pnp_match);
+}
+
+#else
+
+/* We expect non-PNPACPI platforms to register an RTC device, usually
+ * at or near arch_initcall().  That also helps for example PCs that
+ * aren't configured with ACPI (where this code wouldn't run, but the
+ * RTC would still be available).  The device name matches the driver;
+ * that's how the platform bus works.
+ */
+#include <linux/platform_device.h>
+
+static int __init platform_match(struct device *dev, void *data)
+{
+	struct platform_device	*pdev;
+
+	pdev = container_of(dev, struct platform_device, dev);
+	return strcmp(pdev->name, "rtc_cmos") == 0;
+}
+
+static struct device *__init get_rtc_dev(void)
+{
+	return bus_find_device(&platform_bus_type, NULL, NULL, platform_match);
+}
+
+#endif
+
+static int __init acpi_rtc_init(void)
+{
+	struct device *dev = get_rtc_dev();
+
+	if (dev) {
+		rtc_info.rtc_day_alarm = acpi_gbl_FADT.day_alarm;
+		rtc_info.rtc_mon_alarm = acpi_gbl_FADT.month_alarm;
+		rtc_info.rtc_century = acpi_gbl_FADT.century;
+
+		/* NOTE:  acpi_gbl_FADT->rtcs4 is NOT currently useful */
+
+		dev->platform_data = &rtc_info;
+
+		/* RTC always wakes from S1/S2/S3, and often S4/STD */
+		device_init_wakeup(dev, 1);
+
+		put_device(dev);
+	} else
+		pr_debug("ACPI: RTC unavailable?\n");
+	return 0;
+}
+/* do this between RTC subsys_initcall() and rtc_cmos driver_initcall() */
+fs_initcall(acpi_rtc_init);
+
+#endif
-- 
1.5.0.rc4.345.gb4d2
