From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 07/26] ACPICA: Tables: Enable default 64-bit FADT addresses favor.
Date: Wed,  1 Jul 2015 14:43:34 +0800
Message-ID: <882fe35eed228e95dda343bb816b474a412c7901.1435731597.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com> <cover.1435731597.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8869 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229AbbGAGnn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2015 02:43:43 -0400
In-Reply-To: <cover.1435731597.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

ACPICA commit 4da56eeae0749dfe8491285c1e1fad48f6efafd8

The following commit temporarily disables correct 64-bit FADT addresses
favor during the period the root cause of the bug is not fixed:
 Commit: 85dbd5801f62b66e2aa7826aaefcaebead44c8a6
 ACPICA: Tables: Restore old behavor to favor 32-bit FADT addresses.

With enough protections, this patch re-enables 64-bit FADT addresses by
default. If regressions are reported against such change, this patch should
be bisected and reverted.
Note that 64-bit FACS favor and 64-bit firmware waking vector favor are
excluded by this commit in order not to break OSPMs. Lv Zheng.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=74021
Link: https://github.com/acpica/acpica/commit/4da56eea
Cc: 3.15.1+ <stable@vger.kernel.org> # 3.15.1+
Reported-and-tested-by: Oswald Buddenhagen <ossi@kde.org>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/acpixf.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 445fd1e..213ed7e 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -195,9 +195,9 @@ ACPI_INIT_GLOBAL(u8, acpi_gbl_do_not_use_xsdt, FALSE);
  * address. Although ACPICA adheres to the ACPI specification which
  * requires the use of the corresponding 64-bit address if it is non-zero,
  * some machines have been found to have a corrupted non-zero 64-bit
- * address. Default is TRUE, favor the 32-bit addresses.
+ * address. Default is FALSE, do not favor the 32-bit addresses.
  */
-ACPI_INIT_GLOBAL(u8, acpi_gbl_use32_bit_fadt_addresses, TRUE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_use32_bit_fadt_addresses, FALSE);
 
 /*
  * Optionally use 32-bit FACS table addresses.
-- 
1.7.10

