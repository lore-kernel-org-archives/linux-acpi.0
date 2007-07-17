From: Carlos Corbacho <cathectic@gmail.com>
Subject: [RFC][PATCH 5/5] ACPI: acer_acpi: Add acer_acpi.o to drivers/misc/Makefile
Date: Tue, 17 Jul 2007 15:48:58 +0100
Message-ID: <200707171548.58942.cathectic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:31685 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbXGQOsq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 10:48:46 -0400
Received: by ug-out-1314.google.com with SMTP id j3so152242ugf
        for <linux-acpi@vger.kernel.org>; Tue, 17 Jul 2007 07:48:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Add acer_acpi.o to drivers/misc/Makefile

Signed-off-by: Carlos Corbacho <cathectic@gmail.com>
---
 drivers/misc/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 5b6d46d..b336777 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -6,6 +6,7 @@ obj- := misc.o	# Dummy rule to force bui
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
 obj-$(CONFIG_MSI_LAPTOP)     += msi-laptop.o
+obj-$(CONFIG_ACER_ACPI)		+= acer_acpi.o
 obj-$(CONFIG_ASUS_LAPTOP)     += asus-laptop.o
 obj-$(CONFIG_BLINK)		+= blink.o
 obj-$(CONFIG_LKDTM)		+= lkdtm.o
-- 
1.4.2.1

