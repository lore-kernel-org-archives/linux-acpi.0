From: Len Brown <len.brown@intel.com>
Subject: [PATCH 9/9] ACPI: IA64: fix %ll build warnings
Date: Tue, 20 Mar 2007 11:27:11 -0400
Message-ID: <11744044391690-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com> <11744044333328-git-send-email-len.brown@intel.com> <11744044341614-git-send-email-len.brown@intel.com> <11744044351759-git-send-email-len.brown@intel.com> <11744044363481-git-send-email-len.brown@intel.com> <11744044372247-git-send-email-len.brown@intel.com> <11744044381545-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9682 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933909AbXCTP1m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:42 -0400
In-Reply-To: <11744044381545-git-send-email-len.brown@intel.com>
Message-Id: <0cd4554df0c261f7ba74786e471ccaa0e3725fb9.1174404137.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

acpi_integer is 64-bits on all platforms, and so was defined as a u64.

i386 and x86_64 define u64 as unsigned long long.
ia64 defines u64 as long.

While these are all 64-bits, the kernel build warns about formating
a "long" with %ll:

drivers/ata/libata-acpi.c:176: warning: long long unsigned int format, acpi_integer arg (arg 5)

So skip using "u64" and define acpi_integer as "unsigned long long"
to make gcc happy with %ll.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 include/acpi/actypes.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 72a6e2c..56bf492 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -344,7 +344,7 @@ typedef u32 acpi_integer;
 
 /* 64-bit integers */
 
-typedef u64 acpi_integer;
+typedef unsigned long long              acpi_integer;
 #define ACPI_INTEGER_MAX                ACPI_UINT64_MAX
 #define ACPI_INTEGER_BIT_SIZE           64
 #define ACPI_MAX_DECIMAL_DIGITS         20	/* 2^64 = 18,446,744,073,709,551,616 */
-- 
1.5.0.3.382.g34572
