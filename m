From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 05/14] ACPICA: Update NFIT table to rename a flags field
Date: Mon, 19 Oct 2015 10:24:52 +0800
Message-ID: <ce3967933672e87e7f0414026e6748411134e9b6.1445221164.git.lv.zheng@intel.com>
References: <8c1016ca8a570ba7c7a1c9f0f88d73cd83cea490> <cover.1445221164.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1445221164.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 534deab97fb416a13bfede15c538e2c9eac9384a

Updated one of the memory subtable flags to clarify.

Link: https://github.com/acpica/acpica/commit/534deab9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/nfit.c   |    6 +++---
 drivers/acpi/nfit.h   |    2 +-
 include/acpi/actbl1.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index c1b8d03..bc18aa2 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -706,7 +706,7 @@ static ssize_t flags_show(struct device *dev,
 		flags & ACPI_NFIT_MEM_SAVE_FAILED ? "save_fail " : "",
 		flags & ACPI_NFIT_MEM_RESTORE_FAILED ? "restore_fail " : "",
 		flags & ACPI_NFIT_MEM_FLUSH_FAILED ? "flush_fail " : "",
-		flags & ACPI_NFIT_MEM_ARMED ? "not_armed " : "",
+		flags & ACPI_NFIT_MEM_NOT_ARMED ? "not_armed " : "",
 		flags & ACPI_NFIT_MEM_HEALTH_OBSERVED ? "smart_event " : "");
 }
 static DEVICE_ATTR_RO(flags);
@@ -815,7 +815,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 			flags |= NDD_ALIASING;
 
 		mem_flags = __to_nfit_memdev(nfit_mem)->flags;
-		if (mem_flags & ACPI_NFIT_MEM_ARMED)
+		if (mem_flags & ACPI_NFIT_MEM_NOT_ARMED)
 			flags |= NDD_UNARMED;
 
 		rc = acpi_nfit_add_dimm(acpi_desc, nfit_mem, device_handle);
@@ -839,7 +839,7 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 		  mem_flags & ACPI_NFIT_MEM_SAVE_FAILED ? " save_fail" : "",
 		  mem_flags & ACPI_NFIT_MEM_RESTORE_FAILED ? " restore_fail":"",
 		  mem_flags & ACPI_NFIT_MEM_FLUSH_FAILED ? " flush_fail" : "",
-		  mem_flags & ACPI_NFIT_MEM_ARMED ? " not_armed" : "");
+		  mem_flags & ACPI_NFIT_MEM_NOT_ARMED ? " not_armed" : "");
 
 	}
 
diff --git a/drivers/acpi/nfit.h b/drivers/acpi/nfit.h
index 7e74015..329a1eb 100644
--- a/drivers/acpi/nfit.h
+++ b/drivers/acpi/nfit.h
@@ -24,7 +24,7 @@
 #define UUID_NFIT_DIMM "4309ac30-0d11-11e4-9191-0800200c9a66"
 #define ACPI_NFIT_MEM_FAILED_MASK (ACPI_NFIT_MEM_SAVE_FAILED \
 		| ACPI_NFIT_MEM_RESTORE_FAILED | ACPI_NFIT_MEM_FLUSH_FAILED \
-		| ACPI_NFIT_MEM_ARMED)
+		| ACPI_NFIT_MEM_NOT_ARMED)
 
 enum nfit_uuids {
 	NFIT_SPA_VOLATILE,
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index fcd5709..1bb979e 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1012,7 +1012,7 @@ struct acpi_nfit_memory_map {
 #define ACPI_NFIT_MEM_SAVE_FAILED       (1)	/* 00: Last SAVE to Memory Device failed */
 #define ACPI_NFIT_MEM_RESTORE_FAILED    (1<<1)	/* 01: Last RESTORE from Memory Device failed */
 #define ACPI_NFIT_MEM_FLUSH_FAILED      (1<<2)	/* 02: Platform flush failed */
-#define ACPI_NFIT_MEM_ARMED             (1<<3)	/* 03: Memory Device observed to be not armed */
+#define ACPI_NFIT_MEM_NOT_ARMED         (1<<3)	/* 03: Memory Device is not armed */
 #define ACPI_NFIT_MEM_HEALTH_OBSERVED   (1<<4)	/* 04: Memory Device observed SMART/health events */
 #define ACPI_NFIT_MEM_HEALTH_ENABLED    (1<<5)	/* 05: SMART/health events enabled */
 
-- 
1.7.10
