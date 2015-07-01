From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 09/26] ACPICA: EFI: Add EFI interface definitions to eliminate dependency of GNU EFI.
Date: Wed,  1 Jul 2015 14:43:50 +0800
Message-ID: <c980664c768e03e1fdb4a1e2835564940bd24a95.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 5d00e67a74542d030f0a55e7a947a020ef0d9693

This patch copies EFI interface definitions to the ACPICA code base so that
the EFI utility support can be ported to other EFI implementation.

Known issues:
1. MS Builds of uefi_call_wrapper()
   The uefi_call_wrapper() in GNU EFI is implemented in a the way to work
   around the ABI difference between Unix and MS. While I don't have
   environment to test the MS builds.

In order to port the ACPICA utilities to other EFI implementation, all that
need to be done is to impelement the 64-bit division support and the
program entry point where the efi_main() is invoked. Code to impelement
these is platform specific, and ACPICA currently choose to hide such
platform specific code within the specific EFI impelementation. Lv Zheng.

This patch doesn't affect Linux kernel.

Link: https://github.com/acpica/acpica/commit/5d00e67a
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenvex.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/platform/acenvex.h b/include/acpi/platform/acenvex.h
index 14dc6f6..0a7dc8e 100644
--- a/include/acpi/platform/acenvex.h
+++ b/include/acpi/platform/acenvex.h
@@ -56,6 +56,12 @@
 #if defined(_LINUX) || defined(__linux__)
 #include <acpi/platform/aclinuxex.h>
 
+#elif defined(_AED_EFI)
+#include "acefiex.h"
+
+#elif defined(_GNU_EFI)
+#include "acefiex.h"
+
 #elif defined(__DragonFly__)
 #include "acdragonflyex.h"
 
-- 
1.7.10
