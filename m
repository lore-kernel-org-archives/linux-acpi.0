From: Len Brown <len.brown@intel.com>
Subject: [PATCH 020/105] ACPI: sbs: remove I2C Makefile hooks
Date: Sun, 29 Apr 2007 00:50:20 -0400
Message-ID: <11778223222525-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606AbXD2EwE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:04 -0400
In-Reply-To: <11778223211710-git-send-email-len.brown@intel.com>
Message-Id: <84cb55987236ffea062a35fbe1441768b6bb2722.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

SBS does not depend on I2C.
i2c_ec.h and i2c_ec.c are not needed

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 5956e9f..55bbc40 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -59,4 +59,4 @@ obj-$(CONFIG_ACPI_IBM)		+= ibm_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
 obj-y				+= cm_sbs.o
-obj-$(CONFIG_ACPI_SBS)		+= i2c_ec.o sbs.o
+obj-$(CONFIG_ACPI_SBS)		+= sbs.o
-- 
1.5.2.rc0.34.gda94
