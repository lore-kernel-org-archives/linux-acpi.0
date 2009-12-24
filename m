From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/34] ACPI: do not select ACPI_DOCK from ATA_ACPI
Date: Thu, 24 Dec 2009 01:23:55 -0500
Message-ID: <2370b5ed03030d554adb345778d5edecab7a510c.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755809AbZLXTb2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:28 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:07 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Carlos R. Mafra" <crmafra@aei.mpg.de>, Shaohua Li <shaohua.li@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Carlos R. Mafra <crmafra@aei.mpg.de>

In March 2008 commit 0ac4a3c2fbbcadc3e96e4dc47d4ae802d66e6f67 ("ACPI: fix
ATA_ACPI build") made CONFIG_ACPI_DOCK be selected by CONFIG_ATA_ACPI because
of a build error when CONFIG_ATA_ACPI=y and CONFIG_ACPI_DOCK=m.

However, in September 2008 commit 898b054f3eec5921320ae8614b5bdd7b07ea5b43
("dock: make dock driver not a module") removed the possibility of having
CONFIG_ACPI_DOCK=m and therefore there is no need for selecting it when
CONFIG_ATA_ACPI=y.

This makes the kernel ~5 Kb smaller for people who don't have a dock by
allowing them to not have ACPI_DOCK compiled-in because of ATA_ACPI=y.

Signed-off-by: Carlos R. Mafra <crmafra@aei.mpg.de>
Cc: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/ata/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 85844d0..56c6374 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -40,7 +40,6 @@ config ATA_VERBOSE_ERROR
 config ATA_ACPI
 	bool "ATA ACPI Support"
 	depends on ACPI && PCI
-	select ACPI_DOCK
 	default y
 	help
 	  This option adds support for ATA-related ACPI objects.
-- 
1.6.0.6

