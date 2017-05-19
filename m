From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/3] ACPI / EC: Add support to skip boot stage DSDT probe
Date: Fri, 19 May 2017 15:07:44 +0800
Message-ID: <e2b56ddc0cd3ae8370daa974cc987496c1c75e2b.1495176440.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com> <cover.1495176440.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63980 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753181AbdESHH5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 May 2017 03:07:57 -0400
In-Reply-To: <cover.1495176440.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Long time ago, Linux EC driver won't probe DSDT EC during boot. It was
added by the following commit (see link #1 for bug report):
  Commit: c5279dee26c0e8d7c4200993bfc4b540d2469598
  Subject: ACPI: EC: Add some basic check for ECDT data
This is wrong as the only way to know if the DSDT EC is valid is to
evaluate its _STA control method, but it's not proper to evaluate this
control method that early and out of the ACPI enumeration process.

But after we reverted back to the expected behavior, someone reported a
regression (see link #2 for reference). On that platform, there is no ECDT,
but the platform control methds access EC operation region earlier than
Linux expects. Without knowing the exact device enumeration order on
Windows, we in fact cannot conclude anything but can just follow the
regression rule to revert to old wrong behavior to probe DSDT EC at the old
position.

Now we've been reported 3rd functional breakage (link #3). The safest way
of solving it includes evaluating _STA. Due to the reason above, it is not
such safe to evaluate _STA in acpi_ec_dsdt_probe(). In order to handle both
issues (link #2 and link #3), we could just skip boot stage DSDT probe when
ECDT exists.

Note this change doesn't solve the reported problem, it can only be
resolved by a GPE setting quirk, and without this commit but with only the
GPE setting quirk, the reported problem can be solved. However, this commit
can improve our code quality by making unexpected behavior less effective.

Link: http://bugzilla.kernel.org/show_bug.cgi?id=11880 [#1]
Link: http://bugzilla.kernel.org/show_bug.cgi?id=119261 [#2]
Link: http://bugzilla.kernel.org/show_bug.cgi?id=195651 [#3]
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a920db6..e232a1c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1679,6 +1679,14 @@ int __init acpi_ec_dsdt_probe(void)
 	struct acpi_ec *ec;
 	int ret;
 
+	/*
+	 * If a platform has ECDT, there is no need to proceed as the
+	 * following unsafe probe is not a part of ACPI device enumeration,
+	 * and hence _STA is not executed.
+	 */
+	if (boot_ec)
+		return -ENODEV;
+
 	ec = acpi_ec_alloc();
 	if (!ec)
 		return -ENOMEM;
-- 
2.7.4

