From: Chen Gong <gong.chen@linux.intel.com>
Subject: [PATCH] Add Kconfig option IRQ_WORK for GHES
Date: Wed, 10 Aug 2011 10:46:22 +0800
Message-ID: <1312944382-24491-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49362 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096Ab1HJCpS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Aug 2011 22:45:18 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: ying.huang@intel.com, Chen Gong <gong.chen@linux.intel.com>

IRQ_WORK is used by GHES, but it is selected by PERF_EVENT.
For now PERF_EVENT is selected by x86 by default, but
in concept, IRQ_WORK should be selected by GHES, not by others.

Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
---
 drivers/acpi/apei/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index c34aa51..e3f4787 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -13,6 +13,7 @@ config ACPI_APEI_GHES
 	bool "APEI Generic Hardware Error Source"
 	depends on ACPI_APEI && X86
 	select ACPI_HED
+	select IRQ_WORK
 	select LLIST
 	select GENERIC_ALLOCATOR
 	help
-- 
1.7.6.401.g6a319

