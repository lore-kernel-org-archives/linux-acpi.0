Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913709;
	b=mOVQf8A3Do3ILswoaCXwswJf2KYXHxZ2WdgMW9nNrQqNGcAoPJVNpRGhYeQ2vCWERHLZ
	 9lTCTfSRBvvfvlR+4HivUp7v5CvTCGaV2Vv69qHhGLZr/xHHsJvk8PxhI46rmlfOg/6rL
	 0+7dLavKvIb0SayMRGMEOIkbI4BCVx8gTCLJb6zVXHDT3+2/4J5GSEAtVeDK/jGxyogk4
	 aZJpZUfeqpP/grdV/e3Rem+JXv4iVvM9nePQRr3S64ccYVF8VeY7fm7S5Rf7/lPSl6SH5
	 B9BEcSMfsTeTQLbvtVqvey5+Gc4WFwFi1BFGaxnAbhMs1DYruiZd1f+qsEAjLE8fN0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913709;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=kLI25bkyEOpFVWxpFGa0Dc97choniDCAakGqUy11xdk=;
	b=Qm0NtL9nSD4DD0y9nXWePILPRJn6EGxFmfLj/NkDIabSjZNcZ7zgjNMCF2cT791rocdj
	 Es3B0h3svYA5HYVgQ4VVA92OKn9M7Iil9XF2JqCYgelTuJ8FrAutK6hKo+ERiYHNYmimX
	 EnCLvOkTsscDJYQTyBwoLuU9PPh2En4B3ubdC75KuZkdYFc3MWIxuiGIDW1NJHa2xBsr/
	 KZtXbvAecTZiTH1egzBcbIKU4cAuYzf10UlUNwg4US+KD+0U8RNCFoUj3lSo/rgblIxhQ
	 HUlP4WitZB6smHptfr1rtZx9PQxWBtTM7Rebhjqi0499UZR0Ksu3RWPoGAjOSiy4qDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=heECBdo3;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0288606A31C;
	Tue, 17 Nov 2026 11:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0288606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=heECBdo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794913706;
	bh=oxvQViMU6UamivpQ1Wc/wZITpefIgLczFvQSjzV78bI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=heECBdo3wDplXuRnvnV0cnRaSqjQC4O0371jNkrw0g5rtXP6vayb2jwPbg7pQdpRH
	 3Vvw81nX9fJ6wJuaiqoeOd5P7z+W+vEbktu2seaSXFJZu9UNCocZWUCyM9lHEeQYcC
	 Fuc8ApGGeSkVKTKP7sCG6nIATe5hy2YxvnB2d011Ra1R7JlprbB239UAOlncHQxqfi
	 dBDOvt2u2lkX29e+3YSBozN3N4/ovp4OAr4+cbdOXoLQZGxdb6S08HrjQLi+ebc9T+
	 oUACaS1MV6Pn5LJz9IK9jgDE5iY+wbv80Ps1aLUmG75uGKQGj5NwGEu8UM/OdbHJIO
	 7V/XYFh3lWc4w==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 409A117E04B2;
	Tue, 17 Nov 2026 12:08:25 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
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
Message-Id: <179491370519.165314.8991090307928183984.b4-ty@b4>
Date: Tue, 17 Nov 2026 12:08:25 +0100
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

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

Applied to v7.4-next/dts64, thanks!

[11/17] arm64: dts: mediatek: Add EL2 virtual timer interrupt
        commit: 0b3f2f7ff214827043a13549e1af6bd73f192768

Cheers,
Angelo


