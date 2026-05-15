Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFB3C8C65;
	Fri, 15 May 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838722; cv=none; b=CHugXIqQF6OKG4ehfRrwuOb99vO68U8hclh0GaVNw5lbjlurJEczze4QrkPkCUOlHcXb4rG6+8qNSMUYXg2UpneLqsFsJVeodfyPjydAUzODx6YXuJ5JjmULMWSu//TRdbs9VAQLa68GNWpbbDbqm9v2CJBtg9vJD3dKDURGM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838722; c=relaxed/simple;
	bh=RkB6HAVtl9jHlb71A/+OR9URWkP/BBC0JHSseBIkJNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBgOa6kE75998MvAs9xESqZ2ma2tGiNYRjt8iiiuyatmltEkzak+M+pJKtM6/I4QeMIo9iPSV6Qi78Bpoki+ic+1bgrpkTwSx3tuh+TgCqHDtGXoc1XFdPNe8Xlq+T0K8YtdxTsaVDSI5XawbUj/ZNHHggUXlAG23AdETPHjYeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrA2gvGb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrA2gvGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638A2C2BCB0;
	Fri, 15 May 2026 09:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838721;
	bh=RkB6HAVtl9jHlb71A/+OR9URWkP/BBC0JHSseBIkJNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrA2gvGbjhet/porjfOMZjR10Iyf8yPc/X6skDqji7XIzV6UsfuwDiTLDUrwlLyq0
	 Gn0B78wMNvTxcTtwzBVZP0AOiSlGyW+zwat+3PI+UTgbIj0Ph7GPB4tdvqQQfcX/Nw
	 FpcyBIUlFvstyzy0CHaA16i8jTzxV1r3D0LNhPYyJrEjzUpdWL/b0h6O+wxZxmW2wp
	 UfmdvSpTXFMalJgQTysQuKm7dOj++bpEzK3TDtC3SdSLQ2QqnLXD2ZGLp4eo37LhWG
	 /vaVoXfI0cf0kd09ZWlg1WDChJqQGfS21t+Y6VjKbUVVnd58bBdAGBHcfJrZ4gnGlL
	 /dYPgjXibnUjA==
Date: Fri, 15 May 2026 10:51:52 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
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
Subject: Re: [PATCH v2 01/17] ACPI: GTDT: Account for GTDTv3 size when
 walking the platform timer descriptors
Message-ID: <20260515-prudent-vagabond-beetle-cad34b@sudeepholla>
References: <20260514150945.3917510-1-maz@kernel.org>
 <20260514150945.3917510-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514150945.3917510-2-maz@kernel.org>

On Thu, May 14, 2026 at 04:09:29PM +0100, Marc Zyngier wrote:
> Since ARMv8.1, the architecture has grown an EL2-private virtual
> timer. This has been described in ACPI since ACPI v6.3 and revision
> 3 of the GTDT table.
> 
> An aditional structure was added in ACPICA, though in a rather
> bizarre way, and merged in v5.1 as 8f5a14d053100 ("ACPICA: ACPI 6.3:
> add GTDT Revision 3 support").
> 
> Finally plug the table parsing in GTDT, and correct the parsing of
> the platform timer subtables to account for the expanded size of
> the base table.
> 
> Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/acpi/arm64/gtdt.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index ffc867bac2d60..b9d9b8edf2df7 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -32,6 +32,12 @@ struct acpi_gtdt_descriptor {
>  	struct acpi_table_gtdt *gtdt;
>  	void *gtdt_end;
>  	void *platform_timer;
> +	bool v3;
> +};
> +
> +struct gtdt_v3 {
> +	struct acpi_table_gtdt	gtdt_v2;
> +	struct acpi_gtdt_el2	el2_vtimer;
>  };
>  
>  static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
> @@ -39,8 +45,14 @@ static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>  static __init bool platform_timer_valid(void *platform_timer)
>  {
>  	struct acpi_gtdt_header *gh = platform_timer;
> +	void *platform_timer_begin;
> +
> +	if (acpi_gtdt_desc.v3)
> +		platform_timer_begin = container_of(acpi_gtdt_desc.gtdt, struct gtdt_v3, gtdt_v2) + 1;
> +	else
> +		platform_timer_begin = acpi_gtdt_desc.gtdt + 1;
>
> -	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
> +	return (platform_timer >= platform_timer_begin &&
>  		platform_timer < acpi_gtdt_desc.gtdt_end &&
>  		gh->length != 0 &&
>  		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
> @@ -169,6 +181,7 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>  	acpi_gtdt_desc.gtdt = gtdt;
>  	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>  	acpi_gtdt_desc.platform_timer = NULL;
> +	acpi_gtdt_desc.v3 = gtdt->header.revision >= 3 && gtdt->header.length >= sizeof(struct gtdt_v3);

Regarding Sashiko’s comment about the missing length validation for GTDT v2, I
realised that the current check could cause a malformed v3 table to be
interpreted as v2 if its length does not match the expected v3 length.

It would be better to fail early and return an error rather than allow
processing to continue with the table incorrectly interpreted as v2.

-- 
Regards,
Sudeep
