Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F3748CFC;
	Tue, 26 May 2026 02:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760994; cv=none; b=mbmR9abINXpZ3652sEuyzJla4iM6Dggka27KTqhbne3aoNthPuPSvp2SomMeU8cb71aOE2ji6rLHgltZWI5pViOyxKXGMinIUTzWrx6CKcmJL71Huqmp+R9SF7zHPz3I9YN/J9/7ARiINRQvCzBDl45j9zdVPt26HOLzWh7j5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760994; c=relaxed/simple;
	bh=WIDQlFsfAYntqIYwpQpJQuPrepFqZL6mcZYDQG4qvV4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=orGLj1o7fR3NckIhn0OO3JqBQVyqW16TNNFkj4JL7EpEzHwvCDz5N4Btwk0rPeGF54JuM5xl/n9AE0cdeKf6CtSZc9iANoyBcNwC6bBlYsCJn0NDpPFnLuaOh9jGTOIy3WYDWqE8renee+rte4AoFfZzsuejUnLT3z9m1BHYdjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vnQ8zd26; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vnQ8zd26; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vnQ8zd26";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vnQ8zd26"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MKNaIvCnm8qUnyfYhGibyJaJtEQHAb1VhcqtfRguFO4=;
	b=vnQ8zd26ObL6sz8BBQYf50Rk1KQLIazS4QZSDd4yDPU6l90+E+HaAIdGb5Q0I45iYYIMToehV
	ENPARSZ4+iuNRTJzjJYVycsMhn/yY4VXCOlaeOWbFUe8MGPg2vWLHngy8ZCDG3pORrmQUxsWXQm
	WMjSlPKyK4XdFv+cSAxX+nY=
Received: from canpmsgout10.his.huawei.com (unknown [172.19.92.130])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4gPbbl10bmz1BGqR;
	Tue, 26 May 2026 10:02:11 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MKNaIvCnm8qUnyfYhGibyJaJtEQHAb1VhcqtfRguFO4=;
	b=vnQ8zd26ObL6sz8BBQYf50Rk1KQLIazS4QZSDd4yDPU6l90+E+HaAIdGb5Q0I45iYYIMToehV
	ENPARSZ4+iuNRTJzjJYVycsMhn/yY4VXCOlaeOWbFUe8MGPg2vWLHngy8ZCDG3pORrmQUxsWXQm
	WMjSlPKyK4XdFv+cSAxX+nY=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gPbRd2grYz1K9ZR;
	Tue, 26 May 2026 09:55:09 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DD2EA40539;
	Tue, 26 May 2026 10:02:52 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 May 2026 10:02:50 +0800
Subject: Re: [PATCH v3 01/17] ACPI: GTDT: Account for GTDTv3 size when walking
 the platform timer descriptors
To: Marc Zyngier <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>, Sudeep Holla
	<sudeep.holla@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ge Gordon
	<gordon.ge@bst.ai>, BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	Jesper Nilsson <jesper.nilsson@axis.com>, Lars Persson
	<lars.persson@axis.com>, Alim Akhtar <alim.akhtar@samsung.com>, Ivaylo Ivanov
	<ivo.ivanov.ivanov1@gmail.com>, Frank Li <Frank.Li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Thierry Reding
	<thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
	=?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
	=?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>, Heiko
 Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>, Orson Zhai
	<orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Michal
 Simek <michal.simek@amd.com>
References: <20260523140242.586031-1-maz@kernel.org>
 <20260523140242.586031-2-maz@kernel.org>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <4d583ddf-13c0-104b-78c4-3f8d89307e72@huawei.com>
Date: Tue, 26 May 2026 10:02:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260523140242.586031-2-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/5/23 22:02, Marc Zyngier wrote:
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
> the base table. This also comes with some extra sanitisation of
> the table, in the unlikely case someone got it wrong...
> 
> Suggested-by: Sudeep Holla <sudeep.holla@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   drivers/acpi/arm64/gtdt.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
> index ffc867bac2d60..950d5efdf85ea 100644
> --- a/drivers/acpi/arm64/gtdt.c
> +++ b/drivers/acpi/arm64/gtdt.c
> @@ -34,14 +34,25 @@ struct acpi_gtdt_descriptor {
>   	void *platform_timer;
>   };
>   
> +struct gtdt_v3 {
> +	struct acpi_table_gtdt	gtdt_v2;
> +	struct acpi_gtdt_el2	el2_vtimer;
> +};
> +
>   static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
>   
>   static __init bool platform_timer_valid(void *platform_timer)
>   {
>   	struct acpi_gtdt_header *gh = platform_timer;
> +	void *platform_timer_begin;
>   
> -	return (platform_timer >= (void *)(acpi_gtdt_desc.gtdt + 1) &&
> -		platform_timer < acpi_gtdt_desc.gtdt_end &&
> +	if (acpi_gtdt_desc.gtdt->header.revision >= 3)
> +		platform_timer_begin = container_of(acpi_gtdt_desc.gtdt, struct gtdt_v3, gtdt_v2) + 1;
> +	else
> +		platform_timer_begin = acpi_gtdt_desc.gtdt + 1;
> +
> +	return (platform_timer >= platform_timer_begin &&
> +		platform_timer + sizeof(*gh) <= acpi_gtdt_desc.gtdt_end &&
>   		gh->length != 0 &&
>   		platform_timer + gh->length <= acpi_gtdt_desc.gtdt_end);
>   }
> @@ -166,6 +177,13 @@ int __init acpi_gtdt_init(struct acpi_table_header *table,
>   	u32 cnt = 0;
>   
>   	gtdt = container_of(table, struct acpi_table_gtdt, header);
> +
> +	if ((gtdt->header.revision >= 3 && gtdt->header.length < sizeof(struct gtdt_v3)) ||
> +	    (gtdt->header.revision == 2 && gtdt->header.length < sizeof(*gtdt))) {
> +		pr_err(FW_BUG "GTDT with invalid size %d\n", gtdt->header.length);
> +		return -EINVAL;
> +	}
> +
>   	acpi_gtdt_desc.gtdt = gtdt;
>   	acpi_gtdt_desc.gtdt_end = (void *)table + table->length;
>   	acpi_gtdt_desc.platform_timer = NULL;

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
