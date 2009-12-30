From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/14] thinkpad-acpi: improve Kconfig help text
Date: Wed, 30 Dec 2009 02:36:30 -0500
Message-ID: <6e5b08ee941af38cfc6456158e7e04c1bc49306f.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:57070 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbZL3Hgo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:44 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KVG00JO0FT7OAJ4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:43 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Document that rfkill and ALSA functionality exists, but requires the
subsystems to be available, and not modular if thinkpad-acpi is not
modular.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

