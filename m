From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/4] oqo: select INPUT_POLLDEV From: Randy Dunlap
 <randy.dunlap@oracle.com>
Date: Wed, 30 Dec 2009 19:14:35 -0500
Message-ID: <261a37014c353eb392334f31f6bc2166253d12c2.1262218269.git.len.brown@intel.com>
References: <1262218475-18104-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:50851 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453AbZLaAOw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 19:14:52 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVH004CBQ0IVDN9@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 18:14:42 -0600 (CST)
In-reply-to: <1262218475-18104-1-git-send-email-lenb@kernel.org>
In-reply-to: <9c82cd255907ad639bed4ffc8fcaf1bd59badb50.1262218269.git.len.brown@intel.com>
References: <9c82cd255907ad639bed4ffc8fcaf1bd59badb50.1262218269.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg@redhat.com, linux-acpi@vger.kernel.org
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

