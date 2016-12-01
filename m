From: Majun <majun258@huawei.com>
Subject: [RFC PATCH 1/3]Binding: Add a new property string in ITS node to control the two-level route function
Date: Thu, 1 Dec 2016 15:45:58 +0800
Message-ID: <1480578360-9268-2-git-send-email-majun258@huawei.com>
References: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:8918 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbcLAHqf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Dec 2016 02:46:35 -0500
In-Reply-To: <1480578360-9268-1-git-send-email-majun258@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, marc.zyngier@arm.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org, lv.zheng@intel.com, rafael.j.wysocki@intel.com, devel@acpica.org, mark.rutland@arm.com, robh+dt@kernel.org, jason@lakedaemon.net
Cc: dingtianhong@huawei.com, guohanjun@huawei.com, majun258@huawei.com

From: MaJun <majun258@huawei.com>

Add the two-level-route property in ITS node.
When this property string defined, two-level route(indirect) function
will be enabled in ITS driver, otherwise disable it.

Signed-off-by: MaJun <majun258@huawei.com>
---
 Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
index 4c29cda..e9f4a9c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
@@ -74,6 +74,8 @@ These nodes must have the following properties:
   which will generate the MSI.
 - reg: Specifies the base physical address and size of the ITS
   registers.
+- two-level-route: This is an optional property which means enable the two level
+  route property when look up route table.
 
 The main GIC node must contain the appropriate #address-cells,
 #size-cells and ranges properties for the reg property of all ITS
@@ -97,6 +99,7 @@ Examples:
 
 		gic-its@2c200000 {
 			compatible = "arm,gic-v3-its";
+			two-level-route;
 			msi-controller;
 			#msi-cells = <1>;
 			reg = <0x0 0x2c200000 0 0x200000>;
-- 
1.7.12.4


