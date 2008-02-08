From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] intel_menlo: build on X86 only
Date: Fri,  8 Feb 2008 01:29:20 -0500
Message-ID: <9f2eef25e044603527e121066284d22f51d853cc.1202452053.git.len.brown@intel.com>
References: <1202452164-32320-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:1240 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752327AbYBHG3g (ORCPT
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
 drivers/misc/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 78cd338..218c65a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -279,6 +279,7 @@ config ATMEL_SSC
 config INTEL_MENLOW
 	tristate "Thermal Management driver for Intel menlow platform"
 	depends on ACPI_THERMAL
+	depends on X86
 	---help---
 	  ACPI thermal management enhancement driver on
 	  Intel Menlow platform.
-- 
1.5.4.34.g053d9

