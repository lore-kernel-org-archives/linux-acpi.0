From: "winton.liu" <18502523564@163.com>
Subject: [PATCH] tools/power/acpi: fix acpi power tool building error
Date: Sat,  2 Sep 2017 00:22:54 +0800
Message-ID: <1504282974-2821-1-git-send-email-18502523564@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, "winton.liu" <18502523564@163.com>
List-Id: linux-acpi@vger.kernel.org

When we tried to build acpi power tool, just like the following:
 $make tools/acpi
 ... ...
 can't create power/acpi/tools/acpidbg/acpidbg.o: No such file or directory
 ... ...

Root cause is that the 'tools' folder in the path
'power/acpi/tools/acpidbg/acpidbg.o' doesn't exist.

Signed-off-by: winton.liu <18502523564@163.com>
---
 tools/power/acpi/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/acpi/Makefile.config b/tools/power/acpi/Makefile.config
index a1883bb..fb5559f 100644
--- a/tools/power/acpi/Makefile.config
+++ b/tools/power/acpi/Makefile.config
@@ -18,7 +18,7 @@ include $(srctree)/../../scripts/Makefile.include
 
 OUTPUT=$(srctree)/
 ifeq ("$(origin O)", "command line")
-	OUTPUT := $(O)/power/acpi/
+	OUTPUT := $(O)/tools/power/acpi/
 endif
 #$(info Determined 'OUTPUT' to be $(OUTPUT))
 
-- 
1.9.1
