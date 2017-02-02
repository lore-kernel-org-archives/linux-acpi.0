From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v2 10/16] irqchip/gic: Add missing forward declaration for struct device
Date: Thu,  2 Feb 2017 18:22:20 +0200
Message-ID: <1486052546-19257-11-git-send-email-sakari.ailus@linux.intel.com>
References: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10121 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbdBBQXy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Feb 2017 11:23:54 -0500
In-Reply-To: <1486052546-19257-1-git-send-email-sakari.ailus@linux.intel.com>
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

