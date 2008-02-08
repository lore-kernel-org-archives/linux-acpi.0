From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/8] ACPI: build WMI on X86 only
Date: Fri,  8 Feb 2008 01:29:19 -0500
Message-ID: <9c2f7de8c0f979fc6354bf0d22c0cdcc29722bf6.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:1240 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760503AbYBHG3g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 01:29:36 -0500
In-Reply-To: <1202452164-32320-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
References: <b0b23e0ade6aa265d7278e06d50bc10ec81dd174.1202452053.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7ef172c..65da19b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -204,6 +204,7 @@ config ACPI_NUMA
 
 config ACPI_WMI
 	tristate "WMI (EXPERIMENTAL)"
+	depends on X86
 	depends on EXPERIMENTAL
 	help
 	  This driver adds support for the ACPI-WMI mapper device (PNP0C14)
-- 
1.5.4.34.g053d9

