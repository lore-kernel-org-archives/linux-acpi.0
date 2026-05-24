Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D625B0BE;
	Sun, 24 May 2026 20:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779654650; cv=none; b=m+Aqm9JSyg/oXnCH77SEqRzvSlcTT3UpGhB2rtjs1ODXfDnoYDlOCMM2ahUbEltdFKNOLGGBAjtEO3zeiQGHvzXo4BFu7L1/T/2WlnU8HnFteAEF5l2VnjofIMXw7d/WzXF2+QC0Y2zRKXYqeBe8TZhyw2o08yTfkEMfr4JMGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779654650; c=relaxed/simple;
	bh=o1V4Nmy3LOx17RHIGtxmf5HnvgWEmJ5hWzHvd3/uzNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kIVK3OSfeocUV9FNhmEy9aIZDQVCX3VyqQjRGpIB0tpSy3xakXBerp4M/mpz6UUpaOgJRddHD2diF8iOTDvhnZwi0cAVQTy6WmL5t0USXx9DIh2jKRszRN09sPvA7HrFqWWbTowBtlS/dR65AMCAO6O9CYjA/y7vnLaNC9ADI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSFQMD2i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSFQMD2i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3EF1F000E9;
	Sun, 24 May 2026 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779654649;
	bh=WB8A2aBdfkbyK1k2ZsI0gwKIPEM6xFeE8NKoc1nioC0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nSFQMD2i5IQe5quvpGFEtpSkazvZSq0clTb1PWAZ8xOxk796XEVgzaYGdQXTsr1Io
	 5tQjAcmUfk6sSx/QwcAeq2oAoKJA/+nVoFGsH890D3AdZa4L2bI/6DtKPaq3mAKc5J
	 M3IC6GTBN+H6OylAlzXs0y2/dwVMChz70Nonf/WZAifUkkXldNS2L11fPD6SKvQZzb
	 iAdajWqT+REKxfs5DyTPqk40ZljPmELWBt+KUkPhEafppVZSOA0fjFlwy5jBqeGZ14
	 ds0ggENjvwasq+cdkIWTGhXBlNGXnZdh9wCuzITr3XMU4wuvbsjHELXWCGuED7HsaT
	 UkeiTD9U/uJFQ==
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Lars Persson <lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 =?utf-8?q?Yu-Chun_Lin_=5B=E6=9E=97=E7=A5=90=E5=90=9B=5D?= <eleanor.lin@realtek.com>, 
 Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20260523140242.586031-1-maz@kernel.org>
References: <20260523140242.586031-1-maz@kernel.org>
Subject: Re: (subset) [PATCH v3 00/17] arm64: Use EL2 virtual timer when
 running VHE
Message-Id: <177965464107.165582.7773839955520847707.b4-ty@kernel.org>
Date: Mon, 25 May 2026 04:30:41 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Sat, 23 May 2026 15:02:25 +0100, Marc Zyngier wrote:
> This is the third version of the series initially posted at [1],
> which
> 
> - updates the ACPI GTDT parsing to deal the v3 layout and the EL2
>   virtual timer,
> - moves the architected timer driver to use it when running VHE,
> - fixes a number of DTs to reflect the reality of the HW.
> 
> [...]

Applied to sunxi/dt-for-7.2 in sunxi, thanks!

[05/17] arm64: dts: allwinner: Add EL2 virtual timer interrupt
        https://git.kernel.org/sunxi/linux/c/86eeca347091

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

