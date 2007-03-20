From: Len Brown <len.brown@intel.com>
Subject: [PATCH 8/9] ACPI: IA64: fix allnoconfig build
Date: Tue, 20 Mar 2007 11:27:10 -0400
Message-ID: <11744044381545-git-send-email-len.brown@intel.com>
References: <1174404431897-git-send-email-len.brown@intel.com> <11744044323719-git-send-email-len.brown@intel.com> <11744044323692-git-send-email-len.brown@intel.com> <11744044333328-git-send-email-len.brown@intel.com> <11744044341614-git-send-email-len.brown@intel.com> <11744044351759-git-send-email-len.brown@intel.com> <11744044363481-git-send-email-len.brown@intel.com> <11744044372247-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46827 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933918AbXCTP1m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Mar 2007 11:27:42 -0400
In-Reply-To: <11744044372247-git-send-email-len.brown@intel.com>
Message-Id: <8140a90ec180192b202af086e7a582e5937c5580.1174404137.git.len.brown@intel.com>
In-Reply-To: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
References: <a1fdcc0d2714b6622e3fd5c00db1635213d6c41a.1174404136.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

The evils of Kconfig's select bite us once again...
ia64/Kconfig selects ACPI, which depends on PM.
But select ignores dependencies, allnoconfig
chooses CONFIG_PM=n, and thus the menu of sub-options
under ACPI vanish, which breaks the build.

Manually select PM along with ACPI for now.
Some day, we should delete them both, or fix select.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/ia64/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index d51f0f1..e19185d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -13,6 +13,7 @@ config IA64
 	bool
 	select PCI if (!IA64_HP_SIM)
 	select ACPI if (!IA64_HP_SIM)
+	select PM if (!IA64_HP_SIM)
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
-- 
1.5.0.3.382.g34572
