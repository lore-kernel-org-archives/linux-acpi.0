From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 2/3] ACPI / EC: Add support to skip boot stage DSDT probe
Date: Tue, 16 May 2017 17:46:57 +0800
Message-ID: <343948327ef01b0743c7aa6f34846a0b1a6d61fa.1494927504.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:57853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbdEPJrL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 16 May 2017 05:47:11 -0400
In-Reply-To: <cover.1494927504.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Daniel Drake <drake@endlessm.com>

Long time ago, Linux EC driver won't probe DSDT EC during boot. It was
added by the following commit (see link #1 for bug report):
  Commit: c5279dee26c0e8d7c4200993bfc4b540d2469598
  Subject: ACPI: EC: Add some basic check for ECDT data
This is wrong as the only way to know if the DSDT EC is valid is to
evaluate its _STA control method, but it's not proper to evaluate this
control method that early and out of the ACPI enumeration process.

But after we reverted back to the expected behavior, someone reported
regressions (see link #2 for reference). That forced us to restore the
wrong behavior back.

Now we've been reported 3rd functional breakage, the only way to fix it is
to evaluate _STA (see link #3 for newer requirement). And the safest way
of evaluating _STA is to do that during Linux ACPI device enumeration. As
the link #2 reported issue is not fatal, we could still skip boot stage
DSDT probe. But in order not to trigger regressions, this patch just
introduces a boot parameter instead of unconditionally changing the
upstreamed behavior.

Link: http://bugzilla.kernel.org/show_bug.cgi?id=11880 [#1]
Link: http://bugzilla.kernel.org/show_bug.cgi?id=119261 [#2]
Link: http://bugzilla.kernel.org/show_bug.cgi?id=195651 [#3]
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a920db6..a7e74ae 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -151,6 +151,10 @@ static bool ec_freeze_events __read_mostly = true;
 module_param(ec_freeze_events, bool, 0644);
 MODULE_PARM_DESC(ec_freeze_events, "Disabling event handling during suspend/resume");
 
+static bool ec_no_dsdt_boot_ec __read_mostly = false;
+module_param(ec_no_dsdt_boot_ec, bool, 0644);
+MODULE_PARM_DESC(ec_no_dsdt_boot_ec, "Do not probe DSDT EC as boot EC");
+
 struct acpi_ec_query_handler {
 	struct list_head node;
 	acpi_ec_query_func func;
@@ -1679,6 +1683,9 @@ int __init acpi_ec_dsdt_probe(void)
 	struct acpi_ec *ec;
 	int ret;
 
+	if (ec_no_dsdt_boot_ec)
+		return -ENODEV;
+
 	ec = acpi_ec_alloc();
 	if (!ec)
 		return -ENOMEM;
-- 
2.7.4

