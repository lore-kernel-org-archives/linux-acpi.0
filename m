Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795029946;
	b=1cGUxfmZ/sK/NbrzuEialHlSQD5DsOdC3SqiwKS2lEFqgHDrAaH2W+NlZQu26qDMN4t0
	 CJwLjRu1GbMrTTCiyk/NUdGLlJbmBxzIB9c7bgpG8LS+U2HmQfel4L0u0xR8Ssak6LkLQ
	 PNGV27+61foOnAoJelB55SKoBs1xowRYhcqXhZoYkjTWlePWCprUkJwQfIddQ+x5F0b8Q
	 bM8fT9T2tc121NziHhLfZWrMQzOXxLSbtdq61gsZqQZcw21iUnjwA2NR1xCuOfsTNl8Bu
	 cP+cLncTNGTCfMCC7c7U16fOsXWr0wY03Sj4nJR2lIFP3zTpZgaSCEGaTewSVakS7fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029946;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n6Pt66wYYAB7YiGLR+iun8iZYXIL16iCn4Z4QJ39GVY=;
	b=Tvtivne7RaLhZDEx9+oyq9+X8V0e+YKxyhipcewktblAaeaM4/RQfAf3dUIyl/rJHyK1
	 dObcCbWLOoP4OFhjsnHu+6EftZiXI1Qs7AZ21/nu0Fql/OlrQVVCBhcgFOpnYdItq+9fu
	 nRswEYiFm/283pU+W56VqblyXAFyIcHSF2PhLii/OX/XTlcEtwMB7B/HcsTyXOTWUuKjW
	 Vjsf9zXVjrA7nXBithzL5A+Wms5hiuGD1KdsHks9CYOAnLpxQGqptybKObDCcAjqlA8Vf
	 0QWEErAJi2res0E2UE7F9GjgG4+98uUhKrD9ZZHVqstCFoPWjR8fZ/XNzinpuVpruoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct64jBlu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD89606A320;
	Wed, 18 Nov 2026 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ct64jBlu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BAF1F000C6;
	Wed, 18 Nov 2026 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795029945;
	bh=n6Pt66wYYAB7YiGLR+iun8iZYXIL16iCn4Z4QJ39GVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ct64jBlu1GaovN6tR0kD0NzNn4ECw12nH75D56VTO9j075dMnchB1RF2dRY9GrNcO
	 XiFvikK3lRo+Zpel5LhcFkbVu41sdSblJU4WeUoHXp9xrE0Yh4x3r14jZa8DKqKSVK
	 CIQefNNYidVYzuQy6DWiSxcyWDJOFU5f1DEM1t7RSGbnUvPFaDg1WZW8hB59nsa6K4
	 2mQTFn2mKo2mIOByQson+9dti65Ln/AsGik80r9shhl+2BPNee9b5RRJzGhoSrIsSv
	 CwYinvF7KsNzC3zG+u1SDwCPpb9UwADEisCwX+n1U1nJoCWuM0ZiMiadtoMJ2D8PjX
	 v01FMsH+4MWzA==
Date: Wed, 18 Nov 2026 13:25:43 -0600
From: Rob Herring <robh@kernel.org>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	James Morse <james.morse@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	Avaneesh Dwivedi <avaneesh.dwivedi@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/5] arm64: ras: Add Device Tree frontend
Message-ID: <20261118192543.GA261024-robh@kernel.org>
References: <20261118-aest-devicetree-support-v4-0-936587251e8f@oss.qualcomm.com>
 <20261118-aest-devicetree-support-v4-2-936587251e8f@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-aest-devicetree-support-v4-2-936587251e8f@oss.qualcomm.com>

On Wed, Nov 18, 2026 at 12:48:21AM +0530, Umang Chheda wrote:
> Add a Device Tree frontend for the ARM64 RAS driver, allowing it
> to be used on platforms without ACPI firmware.
> 
> The error sources defined in DT are registered as arm64_ras platform
> devices at boot. The frontend produces the same software fwnode properties
> as the ACPI path, so the core driver probes DT and ACPI nodes identically
> without any firmware-specific knowledge.
> 
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>

[...]

> +	ret = platform_device_add(pdev);
> +	if (ret)
> +		goto err_put;
> +
> +	pr_debug("registered RAS node %pOF as arm64_ras.%d\n", np, pdev->id);
> +	return 0;
> +
> +err_put:
> +	platform_device_put(pdev);
> +	return ret;
> +}
> +
> +static int __init ras_of_init(void)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *np;
> +	int index = 0, ret;
> +
> +	if (!acpi_disabled)
> +		return 0;
> +
> +	for_each_matching_node_and_match(np, ras_of_match, &match) {
> +		u8 node_type = *(const unsigned long *)match->data;
> +
> +		ret = ras_of_init_one_node(np, node_type, index++);

Why are you rolling your own platform device creation? The DT 
infrastructure will create devices for you. And likely you are getting 2 
devices for every node because you are not setting flags on the nodes to 
prevent that. But setting the flag is not the right thing. Moving all 
this code to driver probe is the right thing. That probably means some 
refactoring have a common probe function that the DT and ACPI probe 
functions can call (assuming there can't just be one common probe).

Rob
