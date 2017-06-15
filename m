From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 1/4] ACPI / EC: Enhance boot EC sanity check
Date: Thu, 15 Jun 2017 09:41:35 +0800
Message-ID: <029653eabd94021790cf4fc5bca30b697920f7f4.1497490457.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com> <cover.1497490457.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51685 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbdFOBlp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Jun 2017 21:41:45 -0400
In-Reply-To: <cover.1497490457.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

It's reported that some buggy BIOS tables can contain 2 DSDT ECs, one of
them is invalid but acpi_ec_dsdt_probe() fails to pick the valid one.
This patch simply enhances sanity checks in ec_parse_device() as a
workaround to skip probing wrong namespace ECs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=195651
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c24235d..c1f480b 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1362,6 +1362,8 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 				     ec_parse_io_ports, ec);
 	if (ACPI_FAILURE(status))
 		return status;
+	if (ec->data_addr == 0 || ec->command_addr == 0)
+		return AE_OK;
 
 	/* Get GPE bit assignment (EC events). */
 	/* TODO: Add support for _GPE returning a package */
-- 
2.7.4

