From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/4] thinkpad-acpi: disable broken bay and dock subdrivers
Date: Sat,  1 Aug 2009 12:04:17 -0300
Message-ID: <1249139060-15392-2-git-send-email-hmh@hmh.eng.br>
References: <1249139060-15392-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50245 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751858AbZHAPHI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2009 11:07:08 -0400
In-Reply-To: <1249139060-15392-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, stable@kernel.org

Currently, the ThinkPad-ACPI bay and dock drivers are completely
broken, and cause a NULL pointer derreference in kernel mode (and,
therefore, an OOPS) when they try to issue events (i.e. on dock,
undock, bay ejection, etc).

OTOH, the standard ACPI dock driver can handle the hotplug bays and
docks of the ThinkPads just fine (including batteries) as of 2.6.27.
In fact, it does a much better job of it than thinkpad-acpi ever did.

It is just not worth the hassle to find a way to fix this crap without
breaking the (deprecated) thinkpad-acpi dock/bay ABI.  This is old,
deprecated code that sees little testing or use.

As a quick fix suitable for -stable backports, mark the thinkpad-acpi
bay and dock subdrivers as BROKEN in Kconfig.  The dead code will be
removed by a later patch.

This fixes bugzilla #13669, and should be applied to 2.6.27 and later.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Reported-by: Joerg Platte <jplatte@naasa.net>
Cc: stable@kernel.org
---
 drivers/platform/x86/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 46dad12..6335f63 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -281,6 +281,7 @@ config THINKPAD_ACPI_DOCK
 	bool "Legacy Docking Station Support"
 	depends on THINKPAD_ACPI
 	depends on ACPI_DOCK=n
+	depends on BROKEN
 	default n
 	---help---
 	  Allows the thinkpad_acpi driver to handle docking station events.
@@ -294,7 +295,8 @@ config THINKPAD_ACPI_DOCK
 config THINKPAD_ACPI_BAY
 	bool "Legacy Removable Bay Support"
 	depends on THINKPAD_ACPI
-	default y
+	depends on BROKEN
+	default n
 	---help---
 	  Allows the thinkpad_acpi driver to handle removable bays.  It will
 	  electrically disable the device in the bay, and also generate
-- 
1.6.3.3

