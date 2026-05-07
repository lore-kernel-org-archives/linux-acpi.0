Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B644CF25
	for <linux-acpi@vger.kernel.org>; Thu,  7 May 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168656; cv=none; b=BbDBqrUldaVnN/Xw5Ms2c+9LYom1aljwj+S6a6LOXKFgcJfEKffacVlY4SKAdrQPMOQHiM0zsGXEtempVVyoxRB080rX5ZbZ7e63NLEJkjoxxI80s/FCLEHB90ROaT1olBe6Tdfr2RpJTk9omZK2aFwXsOahXj/WN+yVg6pfqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168656; c=relaxed/simple;
	bh=gqgpcPPyoYkctF2A9qIrFAW4scyW1u6DRT1WbSeDKyg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZBCVB1wzJgA5pOrNYMJGP9E9ScBXZUEsvuTxQjuXWexZcfq3fDMuwK43ZzNBpEbIFmYDu/LF0PMjgzHoK4ik1c6mCIGxqeiPG3cR0YhHQTj27rcT552Vb3Cng4jY21WXMeaswbZNWqnCIY3wtpz9/ZL0G0L9L/p0mO2dwePmstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWb1fRRj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWb1fRRj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ad135063so9590775e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778168653; x=1778773453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeEODZjRA4liT1mQOVL+XlN6FECQ6ttZUbZtASXBGIA=;
        b=wWb1fRRjnuILbV+weSoENn1q38jLQaNngtxxES34zSGzmlFJeivBQ68tBjri+kF1z9
         DBw7q/cPH5wbrlOXKy9UQ8FEM9M/EVxijpDfwMAlrgsrZI2DFALwsb0paJrsI8/naPmN
         GrHzx9UztjOs/T1v5XJ9GfGM/uX7UA9yxnltMx95AYVsIG6LFVZGHSB9uK095RCvXJaq
         7HwOTc+31KV32Igcoz+e1sHERj84Z3uTwsBlQhSDwRlm00n2tXV7KPtRCuX7wD+F+3hm
         +7mLXf+crnikC13oV4ZBafEP3AX62KxPkSqwde3GY37Ms9ZnG3Khj0kuH1PQAOFVOgu4
         0Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168653; x=1778773453;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeEODZjRA4liT1mQOVL+XlN6FECQ6ttZUbZtASXBGIA=;
        b=F8Vt5JbC6TN3q634ttVNWtcfEdVC7x8H/bzkPU8LsawQ1eaBdD48KUabUijwiXH98h
         ZXqNsBk0KkgkQ8UyUfluBdAUv2JzcIxPPpkPh+9DQaQQ+4YTK9kci8OM13kyiIKVPa1h
         t18FUCy9S51Nnf1R+dlNQjTsBz4yNHCg72rwlwXHcQ5uKtj/8i7JCzRxCXEcb4HVq7tn
         81tJyS26DbY2KRejnEHAoBuEnwkf34QqeTLFeTSPsdSUwU6MlypMIu3lMd5sOfuY5VbM
         aP4P387ut56aX/eOgNt6ICt5zFOpshVBLRPACLR8dUsOhBpxuoJUX1Gnzn1II4wF5Jc1
         a78w==
X-Forwarded-Encrypted: i=1; AFNElJ+NxEOxWO5zp3cT6zg5SvFB7swc+IeDiA4wwJNrXxfCiuXx9u4V6xmtCp8AAUpsJGGxUjFMgRm9lYyu@vger.kernel.org
X-Gm-Message-State: AOJu0YwFbzCxR6PDkPzyoTyZ7uXaHXGR54JjWq/pm0r9PslfHqGHL07I
	wc6lI2Ri+tYg/n302LRf6G93DVYzkgT+Eg+kl2q77LMyBibp3jocfiN/V45137Y6HLs=
X-Gm-Gg: AeBDieuStfgslg+4jK4mO3sKY3tfWz/GDH5z5KatxgwmvdwJS5tuiDrxYveuROSp3qH
	5bTJx7R29U5pBS5v/WtFJ+Qqk1dcJ/bVp7pen+ogDQlpskPokzsJd7pGDYP5M8LUWqZ5d9l8rRw
	sBXijAFiMOyV+TOGiIoljugPiTFg49YaNwIAxIddZGjeJg0y0Fqm+HwT9dhb8h1akie8W5Atgnm
	PEgUCGaESJspfnggo3IGPpCn70l2CqV/xV3dVUBy7SQydlQDZg0lbI17k4NQui4wcg64FoTIynT
	+ZtQZDqJGkswxz87GN2nunR49/6k4GTyJ+KRRII8UDqz3Y4dFlZW/wps7Ld+cdVw7Eg18YuXhyn
	ijXVbunY4ahi1XZaTSFi0hsQy/D/8FaDDo3vSM3fxO3bDyl6ieLSJObzUXVUi0Qzbr9fPiOQqNx
	/D4MJaL5GS3V/yFaftT8u50YHsKOGA2U4BzDQoBfKq9YSvA8fS/qBpRTDuqSmoMNFXs62P54VfI
	zAABYCPuadzl8z9V8UUftpJmCqO
