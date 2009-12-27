From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/5] thinkpad-acpi: improve Kconfig help text
Date: Sat, 26 Dec 2009 22:52:17 -0200
Message-ID: <1261875137-27565-6-git-send-email-hmh@hmh.eng.br>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54285 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751964AbZL0AwX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Dec 2009 19:52:23 -0500
In-Reply-To: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Document that rfkill and ALSA functionality exists, but requires the
subsystems to be available, and not modular if thinkpad-acpi is not
modular.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 2462dc3..db32c25 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -231,6 +231,11 @@ config THINKPAD_ACPI
 
 	  This driver was formerly known as ibm-acpi.
 
+	  Extra functionality will be available if the rfkill (CONFIG_RFKILL)
+	  and/or ALSA (CONFIG_SND) subsystems are available in the kernel.
+	  Note that if you want ThinkPad-ACPI to be built-in instead of
+	  modular, ALSA and rfkill will also have to be built-in.
+
 	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
 
 config THINKPAD_ACPI_ALSA_SUPPORT
-- 
1.6.5.7

