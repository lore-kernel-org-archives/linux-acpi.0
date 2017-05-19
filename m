From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/3] ACPI / EC: Enhance boot EC sanity check
Date: Fri, 19 May 2017 15:07:35 +0800
Message-ID: <7c94728bbb598231064f976e8980b44ab1f7464b.1495176440.git.lv.zheng@intel.com>
References: <cover.1494927504.git.lv.zheng@intel.com> <cover.1495176440.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1495176440.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

It's reported that some buggy BIOS tables can contain 2 DSDT ECs and one of
them is invalid. As we shouldn't evaluate _STA from acpi_ec_dsdt_probe()
due to the unknown Windows enumeration order, this patch simply enhances
sanity checks in ec_parse_device() as a workaround to skip probing wrong
namespace ECs.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=195651
Tested-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index c24235d..a920db6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1362,6 +1362,14 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
 				     ec_parse_io_ports, ec);
 	if (ACPI_FAILURE(status))
 		return status;
+	/*
+	 * It's better to evaluate _STA to determine if the device is
+	 * valid. But that could potentially trigger issues related to
+	 * the unknown orders of _INI/_STA evaluations.
+	 * However we can abort due to invalid _CRS information here.
+	 */
+	if (ec->data_addr == 0 || ec->command_addr == 0)
+		return AE_OK;
 
 	/* Get GPE bit assignment (EC events). */
 	/* TODO: Add support for _GPE returning a package */
-- 
2.7.4
