Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CF30FF36;
	Sun, 24 May 2026 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652859; cv=none; b=euFrbbDl6Ty6tIl0HnmP8yMl6mkfV4oXYpT4iZ6Z0vG4Qq2RR6hwGDRrLSUTiUo4Iemj98egzQD4eKEc9euzITugSGyT2fn55PZcW9zNiNiq8RgUYglWD+sPQO19EZsul8cCtBu3ivFFZB7S97g8QaqC5opuEv9sDw8+vgdAPgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652859; c=relaxed/simple;
	bh=gOZXX7L0ICbMfrM4uXQoqjMWL/2EPanqb3fXzwPHm2Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bcWpbVZ86rGKsea3PXvp6/4krAaFX8ZoF+5+zQidOQn3YKrWeXXgml7f+hQGdrQIlK2FLilghuyhTIksOlwA21sFnDR0Hb7oT8S9KQr9od9oyq3oaK8nxTZ0qWzW9z57P43nG+/TXbqa72vz9IKMKqvZb8IX5b17kkjQR6vS20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf1v9JFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf1v9JFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511001F000E9;
	Sun, 24 May 2026 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779652858;
	bh=3HTBQyePaHVmHHrsauW9DhwKjo0QZV1SOvIWr7DAq5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Nf1v9JFCTQGRtLm3jZ8I45mGn9GIW8Y64UyUkOfZmmzk8HN42vBNxQwHb/5cW9rzb
	 Yqn4p5Mtd6eojzbr8tTEJJPWE34wNHMD4Lwb4RzjiKEX2AfYrh0hrngdXVG8i3gE6N
	 yosPxD34CJMAqoeyrxS49JuXZRLtFHOh7kM1PTjPzzRNtfSon/H9VvCXXA+tJZPguz
	 KgSXJY6whqzKofM93ZC0GfCIS2tL5wJNc1xgYlL2YFwyqXANSXfd1+F7yJkXVgL3MD
	 pghyiWz5HjajvWqdFmmetZMOqBDrpzmYIoaRL033NbKaKiBDIu9t9N+gaCKuqz23bb
	 nkjsBJ7iSJC9A==
From: Krzysztof Kozlowski <krzk@kernel.org>
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
In-Reply-To: <20260523140242.586031-9-maz@kernel.org>
References: <20260523140242.586031-9-maz@kernel.org>
Subject: Re: (subset) [PATCH v3 08/17] arm64: dts: exynos: Add EL2 virtual
 timer interrupt
Message-Id: <177965284903.36046.11355001676395450278.b4-ty@b4>
Date: Sun, 24 May 2026 22:00:49 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 23 May 2026 15:02:33 +0100, Marc Zyngier wrote:
> A bunch of Samsung SoCs are missing the EL2 virtual timer interrupt
> despite using ARMv8.1+ CPUs. Add the missing interrupt, except for
> those broken designs where the interrupt is documented as not being
> wired.

Applied, thanks!

[08/17] arm64: dts: exynos: Add EL2 virtual timer interrupt
        https://git.kernel.org/krzk/linux/c/d0298724f901d45c76f1f2193225706200f565e4

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

