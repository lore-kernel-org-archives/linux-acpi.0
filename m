Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CD63F075E;
	Fri, 15 May 2026 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888350; cv=none; b=X2guYGy61hu78vi+wrVffWQHNDHmyL6svP2tszhMBVBboceCAjMWbyTBQu9KfPy0PGSTX3NOdjbD06UsOW9c8RHUuyVYP3YQTw8hJIk8S/ke8T+CKxgNH/F0ASYbsV7f4jjyuwonw1tDprf7oaSp8IDiW5d8ZgIWEF0M0/5NI0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888350; c=relaxed/simple;
	bh=hcyi/oQQYFZ0VBh4EERVTQPgaMQsOUZKGv3aL0avj9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrlY2a57FkmBoUQ8LHG+Xn4TmGW9hEQ71cxL/WrvM59uqNiYYOm61Kc6UOD1JTxPEcSPC1PBhRIv2PVT8D1e4hj4I7b/2TGL50MDclvuZvAo2g49xOcwnJphQC72LsSk4tcsPt36IFetv5npfe1dU7Wrx8PSaMPsbYu4VIq7U4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pPkwFu5D; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pPkwFu5D"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF5B022FC;
	Fri, 15 May 2026 16:39:01 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DABD3F85F;
	Fri, 15 May 2026 16:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778888347; bh=hcyi/oQQYFZ0VBh4EERVTQPgaMQsOUZKGv3aL0avj9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pPkwFu5D+YbH2+PpMwRTpME8igQ1y2qLUKm9sYXy4XipkRaiTw+MnZkf3cLn1Ge7O
	 HVAblJg3cV+31efMuWUyKMt2R7inzWu4pynGFnlLK2OBD3Um9meAy+J1U5xXLJ/i8U
	 /tDMGc53F7bdHTNTw1tBhaCIVUVWPaIpCFa8JIdM=
Date: Sat, 16 May 2026 01:38:15 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
 <sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ge Gordon
 <gordon.ge@bst.ai>, BST Linux Kernel Upstream Group
 <bst-upstream@bstai.top>, Jesper Nilsson <jesper.nilsson@axis.com>, Lars
 Persson <lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>,
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Dinh Nguyen
 <dinguyen@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Andreas =?UTF-8?B?RsOkcmJlcg==?=
 <afaerber@suse.de>, Heiko Stuebner <heiko@sntech.de>, Shawn Lin
 <shawn.lin@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Michal Simek <michal.simek@amd.com>,
 linux-sunxi <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH v2 05/17] arm64: dts: allwinner: Add EL2 virtual timer
 interrupt
Message-ID: <20260516013815.6dd21da3@ryzen.lan>
In-Reply-To: <20260514150945.3917510-6-maz@kernel.org>
References: <20260514150945.3917510-1-maz@kernel.org>
	<20260514150945.3917510-6-maz@kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 16:09:33 +0100
Marc Zyngier <maz@kernel.org> wrote:

> The ARMv8.2 based CPUs used in the A523 SoC (and derivatives)
> are missing the EL2 virtual timer interrupt. Add it.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Works, with [v2 03/17] and this patch I see the arch timer IRQ being
int ID 28, and working, where it was 26 before. dmesg confirms that:
[    0.000000] arch_timer: cp15 timer running at 24.00MHz (hyp-virt).

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> index 5afa8d92acbfb..d3c47966e8fc8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun55i-a523.dtsi
> @@ -101,7 +101,8 @@ timer {
>  		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> -			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
>  	soc {

