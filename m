From: Len Brown <lenb@kernel.org>
Subject: [PATCH 056/103] dell-laptop: remove duplicate Kconfig entry under
 drivers/misc
Date: Wed, 16 Dec 2009 03:36:07 -0500
Message-ID: <8c5d30e590593495c5bb8bd4a2519ce1ac909a22.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62434 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbZLPJGO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:14 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:58 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

This showed up as an unselectable option when using xconfig and
searching for "dell".  It must been overlooked when dell-laptop
was moved to drivers/platform/x86.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/Kconfig |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index df1f86b..ba137c8 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -210,19 +210,6 @@ config SGI_GRU_DEBUG
 	This option enables addition debugging code for the SGI GRU driver. If
 	you are unsure, say N.
 
-config DELL_LAPTOP
-	tristate "Dell Laptop Extras (EXPERIMENTAL)"
-	depends on X86
-	depends on DCDBAS
-	depends on EXPERIMENTAL
-	depends on BACKLIGHT_CLASS_DEVICE
-	depends on RFKILL
-	depends on POWER_SUPPLY
-	default n
-	---help---
-	This driver adds support for rfkill and backlight control to Dell
-	laptops.
-
 config ISL29003
 	tristate "Intersil ISL29003 ambient light sensor"
 	depends on I2C && SYSFS
-- 
1.6.0.6

