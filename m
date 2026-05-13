Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012B3E559F;
	Wed, 13 May 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665321; cv=none; b=l2/zS8Ltrn04PWytCszJ1NLSgYozMWRipccPS9EM0tXAo8ly+hrAU/wAGhgW01IQIXsEsAAFId8lccG6zoVkFqs70186nSN5vGzokpZpRtvTEzoy7OSlVnTfQ+U0eXZZQz1KcZW83P3r4wRLQIeoopctuI/RBlTEBUeeFyLJw+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665321; c=relaxed/simple;
	bh=FRzh2TqI6eV1IGDJSpXe9vTknIKuMbT0qAfdYLMNBU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFcqDIs/DcT2XcYRFR75m38wAhDQd4Tx32PP78VsoLGEkcwePGOA3JBD8AStqZjL5vqKjMEb4mkf3lIR7e8FwQmkouruWV4SIyQBLmEO2UMSSsu8ePooD2112BPrws747tObe1pYYrKQ8WWL0CA1AyCXu55Oh8IGSTt8jEmL4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS7nBPA/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS7nBPA/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D72C2BCC7;
	Wed, 13 May 2026 09:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778665320;
	bh=FRzh2TqI6eV1IGDJSpXe9vTknIKuMbT0qAfdYLMNBU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uS7nBPA/KMSgwEaT99+fPUSNMe2gzrvpw5CRRNfXYU0BSOQ+JsRCWz8iZ82wFvt2n
	 AHaEsHctV/lpMT0x/ErtnPOAlJ0AjVQLt+XpJwLsCA6lW4eg5x+KERjrDSB+8zoTYq
	 UxbXTRzQP9u8VhK08Jr+rdJaGy/HXU7hxykGc6ulxlroFJW717+nB5HtIF2Y2vT8v0
	 pJlXmmogzfNeAOb2Sa4vZqa4wbPfHySRWvepOf3xBapGgntAZi34LzwGmP40+rUKZz
	 xyYf4ouG4TP7s7jk+dIA+9LSommSijSsIClHypoS3JOFiwCD+yhUbsl2UX0JY8axPt
	 2hnQc6GfZB/Vw==
Date: Wed, 13 May 2026 10:41:51 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
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
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 01/16] ACPI: GTDT: Parse information related to the EL2
 virtual timer
Message-ID: <20260513-crouching-stirring-pigeon-6e46bf@sudeepholla>
References: <20260507125544.2903406-1-maz@kernel.org>
 <20260507125544.2903406-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507125544.2903406-2-maz@kernel.org>

On Thu, May 07, 2026 at 01:55:29PM +0100, Marc Zyngier wrote:
> Since ARMv8.1, the architecture has grown an EL2-private virtual
> timer. This has been described in ACPI since ACPI v6.3 and revision
> 3 of the GTDT table.
> 
> An aditional structure was added in ACPICA, though in a rather
> bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
> add GTDT Revision 3 support").
> 
> Finally plug the table parsing in GTDT, and allow it to be eventually
> presented to the architected timer driver.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index ffc867bac2d60..1a58007fccf0a 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -88,6 +88,19 @@ static int __init map_gt_gsi(u32 interrupt, u32 flags)
>  	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>  }
>  
> +struct gtdt_v3 {
> +	struct acpi_table_gtdt	gtdt_v2;
> +	struct acpi_gtdt_el2	el2_vtimer;
> +};
> +
> +static struct acpi_gtdt_el2 *gtdt_to_el2_vtimer(struct acpi_table_gtdt *gtdt)
> +{
> +	if (gtdt->header.revision < 3)
> +		return NULL;
> +

We should validate the length as well just in case some platform bumped version
but didn't add these fields. Again it is problem if the platform timers are
also missing. We can just add the check in acpi_gtdt_init() if the version >=3
perhaps? If (gtdt->header.length < sizeof(struct gtdt_v3) invalid table or
something.

Also we have in platform_timer_valid()
	platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1)
which is still valid, but again if someone messes up in v3 keeping
offset where virtual EL2 timer GSI should be present as they just copied
it from v2, then we might allow it as valid.

Do it make sense to add that check as well in acpi_gtdt_init()? I mean
the offset should be >= sizeof(struct gtdt_v3).

Both checks can be added to acpi_gtdt_init() to avoid checking for each
platform timer instance may be ?

Other than this couple of minor nit, this patch looks fine.

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
