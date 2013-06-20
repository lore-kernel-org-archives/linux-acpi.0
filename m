From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 1/3] ACPI: Update MAINTAINERS file to include Documentation/acpi
Date: Thu, 20 Jun 2013 08:02:20 +0800
Message-ID: <d18f9f44ae7516a17918d66c253dd265d6d68111.1371619148.git.lv.zheng@intel.com>
References: <1364824711-5193-1-git-send-email-rui.zhang@intel.com> <cover.1371619148.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29905 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934604Ab3FTACa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Jun 2013 20:02:30 -0400
In-Reply-To: <cover.1371619148.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

Documentation/acpi contains all of the Docunmentation for the
Linux/ACPI subsystem.  Adds this to the MAINTAINERS file.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62bb9c9..2634a7b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -242,6 +242,7 @@ F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
 F:	include/acpi/
+F:	Documentation/acpi
 
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
-- 
1.7.10

