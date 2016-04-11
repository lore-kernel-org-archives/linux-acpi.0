From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 2/3] ACPI / x86: Cleanup initrd related code
Date: Mon, 11 Apr 2016 10:13:27 +0800
Message-ID: <d34b2b50c9429e4def0e519e14150f1bfc49663a.1460340514.git.lv.zheng@intel.com>
References: <273fd92043ff4972a71a94efdf01b67ee4638131> <cover.1460340514.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460340514.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

In arch/x86/kernel/setup.c, the #ifdef kept for CONFIG_ACPI actually is
related to the accessibility of initrd_start/initrd_end, so the stub should
be provided from this source file and should only be dependent on
CONFIG_BLK_DEV_INITRD.
Note that when ACPI=n and BLK_DEV_INITRD=y, early_initrd_acpi_init() is
still a stub because of the stub prepared for early_acpi_table_init().

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 arch/x86/kernel/setup.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 902a6f7..c4e7b39 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -398,6 +398,11 @@ static void __init reserve_initrd(void)
 
 	memblock_free(ramdisk_image, ramdisk_end - ramdisk_image);
 }
+
+static void __init early_initrd_acpi_init(void)
+{
+	early_acpi_table_init((void *)initrd_start, initrd_end - initrd_start);
+}
 #else
 static void __init early_reserve_initrd(void)
 {
@@ -405,6 +410,9 @@ static void __init early_reserve_initrd(void)
 static void __init reserve_initrd(void)
 {
 }
+static void __init early_initrd_acpi_init(void)
+{
+}
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 static void __init parse_setup_data(void)
@@ -1138,9 +1146,7 @@ void __init setup_arch(char **cmdline_p)
 
 	reserve_initrd();
 
-#if defined(CONFIG_ACPI) && defined(CONFIG_BLK_DEV_INITRD)
-	early_acpi_table_init((void *)initrd_start, initrd_end - initrd_start);
-#endif
+	early_initrd_acpi_init();
 
 	vsmp_init();
 
-- 
1.7.10
