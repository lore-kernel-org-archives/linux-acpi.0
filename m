From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: [PATCH 2/8] ACPI: cpufreq: remove dupilcated #include
Date: Mon,  6 Apr 2009 17:16:46 +0800
Message-ID: <1239009406-3048-1-git-send-email-weiyi.huang@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.190]:45688 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbZDFJT3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Apr 2009 05:19:29 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1900736tid.23
        for <linux-acpi@vger.kernel.org>; Mon, 06 Apr 2009 02:19:27 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, Huang Weiyi <weiyi.huang@gmail.com>

Remove dupilicated #include in arch/x86/kernel/cpu/cpufreq/longhaul.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
---
 arch/x86/kernel/cpu/cpufreq/longhaul.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpufreq/longhaul.c b/arch/x86/kernel/cpu/cpufreq/longhaul.c
index 0bd48e6..ce2ed3e 100644
--- a/arch/x86/kernel/cpu/cpufreq/longhaul.c
+++ b/arch/x86/kernel/cpu/cpufreq/longhaul.c
@@ -33,7 +33,6 @@
 #include <linux/timex.h>
 #include <linux/io.h>
 #include <linux/acpi.h>
-#include <linux/kernel.h>
 
 #include <asm/msr.h>
 #include <acpi/processor.h>
-- 
1.6.1.3

