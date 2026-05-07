Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9033FB7EA;
	Thu,  7 May 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158565; cv=none; b=Bk7nxo6BGTFK+t2Qnmx/eEZp9W5KcCyWzlZMwh/CPz7w/aY2oDpVjFAyIqoXU8afOluoO6SYaNDDS+cUmDGeReuDmcx1tGe+pfrX1n2kXwA8TFlTW6//DN/g6+NZa0Qzcy78yHBUzwTsR1+EBUI3rZ7d6zO83ZaVysuDIemZzgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158565; c=relaxed/simple;
	bh=SYhI9mJBt1jThfR8leDkHslN2mb7/RuCI4SqdrZLTgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCeT7d0wmcmdHrv6LTrM3lih34LEqmO40bl0VGSUC083z4mbAK9wFxgzCikXBU+H/59U3EZ8fu92/HosMx1O4sbKAy2PhH2KAbvIBAzRm5pDZQAYPJkkkEzC6GXunX/m2Bwnu1w6/8+E/PX5bMPBaMkNjUCH3DIpWDSqHTVRTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhTDYUy0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhTDYUy0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA50C2BCB2;
	Thu,  7 May 2026 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158565;
	bh=SYhI9mJBt1jThfR8leDkHslN2mb7/RuCI4SqdrZLTgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhTDYUy0LChzu5wk460Wge5SOK0ExlLyUYnYlhPW/woJs8d6kUiQoRDzzXSuiv91o
	 c3NCWdMOXnZjlfKDUVXWitE9/W6I97Vt9Y9wU8PJJx+clBmhiSztezpCRv1xM5ujli
	 CxpF7Vabun9pfNHWQnLJjnBSKQDtWZNxI3hgaOkVaPzxalDZ4HWK6pCN8v74TmojAb
	 khLWxxiPE1z+6pB1gsXdMTuXUCkq4jhCz1b9ibkZ8vnLRB+YgqNVcEUj5CuGu5EijG
	 ebUlou64uatzFUHhSEkYLX4iObiPiVw86xFzZq+L52c5yqk24V4vNuVSsmSmErl0w+
	 LmUI+QuR7ZxNA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKyGp-00000000d7d-0Cro;
	Thu, 07 May 2026 12:56:03 +0000
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
Subject: [PATCH 15/16] arm64: dts: sprd: Add EL2 virtual timer interrupt
Date: Thu,  7 May 2026 13:55:43 +0100
Message-ID: <20260507125544.2903406-16-maz@kernel.org>
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

The ARMv8.2 based CPUs used in a number of Unisoc SoCs are missing
the EL2 virtual timer interrupt. Add it.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi | 3 ++-
 arch/arm64/boot/dts/sprd/ums512.dtsi  | 3 ++-
 arch/arm64/boot/dts/sprd/ums9620.dtsi | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 31799579d7f2e..18e61c25aa36f 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -130,7 +130,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>, /* Hypervisor physical PPI */
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>; /* Hypervisor virtual PPI */
 	};
 
 	pmu {
diff --git a/arch/arm64/boot/dts/sprd/ums512.dtsi b/arch/arm64/boot/dts/sprd/ums512.dtsi
index efa14309cc4ef..4105647aabd17 100644
--- a/arch/arm64/boot/dts/sprd/ums512.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums512.dtsi
@@ -133,7 +133,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>, /* Hypervisor physical PPI */
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>; /* Hypervisor virtual PPI */
 	};
 
 	pmu-a55 {
diff --git a/arch/arm64/boot/dts/sprd/ums9620.dtsi b/arch/arm64/boot/dts/sprd/ums9620.dtsi
index 2458071320c9b..037e3401d4991 100644
--- a/arch/arm64/boot/dts/sprd/ums9620.dtsi
+++ b/arch/arm64/boot/dts/sprd/ums9620.dtsi
@@ -141,7 +141,8 @@ timer {
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>, /* Physical Secure PPI */
 			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>, /* Physical Non-Secure PPI */
 			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>, /* Virtual PPI */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>; /* Hipervisor PPI */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>, /* Hypervisor physical PPI */
+			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>; /* Hypervisor virtual PPI */
 	};
 
 	pmu-a55 {
-- 
2.47.3