X-Received: by 2002:a05:600c:8485:b0:488:af7f:775f with SMTP id 5b1f17b1804b1-48e51f32a64mr146074295e9.18.1778168652626;
        Thu, 07 May 2026 08:44:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6762:47bb:1e06:ff70? ([2a01:e0a:106d:1080:6762:47bb:1e06:ff70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538aaa0fsm161995425e9.7.2026.05.07.08.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 08:44:11 -0700 (PDT)
Message-ID: <b8dca238-e791-4185-8a0b-cf7a44b9f5f6@linaro.org>
Date: Thu, 7 May 2026 17:44:10 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/16] arm64: dts: amlogic: Add EL2 virtual timer
 interrupt
To: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
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
 Konrad Dybcio <konradybcio@kernel.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Michal Simek <michal.simek@amd.com>
References: <20260507125544.2903406-1-maz@kernel.org>
 <20260507125544.2903406-6-maz@kernel.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260507125544.2903406-6-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/26 14:55, Marc Zyngier wrote:
> The ARMv8.2 based CPUs used in a number of Amlogic SoCs are missing
> the EL2 virtual timer interrupt. Add it.
> 
> This requires some surgery in the "common" files to move the timer
> node to locations that makes it possible to add the interrupt only
> where it is actually implemented.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi |  8 --------
>   arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi        |  8 ++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi        |  9 +++++++++
>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        |  3 ++-
>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        |  3 ++-
>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       |  3 ++-
>   arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  | 13 -------------
>   arch/arm64/boot/dts/amlogic/meson-g12.dtsi         |  9 +++++++++
>   arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         | 10 ++++++++++
>   9 files changed, 42 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> index 54d7a2d56ef64..6f559e4dd9ee9 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
> @@ -7,14 +7,6 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
>   / {
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> -	};
> -
>   	psci {
>   		compatible = "arm,psci-1.0";
>   		method = "smc";
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> index fce45933fa28b..c28fc7fcbae7f 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
> @@ -86,6 +86,14 @@ pwrc: power-controller {
>   			#power-domain-cells = <1>;
>   		};
>   	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
>   };
>   
>   &apb {
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> index 2b12d8284594f..c22c0acb4807e 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a5.dtsi
> @@ -49,6 +49,15 @@ pwrc: power-controller {
>   			#power-domain-cells = <1>;
>   		};
>   	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
>   };
>   
>   &apb {
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
> index ab3acef2b147e..853d32929ff46 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
> @@ -56,7 +56,8 @@ timer {
>   		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
>   			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
>   			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> -			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
>   	};
>   
>   	psci {
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
> index a3faf4d188e11..bfaac5f3e22da 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
> @@ -94,7 +94,8 @@ timer {
>   		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
>   
>   	psci {
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
> index 0c4417bcd6827..32d8683059964 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
> @@ -58,7 +58,8 @@ timer {
>   		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
>   
>   	psci {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 00609d2da6743..a911a5181a88d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2579,19 +2579,6 @@ map {
>   		};
>   	};
>   
> -	timer {
> -		compatible = "arm,armv8-timer";
> -		interrupts = <GIC_PPI 13
> -			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 14
> -			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 11
> -			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> -			     <GIC_PPI 10
> -			(GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
> -		arm,no-tick-in-suspend;
> -	};
> -
>   	xtal: xtal-clk {
>   		compatible = "fixed-clock";
>   		clock-frequency = <24000000>;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> index 664912d1beaab..866fc07d1b0ae 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> @@ -43,6 +43,15 @@ tdmif_c: audio-controller-2 {
>   		clock-names = "sclk", "lrclk", "mclk";
>   		status = "disabled";
>   	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,no-tick-in-suspend;
> +	};
>   };
>   
>   &apb {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> index 8f5b850b1774f..77c72936ffdd3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
> @@ -128,6 +128,16 @@ l2: l2-cache0 {
>   		};
>   	};
>   
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 12 (GIC_CPU_MASK_RAW(0xff) | IRQ_TYPE_LEVEL_LOW)>;
> +		arm,no-tick-in-suspend;
> +	};
> +
>   	cpu_opp_table: opp-table {
>   		compatible = "operating-points-v2";
>   		opp-shared;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
