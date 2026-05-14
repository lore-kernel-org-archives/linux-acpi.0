Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9D5429801;
	Thu, 14 May 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771404; cv=none; b=oe/mdlOxnFJImo5P3V0NpaOJM3VlFkYZmkmkuwu2yAaFR6339+g5HdhRar3OEZzGvkjWSN6d7SnfdwYa3vIwMNtmbmb/S1es1D1TuHN04RTMK20eYl8S8pcJETG6viQwFx/YfWlAnK5ainBPrWq8HqJ2nVm/yfafbI+2AEonVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771404; c=relaxed/simple;
	bh=C8QlCN0PZK11mrLCs9oNNpttQLwIcnWA9/xtBgloldA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mwzdhw/ybiB256+UcBmHcWsphtybFWIlBxI77FvCVaOqjpvA7/Be/7TIl5rHnqZo2SPTUqTcpWF3wheypfDBEitU+c8V++j7855nEPBsZktQtAS5u+1ZgZufWdXAU6Tm6HE1/JedSUqrOCu0o4NmyFpQenrbujmTQfuIb+JrD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB+58+95; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB+58+95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDB1C2BCF7;
	Thu, 14 May 2026 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771403;
	bh=C8QlCN0PZK11mrLCs9oNNpttQLwIcnWA9/xtBgloldA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bB+58+95/TzzBp24rUI1z+IPih41NT7A/xFOGhhrt9+ymAUJrMnkFNP0tEkE8O9ht
	 RYqH2VnHH4wOFjCe/KwMDKhbub8irBzh+dK/9rHHg1NPuSSiWzMsen183uWoIEQqRF
	 5T9VkrXghJJHurlvTptdq5eDcuKEg0SFD1zfLYD110W8zLO8Zbw0ou7IBXlrcsZH/b
	 9Ag3w/NfzTHpDcywEmH8w7RtdYotx5MO3Y6pPUqO+HLDn8Tlwld0ivnZoTEx4vv+VQ
	 29jjeKo/cv5tE5bsaRmDgAs8nYYHn2AjK/zcOJhFIS6pOTdR0jgn9anzZQ0PEinmLk
	 B1BfOWhNpic7A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wNXhI-00000002Oqg-3wPw;
	Thu, 14 May 2026 15:10:01 +0000
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
Subject: [PATCH v2 11/17] arm64: dts: mediatek: Add EL2 virtual timer interrupt
Date: Thu, 14 May 2026 16:09:39 +0100
Message-ID: <20260514150945.3917510-12-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514150945.3917510-1-maz@kernel.org>
References: <20260514150945.3917510-1-maz@kernel.org>
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

The ARMv8.1+ based CPUs used in a number of Mediatek SoCs are missing
the EL2 virtual timer interrupt. Add it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt6779.dtsi | 3 ++-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 3 ++-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi | 3 ++-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 3 ++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
index 70f3375916e8c..106df7603d533 100644
--- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
@@ -108,7 +108,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW 0>;
 	};
 
 	soc {
diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
index b91f88ffae0e8..a4621ce370d8e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
@@ -815,7 +815,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW 0>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW 0>;
 	};
 
 	soc {
diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
index 75133794cec38..614e75f46c72d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
@@ -918,7 +918,8 @@ timer: timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH 0>;
 		clock-frequency = <13000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9f8f115edd4cc..873c4fae6afc9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -328,7 +328,8 @@ timer: timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH 0>;
 		clock-frequency = <13000000>;
 	};
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index c72e34c57629d..3c9a7a08612b9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -451,7 +451,8 @@ timer: timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
 	soc {
-- 
2.47.3

