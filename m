From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 2/4] ACPI / EC: Add support to skip boot stage DSDT probe
Date: Thu, 15 Jun 2017 09:41:41 +0800
Message-ID: <40ce1fcc531f3bdf82a765e1ae69ff426ffcd61e.1497490457.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com> <cover.1497490457.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1497490457.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We prepared _INI/_STA methods for \_SB, \_SB.PCI0, \_SB.LID0 and \_SB.EC,
_HID(PNP0C09)/_CRS/_GPE for \_SB.EC to poke Windows behavior with qemu, we
got the following execution sequence:
 \_SB._INI
 \_SB.PCI0._STA
 \_SB.LID0._STA
 \_SB.EC._STA
 \_SB.PCI0._INI
 \_SB.LID0._INI
 \_SB.EC._INI
There is no extra DSDT EC device enumeration process occurring before the
main ACPI device enumeration process. That means acpi_ec_dsdt_probe() is
not a Windows compliant approach, it's just a linux workaround.

Tracking back, we can see a long time ago, Linux EC driver won't probe DSDT
EC during boot. It was added by the following commit (see link #1 for bug
report):
  Commit: c5279dee26c0e8d7c4200993bfc4b540d2469598
  Subject: ACPI: EC: Add some basic check for ECDT data
This commit simply drivers Linux EC driver to a wrong direction.

Why we shouldn't enumerate DSDT EC before the main ACPI device enumeration?
The only way to know if the DSDT EC is valid is to evaluate its _STA
control method, but it's not proper to evaluate this control method that
early and out of the ACPI enumeration process because _STA may contain
other devices' initialization code and such devices may not have been
initialized before OSPM starts to enumerate them via the main ACPI device
enumeration.

But after we reverted back to the expected behavior, someone reported a
regression (see link #2 for reference). On that platform, there is no ECDT,
but the platform control methods access EC operation region earlier than
Linux expects, causing some ACPI method execution errors. According to the
regression rule, we just revert back to old behavior to still probe DSDT EC
as boot EC.

Now we've been reported 3rd functional breakage (link #3). In order to
handle both issues (link #2 and link #3), we could just skip boot stage
DSDT probe when ECDT exists so that a later quirk can always use correct
ECDT GPE setting.

Link: http://bugzilla.kernel.org/show_bug.cgi?id=11880 [#1]
Link: http://bugzilla.kernel.org/show_bug.cgi?id=119261 [#2]
Link: http://bugzilla.kernel.org/show_bug.cgi?id=195651 [#3]
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c1f480b..44b973e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1667,12 +1667,34 @@ static const struct acpi_device_id ec_device_ids[] = {
 	{"", 0},
 };
 
+/*
+ * This function is not Windows compliant as Windows never enumerates the
+ * namespace EC before the main ACPI device enumeration process. This
+ * function is kept for historical reason and will be deprecated in the
+ * future.
+ *
+ * It's added due to a non-root-caused bug fix:
+ *  http://bugzilla.kernel.org/show_bug.cgi?id=11880
+ * But removing it now unfortunately triggers user noticable regression:
+ *  http://bugzilla.kernel.org/show_bug.cgi?id=119261
+ */
 int __init acpi_ec_dsdt_probe(void)
 {
 	acpi_status status;
 	struct acpi_ec *ec;
 	int ret;
 
+	/*
+	 * If a platform has ECDT, there is no need to proceed as the
+	 * following probe is not a part of the ACPI device enumeration,
+	 * executing _STA is not safe, and thus this probe may risk of
+	 * picking up an invalid EC device.
+	 * So we should catch any possible chance to avoid applying this
+	 * quirk.
+	 */
+	if (boot_ec)
+		return -ENODEV;
+
 	ec = acpi_ec_alloc();
 	if (!ec)
 		return -ENOMEM;
-- 
2.7.4
