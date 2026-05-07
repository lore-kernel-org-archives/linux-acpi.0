Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344093F20F4;
	Thu,  7 May 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158559; cv=none; b=Peu5ODVGm1nesY6NImwaoz+DYxNDH/pCUfU1MoKRPHXtIiXNXfvo/PiwfehwrgxMTphZlvGf/hb5puDidSne9PmOlDRWJn/9GMWkSnqsI6MZTs+0E66iYnF/x8DP5J71e6Fo0+/8x5H7PrHzvOrvasmKGAI2G/PDJSOXesb8vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158559; c=relaxed/simple;
	bh=6c96IjMHaMre41xBr3FzTv5pSHvU6UTiqN3k4zC2F0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2l2w4/H2LYknu+tXLa+f6W2EC3LLm5UnoFIlJCoxqOQ774U2UlbWl4cl5KsPaMDiJ4sPuulk77B294D5jdIH1FK14Sa0nmWK3iWy6XyBn8TIVbX7I4Q24t+zWLj4GG980QhHBYDH0i8q2pQ3yZcMC/3oslSEjXx5QrTMvGDdqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZprJQtb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZprJQtb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CBDC4AF52;
	Thu,  7 May 2026 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158559;
	bh=6c96IjMHaMre41xBr3FzTv5pSHvU6UTiqN3k4zC2F0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MZprJQtbEL/qKSJ+blHqLXn59EDJTINi2PRv8HZAJjZMGROUPoGzPTJmGlmAGFX3e
	 PTDLW7Q3wARN/9UIHA87bU4LvS35WvweNlTSOV2N4QyUwpyKMoCcmXWDLViTxOkrz9
	 1ErRvSfAbQb8+DlgtOg1hu8FQgUlVMfBT9OgirBt9ZE9U+bZHUQg7yH4iU/6xQ6Mrk
	 M8yP6TCze5NN4CY5los0Up5KFHtKKV/CFilK3ntIJP+T2EcaOFKulLZIKLQ7BlB+Zv
	 x8koVqu2iX8ZGsOLRudsFodKQ8ae5cJKJZNwLrVwLhfC8/6GQXaWAp7ZmBAuwZVU2v
	 vRExc3FIx62kQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKyGi-00000000d7d-23jP;
	Thu, 07 May 2026 12:55:56 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Ge Gordon <gordon.ge@bst.ai>,
	BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH 03/16] dt-bindings: timer: arm,arch_timer: Fix requirements for interrupt description
Date: Thu,  7 May 2026 13:55:31 +0100
Message-ID: <20260507125544.2903406-4-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507125544.2903406-1-maz@kernel.org>
References: <20260507125544.2903406-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

The arm,arch_timer DT binding is extremely imprecise in describing
the requirements for interrupts.

Follow the architecture by making it explicit that:
- the EL1 secure timer irq is required if EL3 is implemented
- the EL1 physical timer irq is always required
- the EL1 virtual timer irq is always required
- the EL2 physical timer irq is required if EL2 is implemented
- the EL2 virtual timer irq is required if FEAT_VHE is implemented

The consequence of the above is that the minimum number of interrupts
to be described is 2, and not 1.

Finally, clean up the description which made the assumption that
the timers are plugged into a GIC (unfortunately, that's not always
true), drop the MMIO nonsense that has long be moved to a separate
binding, and use the architectural terminology to describe the various
interrupts.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 .../bindings/timer/arm,arch_timer.yaml        | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index c5fc3b6c8bd0b..c65e48a155ab6 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -10,13 +10,8 @@ maintainers:
   - Marc Zyngier <marc.zyngier@arm.com>
   - Mark Rutland <mark.rutland@arm.com>
 description: |+
-  ARM cores may have a per-core architected timer, which provides per-cpu timers,
-  or a memory mapped architected timer, which provides up to 8 frames with a
-  physical and optional virtual timer per frame.
-
-  The per-core architected timer is attached to a GIC to deliver its
-  per-processor interrupts via PPIs. The memory mapped timer is attached to a GIC
-  to deliver its interrupts via SPIs.
+  The per-core architected timer is expected to deliver per-CPU interrupts
+  (commonly to a GIC to deliver its per-processor interrupts as PPIs).
 
 properties:
   compatible:
@@ -33,13 +28,13 @@ properties:
           - const: arm,armv7-timer
 
   interrupts:
-    minItems: 1
+    minItems: 2
     items:
-      - description: secure timer irq
-      - description: non-secure timer irq
-      - description: virtual timer irq
-      - description: hypervisor timer irq
-      - description: hypervisor virtual timer irq
+      - description: EL1 secure physical timer irq, if EL3 is implemented
+      - description: EL1 non-secure physical timer irq
+      - description: EL1 virtual timer irq
+      - description: EL2 physical timer irq, if EL2 is implemented
+      - description: EL2 virtual timer irq, if FEAT_VHE is implemented
 
   interrupt-names:
     oneOf:
-- 
2.47.3

