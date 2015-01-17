From: Yaowei Bai <bywxiaobai@163.com>
Subject: [PATCH] MAINTAINERS: add the necessary '/' according to entry rules
Date: Sat, 17 Jan 2015 15:31:07 +0800
Message-ID: <1421479867-3550-1-git-send-email-bywxiaobai@163.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m12-12.163.com ([220.181.12.12]:48471 "EHLO m12-12.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbbAQHdb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 17 Jan 2015 02:33:31 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3589d67..d46a77c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -270,12 +270,12 @@ F:	drivers/acpi/
 F:	drivers/pnp/pnpacpi/
 F:	include/linux/acpi.h
 F:	include/acpi/
-F:	Documentation/acpi
+F:	Documentation/acpi/
 F:	Documentation/ABI/testing/sysfs-bus-acpi
 F:	drivers/pci/*acpi*
 F:	drivers/pci/*/*acpi*
 F:	drivers/pci/*/*/*acpi*
-F:	tools/power/acpi
+F:	tools/power/acpi/
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
-- 
1.9.1


