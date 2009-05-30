From: Len Brown <lenb@kernel.org>
Subject: [PATCH 39/65] oqo: select INPUT_POLLDEV From: Randy Dunlap
 <randy.dunlap@oracle.com>
Date: Fri, 29 May 2009 21:42:17 -0400
Message-ID: <261a37014c353eb392334f31f6bc2166253d12c2.1243647607.git.len.brown@intel.com>
References: <1243647763-31572-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45585 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbZE3Bm4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 21:42:56 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00ACVORLUX12@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 20:42:58 -0500 (CDT)
In-reply-to: <1243647763-31572-1-git-send-email-lenb@kernel.org>
In-reply-to: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
References: <4b9575c04a5fe38d02eeabcad743ed886ebc53a4.1243647607.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

OQO_WMI uses INPUT_POLLDEV, but it can select that instead of depending on
it, since it represents library code.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 4c0993b..cc1a7a9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -136,9 +136,10 @@ config MSI_LAPTOP
 config OQO_WMI
        tristate "OQO WMI extras"
        depends on ACPI_WMI
-       depends on INPUT && INPUT_POLLDEV
+       depends on INPUT
        depends on RFKILL
        depends on BACKLIGHT_CLASS_DEVICE
+	select INPUT_POLLDEV
        help
          Say Y here if you want to support rfkill and backlight control on
          series 2 OQO handheld devices.
-- 
1.6.0.6

