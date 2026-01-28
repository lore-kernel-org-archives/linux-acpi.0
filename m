Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4B34F46B;
	Wed, 28 Jan 2026 12:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603494; cv=none; b=ebbBTu0+Wd6PbJCN0WGU576+IdwhruYraSI8fDVNj4teOJd2O8eI96P7lcFCuN4xbKh7dCN4wI/82LGYd1mkRDFBfmOO5hxx8J72Jewtz3+miT4grFkEmuFGKM9y9RNh4wHP8oBkueu3SRZOa8If561BNyGwUrzTBse7A9ct+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603494; c=relaxed/simple;
	bh=CfPH7pNPdWJ+1P500r0WWIB7f32u9hF9pnZridsPCMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmauxs3S8ioDHD77bJA+zZcfIpuwKqhaSDFMSlDYI3/XwpvvBmQ/6WLsciZ6jbUdljr18rXeri4jQc5DTUtY13s7usgMkjaHwerUJgp2szyMctVIGUnP9CaizQOpn5pWj1zxAtc8hXFxe7EvjH58kxeIGsF7J5whSLEdjNxdqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MqeTAx9Z; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MqeTAx9Z"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2C5FC40E0028;
	Wed, 28 Jan 2026 12:31:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id q2MwsPPTDypR; Wed, 28 Jan 2026 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769603484; bh=Hx96tJLlmTlcmnjd/Xr2BK3NIpLcnKbhX77GfeQv+iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MqeTAx9Zrdsb+CHpOb4sFkJZDeAeBnDLLI6bPWzQQnw4A9BrlBmjqBw/69eE3gdYG
	 2xB+hXzG4YDH/q0jS8yaDFuFLJ9SUuNJP9vzF7gMKnihqSsjEHQ+pjEdlcAZOzHLKR
	 NrunpIcmp7A2e3HY47avaFHUKnJtqofxenCVs3jH9MKW8mkqKzU8Md5xSFfnveeVWz
	 wTdoBRwSbXP2oKargPIs+yiD2ZhpXx2qcfaEROGeRK0vWm8NCvNIa74yqGY8hhbFFF
	 CVGrM4y/0vJn6rKI0gR+PHdiOvezqqJujnZiNPje4nL4rwizVh868PsqEVUB0QeeBP
	 VwWOnBwOGNiQYTsbSD5hCYqPoIc9+ClG3GqL/wBPQYJeCj4mq10AWNaCGbbsSjknL1
	 IGJ3+Bg8f4YO3+mAKXEPbn+RrMd72jMd4GSbOs0n4PZh1V/MXA7Lz5eb7aKxI6RMxk
	 VLnhKrE5vaMoYQXpOQeIlf79sZAeUOaDIo+woTO6qGrxSdipXx1AUG7MwWAJHtiqRR
	 3s6KXi6h7N7KpTogxGsISxUQXOzbBi6PHzDAY/nxkAPYilFnGgqJCxsVVPqZkUsSXL
	 2U156cx6IBg+qp7azOGorADnxukVicFBK1CDm3lgLoktLhqBDOE9Zp84wqE7rjb4hm
	 UlqnneugtZPc7w6eYN00vjqU=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 9283740E02F7;
	Wed, 28 Jan 2026 12:31:06 +0000 (UTC)
Date: Wed, 28 Jan 2026 13:31:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: rafael@kernel.org, tony.luck@intel.com, guohanjun@huawei.com,
	mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org,
	jonathan.cameron@huawei.com, Smita.KoralahalliChannabasappa@amd.com,
	leitao@debian.org, fabio.m.de.francesco@linux.intel.com,
	jason@os.amperecomputing.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, LyleLi@zhaoxin.com
Subject: Re: [PATCH] apei/ghes: Add ghes_edac support for __ZX__ and _BYO_
 systems
Message-ID: <20260128123105.GBaXoBiSoIJnE4RF66@fat_crate.local>
References: <20260128025216.12564-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128025216.12564-1-TonyWWang-oc@zhaoxin.com>

On Wed, Jan 28, 2026 at 10:52:16AM +0800, Tony W Wang-oc wrote:
> Let ghes_edac to be the preferred driver to load on  __ZX__ and _BYO_ 
> systems by extending the platform detection list in ghes.c
> 
> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> Tested-by: Lyle Li <LyleLi@zhaoxin.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index b49a5da46788..f96aede5d9a3 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1897,6 +1897,8 @@ void __init acpi_ghes_init(void)
>   */
>  static struct acpi_platform_list plat_list[] = {
>  	{"HPE   ", "Server  ", 0, ACPI_SIG_FADT, all_versions},
> +	{"__ZX__", "EDK2    ", 3, ACPI_SIG_FADT, greater_than_or_equal},
> +	{"_BYO_ ", "BYOSOFT ", 3, ACPI_SIG_FADT, greater_than_or_equal},
>  	{ } /* End */
>  };
>

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
