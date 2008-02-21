From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/26] ACPI: thinkpad-acpi: trivial fix to module_desc typo
Date: Thu, 21 Feb 2008 04:25:22 -0500
Message-ID: <cbb14842137ff78df10038da8ca8a97917a5a926.1203585792.git.len.brown@intel.com>
References: <1203585938-31506-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:36609 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756482AbYBUJ3L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 04:29:11 -0500
In-Reply-To: <1203585938-31506-1-git-send-email-lenb@kernel.org>
In-Reply-To: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
References: <208c70a45624400fafd7511b96bc426bf01f8f5e.1203585792.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Thanks to Damjan <gdamjan@mail.net.mk> for noticing this one.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e2c7edd..723d37b 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -5918,7 +5918,7 @@ MODULE_PARM_DESC(hotkey_report_mode,
 
 #define TPACPI_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
-	MODULE_PARM_DESC(feature, "Simulates thinkpad-aci procfs command " \
+	MODULE_PARM_DESC(feature, "Simulates thinkpad-acpi procfs command " \
 			 "at module load, see documentation")
 
 TPACPI_PARAM(hotkey);
-- 
1.5.4.2

