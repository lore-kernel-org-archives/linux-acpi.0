Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477913537E8;
	Sat, 23 May 2026 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779544978; cv=none; b=kWOEPSNXVKlUbQP00WBOMZ4FJhyWI+IDRbKDkhSg0EFH3TPp0n9EXwmk363tmiDXvvwPIWf+k8CnwHsR9H84evPREYMTRyt4zKCUAWKZ3E109DMCchvLN6k6oGVD6zBQuMr8G0iB2lcbW4iMlPpPGT75JdFPXdwPfzlUVnio1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779544978; c=relaxed/simple;
	bh=XcI9E99lmjEqc67YZwRW1EoV9W6z7lpLdUqdqu0gSKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqDu5r0hXIUxKxa0NXIUEhoPfnT899sF2zXo5GCBlnx5isUnmJBW1yqkuPR0hHrfK1Ba6gK4RY160Ipe4OebG2IPAU3G5fkRJ3r1R3IMud5vyvifCo/yLIbdc90vsr3nfHLXm4OAnr2dMZXTj39exYylXloAd5VkPg1GnLy9cvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNxmWDzS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNxmWDzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDEC1F000E9;
	Sat, 23 May 2026 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779544975;
	bh=iKSF8GdN2oB/rm7vq210aNx19r8g8NagqG/cGhDvljI=;
	h=From:To:Cc:Subject:Date;
	b=TNxmWDzSY4CjGL/jSWZD1X7AQsa7sQupIw81htXWcH07NZ+54yTlD/isc1MRCcUZ8
	 LP922+wccqoF34JeE0Hic5ZcMjNaDmOvek63gVv5Jj55bC+2F4/nISUuukXF5l6sZw
	 fJ0pu63wSupJ+tq9rPW102ZFsAlaUv2m2ZS0siy5HsVV+JxnbqQfnbLU0CGbWpDVDj
	 BPocMK66phJqIVZzTqXIgXN5NrI4t5zn/8fznt/ojVOjNha6vfJq9dBq9b49canjJy
	 MK/ghvVNfzgkZ3KdPmoMbJGUvlqvwrqXgQuhIWmsM8M9qbCKy/12RD3xEY6NqJyxJ6
	 BWmHMjtW26YUQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1wQmwG-00000005YFc-3f2t;
	Sat, 23 May 2026 14:02:52 +0000
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
	=?UTF-8?q?Yu-Chun=20Lin=20=5B=E6=9E=97=E7=A5=90=E5=90=9B=5D?= <eleanor.lin@realtek.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 00/17] arm64: Use EL2 virtual timer when running VHE
Date: Sat, 23 May 2026 15:02:25 +0100
Message-ID: <20260523140242.586031-1-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@kernel.org, catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org, mark.rutland@arm.com, daniel.lezcano@kernel.org, tglx@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@kernel.org, jernej.skrabec@gmail.com, samuel@sholland.org, neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, gordon.ge@bst.ai, bst-upstream@bstai.top, jesper.nilsson@axis.com, lars.persson@axis.com, alim.akhtar@samsung.com, ivo.ivanov.ivanov1@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, dinguyen@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, thierry.reding@kernel.org, jonathanh@nvidia.com, andersson@kernel.org, konradybcio@kernel.org, afaerber@suse.de, 
 eleanor.lin@realtek.com, heiko@sntech.de, shawn.lin@rock-chips.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, michal.simek@amd.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

This is the third version of the series initially posted at [1],
which

- updates the ACPI GTDT parsing to deal the v3 layout and the EL2
  virtual timer,
- moves the architected timer driver to use it when running VHE,
- fixes a number of DTs to reflect the reality of the HW.

This results in significant performance uplift in deeper nested virt
scenarios, at no overhead to the host.

Patches based on -rc3, tested on Amlogic SM1, QC X1E, Ampere Altra,
and Apple M2, as well as KVM NV guests.

* From v2 [2]:

  - Add more consistency checks to the GTDT parsing

  - Match the virtual counter when using the KVM PTP backend

  - Drop a number of changes to Qualcomm DTs, being only tangentially
    related and that will be posted separately

  - Fix the Realtek Kent platform, which had the GICv3 maintenance
    interrupt advertised as the EL2 virtual timer

  - Collected TBs and RBs, with thanks

* From v1 [2]:

  - Now also using the EL2 virtual counter, which further improve
    things when running at a deeper nesting level

  - Updated consistency checks for the platform timers when finding a
    GTDTv3

  - Collected ABs and RBs, with thanks

[1] https://lore.kernel.org/r/20260507125544.2903406-1-maz@kernel.org
[2] https://lore.kernel.org/r/20260514150945.3917510-1-maz@kernel.org

Marc Zyngier (17):
  ACPI: GTDT: Account for GTDTv3 size when walking the platform timer
    descriptors
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

 .../bindings/timer/arm,arch_timer.yaml        | 21 +++----
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  3 +-
 .../boot/dts/amlogic/amlogic-a4-common.dtsi   |  8 ---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi   |  8 +++
 arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi   |  9 +++
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi   |  3 +-
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi   |  3 +-
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi  |  3 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 13 -----
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi    |  9 +++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 10 ++++
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
 arch/arm64/boot/dts/qcom/monaco.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sar2130p.dtsi        |  3 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        |  3 +-
 arch/arm64/boot/dts/qcom/sm4450.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8650.dtsi          |  3 +-
 arch/arm64/boot/dts/qcom/sm8750.dtsi          |  3 +-
 arch/arm64/boot/dts/realtek/kent.dtsi         |  2 +-
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi      |  3 +-
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi |  3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         |  3 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/ums9620.dtsi         |  3 +-
 arch/arm64/boot/dts/xilinx/versal-net.dtsi    |  3 +-
 drivers/acpi/arm64/gtdt.c                     | 42 +++++++++++++-
 drivers/clocksource/arm_arch_timer.c          | 55 +++++++++++--------
 54 files changed, 206 insertions(+), 102 deletions(-)

-- 
2.47.3

