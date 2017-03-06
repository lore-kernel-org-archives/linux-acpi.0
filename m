From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v4 10/16] irqchip/gic: Add missing forward declaration for struct device
Date: Mon,  6 Mar 2017 16:19:24 +0200
Message-ID: <1488809970-25568-11-git-send-email-sakari.ailus@linux.intel.com>
References: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29226 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753988AbdCFOUC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Mar 2017 09:20:02 -0500
In-Reply-To: <1488809970-25568-1-git-send-email-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, mika.westerberg@linux.intel.com, rafael@kernel.org, mark.rutland@arm.com, broonie@kernel.org, robh@kernel.org, ahs3@redhat.com

A pointer to struct device is used in the header as a function argument
but there's no declaration for it. Add one.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 include/linux/irqchip/arm-gic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index eafc965..b16afa1 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -100,6 +100,7 @@
 
 #include <linux/irqdomain.h>
 
+struct device;
 struct device_node;
 struct gic_chip_data;
 
-- 
2.7.4

