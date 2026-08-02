Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689523B63E;
	Sun,  2 Aug 2026 03:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785642575; cv=none; b=LidHkCtnWYsKq+Mae6qvSvfYvNPS5zRtb2AYUvb/oVdJIl7giTcB5Y9elyFHgNTfyX8ugIZczD6J3hENsKD7o5oZ0w9sEmqeiGvBnprNMbqLXkfawYneJ1fs5y4ary3p498R/KPXhVtkuEkaUiklcfIw+GGP2v1l6EEKf8gyERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785642575; c=relaxed/simple;
	bh=wHKh70j3cXTbJUHExt3hHRo3L6k8fFuDHbL3qYYoOOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6BbocMKWKnvqShjVwuUhR1pm72u+iMyigE/LRRFv1cceANDGig4bcY3nT68l2jEsKgK+wngdcfFbBRiv7NMxlj5kvGt1ELwPw3zFJORI2+OBbkEX+3A1azxcuwLN1Stus5HWSskHtqDIN+H1QzDUyk4U5XtKhEyIcQteNXbKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYTEJxj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYTEJxj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D21F00AC4;
	Sun,  2 Aug 2026 03:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785642574;
	bh=zT/ZqDsPgYHGke/D7GmpQMsslvQKBzbQsXJCmcrK93g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FYTEJxj3LJN/b4Us9Qr8bZNPRF0LMQd1xcAcDQiNcgzWLh/Brw5/eoxnZFCsLdhP8
	 4NqfXmsWqvsS/kWdmp2F/OZIKtsDhQl329L7kAszW+tz+HvTnh2xjprZMHaH8swCFE
	 f1BVcfWSThRVqB5SAB2NhtFn+gGTWDd4x19X4UZCj9ivjvVTJ5Lf6OjVUbRwzXJrsw
	 hrfOwG5d73mfA9SXMbl6jKDME29Sm9w3TLC9Vg3SXGEcdRjZuTA7SMms0t04xdQyT4
	 YF0bqo2Zd9q1Q5g7ShqcLkN7Zi/MJ4mqEK5wkx9KmdDh+CWoPzFAmckgkSdo0oICeC
	 twEGDBTRun8VQ==
Date: Sat, 1 Aug 2026 22:49:30 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ruidong Tian <tianruidong@linux.alibaba.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, faruque.ansari@oss.qualcomm.com, 
	avaneesh.dwivedi@oss.qualcomm.com
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: monaco: add RAS error source
 nodes
Message-ID: <am69fjQNTv2xJonT@baldur>
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
 <20260720081954.1858180-4-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720081954.1858180-4-umang.chheda@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 01:49:53PM +0530, Umang Chheda wrote:
> Add RAS error source nodes for the Monaco SoC.

Why is the subject "repeated" here?

> 
> Two processor error sources are described: a per-PE node covering the
> L1/L2 cache hierarchy using a PPI, and two shared L3 cache nodes for
> the two CPU clusters using SPIs.

Please read
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes
and don't assume the reader know what this is and why it might be
useful.

> 
> Co-developed-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/monaco.dtsi b/arch/arm64/boot/dts/qcom/monaco.dtsi
> index 64fc0d592282..4fbd1dc9a147 100644
> --- a/arch/arm64/boot/dts/qcom/monaco.dtsi
> +++ b/arch/arm64/boot/dts/qcom/monaco.dtsi
> @@ -724,6 +724,36 @@ system_pd: power-domain-system {
>  		};
>  	};
> 
> +	ras-l1l2-0 {

Why is there a -0 suffix on this node?

Regards,
Bjorn

> +		compatible = "arm,ras-processor";
> +		arm,num-records = <1>;
> +		arm,record-impl = /bits/ 64 <0x1>;
> +		arm,status-reporting = /bits/ 64 <0x1>;
> +		cache = <&l2_0>;
> +		interrupts = <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "fhi";
> +	};
> +
> +	ras-l3-cluster0 {
> +		compatible = "arm,ras-processor";
> +		arm,num-records = <2>;
> +		arm,record-impl = /bits/ 64 <0x2>;
> +		arm,status-reporting = /bits/ 64 <0x2>;
> +		cache = <&l3_0>;
> +		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "fhi";
> +	};
> +
> +	ras-l3-cluster1 {
> +		compatible = "arm,ras-processor";
> +		arm,num-records = <2>;
> +		arm,record-impl = /bits/ 64 <0x2>;
> +		arm,status-reporting = /bits/ 64 <0x2>;
> +		cache = <&l3_1>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "fhi";
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> --
> 2.34.1
> 
