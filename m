From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/17] ACPI: cpufreq: remove dupilcated #include
Date: Tue, 07 Apr 2009 19:04:11 -0400
Message-ID: <d22616942804798105e61428afa41a9132421bb9.1239145401.git.len.brown@intel.com>
References: <1239145465-5486-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:32254 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbZDGXEe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 19:04:34 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KHR00HO06RJKDMM@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 07 Apr 2009 18:04:32 -0500 (CDT)
In-reply-to: <1239145465-5486-1-git-send-email-lenb@kernel.org>
In-reply-to: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
References: <9090589d87506c578ea1523ffd7ae7fd9424fb28.1239145401.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Huang Weiyi <weiyi.huang@gmail.com>, Len Brown <len.brown@intel.com>

From: Huang Weiyi <weiyi.huang@gmail.com>

Remove dupilicated #include in arch/x86/kernel/cpu/cpufreq/longhaul.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

