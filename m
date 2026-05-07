Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A53F20F9;
	Thu,  7 May 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158559; cv=none; b=CMrMpdWqnKw9Skrb1TdnN6hQ/FIJyxW7CmYItqB1GUQD3+i2n2Td287+ZkstmBxsxlmF87B4P6p6SATJTfLo9qAOeRac7H2hCE9mXiEpjW+il59WhL6fVSR252DS+luGWr8Fsb0krwbWiXIdqEZEFT67wupw3ElTKBp4iOkudMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158559; c=relaxed/simple;
	bh=FsT+l541Gc3Q7KiBKJU7i6Nxs2fnWFdQHwCIG1QZY9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tofF0ZFScn3JVksYKYmIPsHHkKyAu3VEQ6RrjY1EoCXYL/JMiF2jRpHxVlJNMGiBAeCVghamP0akjnh32I2anC0cC7tsPv7/uMNYbuCXhaLo/hW6dc2T8SlI0XS9Cx+kmeeXQLSuBi/9wAjxn3vP65g6MIbfbuVk5/nA2LQEGhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbzlviSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbzlviSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE6CC2BCB2;
	Thu,  7 May 2026 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778158558;
	bh=FsT+l541Gc3Q7KiBKJU7i6Nxs2fnWFdQHwCIG1QZY9g=;
	h=From:To:Cc:Subject:Date:From;
	b=hbzlviSehE3Eeso/9orgo3CdelO5SyRunrXAgqqTz666wYOwAP4qZuCKOT8ZJVfma
	 cfORGQ69ITXIaNXxUgpsOYR9wVFADqCmmPjq3S3idVTV2CrCPWtWFFnn98U/ku0XBW
	 Uu2/YKzuNtKA/ViGpzbc/0C2TeIRb6/qMXTc5BAi9Mfz8t2Zc4P1ogKMXLyp8AV1fO
	 5kwNEwJwLE79sK1SerENnCqTHLRE00cv4WygqAke9HNb5qs9QZJ0z8Vr6UAfShwQeG
	 E2RiNIyFPENVo0ityypqieToLnEe1hXb0/ng2Jpi/YQqhB51rDNX6bcf8Pq7frPvUS
	 gviWUKCWFy5Cg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wKyGg-00000000d7d-3aSc;
	Thu, 07 May 2026 12:55:54 +0000
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
Subject: [PATCH 00/16] arm64: Use EL2 virtual timer when running VHE
Date: Thu,  7 May 2026 13:55:28 +0100
Message-ID: <20260507125544.2903406-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
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

This series aims at making the kernel use the EL2 virtual timer rather
than the EL2 physical timer when running VHE. It doesn't change
anything when running bare-metal, but is significantly better when
running as a guest as CNTVOFF_EL2 virtualises correctly, while
CNTPOFF_EL2 doesn't.

The first patch teaches the ACPI GTDT parsing about the EL2 vtimer
interrupt. The table was specified years ago, just that nobody added
the necessary logic to the parser.

The second patch is the important one. It changes the PPI selection
logic to pick the EL2 vtimer over the EL2 ptimer *if* the interrupt
exists in the firmware tables.

As usual, firmware is in a sorry state (both DT and ACPI alike), but
given that this is to run as a guest, who cares as long as the VMM is
doing the right thing.

The following patches are totally optional and can be dropped as
necessary: they clean up the DT binding to make it crystal clear that
no, you can't decide to drop an interrupt while copy-pasting your DT
from somewhere else.

They finally add missing EL2 vtimer interrupts to a bunch of DTs where
I could guess the PPI number based on the other interrupts. I've left
the Marvell AC5 crap behind as they have been creative in the PPI
assignment, and life is too short to care about it.

This has been tested both as a KVM guest and on bare metal (QC X1e and
Amlogic SM1).

Marc Zyngier (16):
  ACPI: GTDT: Parse information related to the EL2 virtual timer
  clocksource/drivers/arm_arch_timer: Default to EL2 virtual timer when
    running VHE
  dt-bindings: timer: arm,arch_timer: Fix requirements for interrupt
    description
  arm64: dts: allwinner: Add EL2 virtual timer interrupt
  arm64: dts: amlogic: Add EL2 virtual timer interrupt
  arm64: dts: bst: Add EL2 virtual timer interrupt
  arm64: dts: exynos: Add EL2 virtual timer interrupt
  arm64: dts: freescale: Add EL2 virtual timer interrupt
  arm64: dts: intel: Add EL2 virtual timer interrupt
  arm64: dts: mediatek: Add EL2 virtual timer interrupt
  arm64: dts: nvidia: Add EL2 virtual timer interrupt
  arm64: dts: qcom: Add EL2 virtual timer interrupt
  arm64: dts: realtek: Add EL2 virtual timer interrupt
  arm64: dts: rockchip: Add EL2 virtual timer interrupt
  arm64: dts: sprd: Add EL2 virtual timer interrupt
  arm64: dts: xilinx: Add EL2 virtual timer interrupt

 .../bindings/timer/arm,arch_timer.yaml        | 21 ++++-----
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  3 +-
 .../boot/dts/amlogic/amlogic-a4-common.dtsi   |  8 ----
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi   |  8 ++++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi   |  9 ++++
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi   |  3 +-
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi   |  3 +-
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi  |  3 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 13 ------
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi    |  9 ++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 10 +++++
 arch/arm64/boot/dts/bst/bstc1200.dtsi         |  3 +-
 arch/arm64/boot/dts/exynos/axis/artpec9.dtsi  |  3 +-
 arch/arm64/boot/dts/exynos/exynos2200.dtsi    |  3 +-
 arch/arm64/boot/dts/exynos/exynos990.dtsi     |  3 +-
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi  |  3 +-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  |  3 +-
 .../boot/dts/freescale/imx91_93_common.dtsi   |  3 +-
 arch/arm64/boot/dts/freescale/imx94.dtsi      |  3 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi      |  3 +-
 arch/arm64/boot/dts/freescale/imx952.dtsi     |  3 +-
 arch/arm64/boot/dts/freescale/s32n79.dtsi     |  3 +-
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi |  3 +-
 arch/arm64/boot/dts/mediatek/mt6779.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8186.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8188.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi      |  3 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  3 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  2 +
 arch/arm64/boot/dts/nvidia/tegra234.dtsi      |  3 +-
 arch/arm64/boot/dts/qcom/eliza.dtsi           |  3 +-
 arch/arm64/boot/dts/qcom/hamoa.dtsi           |  3 +-
 arch/arm64/boot/dts/qcom/kaanapali.dtsi       |  3 +-
 arch/arm64/boot/dts/qcom/kodiak.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/lemans.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/milos.dtsi           |  1 +
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sar2130p.dtsi        |  3 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         |  3 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  3 +-
 arch/arm64/boot/dts/qcom/sdm670.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sdx75.dtsi           |  1 +
 arch/arm64/boot/dts/qcom/sm4450.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8750.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/talos.dtsi           |  3 +-
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      |  3 +-
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi |  3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         |  3 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/ums9620.dtsi         |  3 +-
 arch/arm64/boot/dts/xilinx/versal-net.dtsi    |  3 +-
 drivers/acpi/arm64/gtdt.c                     | 25 +++++++++++
 drivers/clocksource/arm_arch_timer.c          | 44 +++++++++++--------
 63 files changed, 200 insertions(+), 104 deletions(-)

-- 
2.47.3

