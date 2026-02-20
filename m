Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93E349AE8;
	Fri, 20 Feb 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594994; cv=none; b=O2yK0WZ0qLOixHHP/Uf3vMNTIK4tC1PrLqwpiWRy3IJ3Pxv62hqdAv8q/UekxQXolqsdIQyxQ4Cb8ocaP+eWxzfCzyfKf84ynTmK0IkMogCv2IZAM+Ae2PI5ohsmzGvtDb0UgQoUgoa/NQ9dEm+PpnIfP3wSs7Ff9RAgtIqsLH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594994; c=relaxed/simple;
	bh=Ro9jyOjUV+5icp+VfPPbt7ZjXwB7iZzCea3yaeMfQ1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0Zv6y+xPpqs2JQl0SfdhdDUbOhKR11ZfD6EGSNfC++kPXUNYowOjAFGzG2jApbVCGMjt59Am8j8MDPZCj47kvvHXQGxrGvzHwyZ3x3xxGwhHdd5buT4V5ePglxhPJDYJrTkzZj4XNx62w1PTGIqINxwm+9TjaIxtnzyAE72H9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C60497;
	Fri, 20 Feb 2026 05:43:05 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ECC03F7D8;
	Fri, 20 Feb 2026 05:43:10 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:28 +0000
Subject: [PATCH v2 10/11] dt-bindings: firmware: add arm,ras-ffh
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-10-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=3270;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=Ro9jyOjUV+5icp+VfPPbt7ZjXwB7iZzCea3yaeMfQ1Q=;
 b=c9TE2wj12ivf9aHJjFamqN6mGSgFcLFAHICCbl0b7dMhp50o6zXsORw6pSgDl/RZLXn91Ibry
 MPTZcRybug6Bgi98z1uKAnpEkE4e5AIKD0uhKTuk5+lAuektdrA+GSG
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Describe the DeviceTree node that exposes the Arm firmware-first handler
CPER provider and hook the file into MAINTAINERS so the binding has an
owner.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 .../devicetree/bindings/firmware/arm,ras-ffh.yaml  | 71 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml b/Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
new file mode 100644
index 000000000000..eccbaaf45885
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/arm,ras-ffh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Firmware-First Handler (FFH) CPER provider
+
+maintainers:
+  - Ahmed Tiba <ahmed.tiba@arm.com>
+
+description: |
+  Arm Reliability, Availability and Serviceability (RAS) firmware can expose
+  a firmware-first handler (FFH) that provides UEFI CPER Generic Error Status
+  blocks directly via DeviceTree. The firmware owns the CPER buffer
+  and notifies the OS through an interrupt.
+
+properties:
+  compatible:
+    const: arm,ras-ffh
+
+  reg:
+    minItems: 1
+    items:
+      - description:
+          CPER Generic Error Status block exposed by firmware
+      - description:
+          Optional 32- or 64-bit doorbell register used on platforms
+          where firmware needs an explicit "ack" handshake before overwriting
+          the CPER buffer. Firmware watches bit 0 and expects the OS to set it
+          once the current status block has been consumed.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt used to signal that a new status record is ready.
+
+  memory-region:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Optional phandle to the reserved-memory entry that backs the status
+      buffer so firmware and the OS use the same carved-out region.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    reserved-memory {
+      #address-cells = <2>;
+      #size-cells = <2>;
+      ras_cper_buffer: cper@fe800000 {
+        reg = <0x0 0xfe800000 0x0 0x1000>;
+        no-map;
+      };
+    };
+
+    error-handler@fe800000 {
+      compatible = "arm,ras-ffh";
+      reg = <0xfe800000 0x1000>,
+            <0xfe810000 0x4>;
+      memory-region = <&ras_cper_buffer>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b8d8a5c41597..47db7877b485 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22027,6 +22027,11 @@ M:	Alexandre Bounine <alex.bou9@gmail.com>
 S:	Maintained
 F:	drivers/rapidio/
 
+RAS ERROR STATUS
+M:	Ahmed Tiba <ahmed.tiba@arm.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
+
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>

-- 
2.43.0

