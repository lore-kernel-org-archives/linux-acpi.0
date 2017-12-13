From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V8 1/7] Documentation: DT: qcom_hidma: Bump HW revision for the bugfixed HW
Date: Wed, 13 Dec 2017 02:20:47 -0500
Message-ID: <1513149653-19451-2-git-send-email-okaya@codeaurora.org>
References: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:59808 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbdLMHVC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2017 02:21:02 -0500
In-Reply-To: <1513149653-19451-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine@vger.kernel.org, timur@codeaurora.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, sakari.ailus@linux.intel.com
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, open list <linux-kernel@vger.kernel.org>

A new version of the HIDMA IP has been released with bug fixes. Bumping the
hardware version to differentiate from others.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index 55492c2..5d93d6d 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -47,8 +47,8 @@ When the OS is not in control of the management interface (i.e. it's a guest),
 the channel nodes appear on their own, not under a management node.
 
 Required properties:
-- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
-for MSI capable HW.
+- compatible: must contain "qcom,hidma-1.0" for initial HW or
+  "qcom,hidma-1.1"/"qcom,hidma-1.2" for MSI capable HW.
 - reg: Addresses for the transfer and event channel
 - interrupts: Should contain the event interrupt
 - desc-count: Number of asynchronous requests this channel can handle
-- 
1.9.1

