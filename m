From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/42] ACPICA: Update for output of the Debug Object
Date: Tue, 29 Dec 2015 13:57:14 +0800
Message-ID: <eb44b5bb10f612bc4234fd979f6db4b647754739.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit b01414f5a822d0879aa9eba91541a21e7e501142

Improve output for the case of an Index() that refers to a
Package element that has not been initialized.

Link: https://github.com/acpica/acpica/commit/b01414f5
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/exdebug.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/exdebug.c b/drivers/acpi/acpica/exdebug.c
index ca6e379..b223090 100644
--- a/drivers/acpi/acpica/exdebug.c
+++ b/drivers/acpi/acpica/exdebug.c
@@ -310,9 +310,14 @@ acpi_ex_do_debug_object(union acpi_operand_object *source_desc,
 				case ACPI_TYPE_PACKAGE:
 
 					acpi_os_printf("Package[%u] = ", value);
-					acpi_ex_do_debug_object(*source_desc->
-								reference.where,
-								level + 4, 0);
+					if (!(*source_desc->reference.where)) {
+						acpi_os_printf
+						    ("[Uninitialized Package Element]\n");
+					} else {
+						acpi_ex_do_debug_object
+						    (*source_desc->reference.
+						     where, level + 4, 0);
+					}
 					break;
 
 				default:
-- 
1.7.10
