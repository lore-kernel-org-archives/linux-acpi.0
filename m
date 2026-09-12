Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B95343899;
	Sat, 12 Sep 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789232380; cv=none; b=IQFqiAP2a14U/ZoOs/s5E9kxdt08Wpyd+jcVmEJAu13p8KbyvojCpjXRTfq7lLpXWZNBHd0pH0GQs/EaKZ5Zb0HGJJi39tbeIl04LijDOLB6wnmpsfmEQqiwpo7Gm6rG7CdbptgSTpmC4Zg25aePTOLI2RucAvxeYSM3QzJFTu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789232380; c=relaxed/simple;
	bh=AJHG3esMZwH0RWtfkWBAiWnT1QRFt4zqcoKdiO4EQiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4Tp8LLi+ExbavPwrHTgYua+sCjMWE46bf0rmGqEgNtyeFhyaYTWME93aRjQVaEeWM1k2Dr/ZX5ikZGS1nQoWvc02CopT/aalPFSWJYD1GmlThXQbPTFk+QIIOeH3JHGzImTv/+lYOt/9RFUCL8Zz2DWEuANn/zs7wsxbdQg/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=N2ASiww4; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="N2ASiww4"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hhy936L5yz4B8Q;
	Sat, 12 Sep 2026 18:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789231863;
	bh=AJHG3esMZwH0RWtfkWBAiWnT1QRFt4zqcoKdiO4EQiY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N2ASiww4t0k71Hz0kAf6pPdrj2LIC/71Ij/IUvqztJFVBHPgqgccamY2sO+2SVfr4
	 9rdmI2kohnNmsUq6tSCtel4bzireoSUQIajd12vkWfxTovLSy/oz6+sGppP2/kQFkt
	 9sjALgS0hb9KssGF7dVXMVk/uvrc+DAWSvtvX8xYDdhkyhTFKlrOO58uUAzE/cC6XY
	 PcoHTtiZxLyvr3hG2x4BqQzlMESppcY+P4N5BS7p13AKyXhykUegAB/zeJJXDb5UOk
	 5+l2LiPpQJf/kwiKcOVzmY2qAhz7Qdp33SyJyibK7jYZRmfwsbAcfxcyqDCVbhmHb5
	 R7OQladY9viDw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4hhy8L459qz4GGw;
	Sat, 12 Sep 2026 18:50:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hhy8K1psLz8sbW;
	Sat, 12 Sep 2026 18:50:24 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 1990B5F995;
	Sat, 12 Sep 2026 18:50:24 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6e450fa2-8b40-48b6-b0b0-a1c4b72a383d@leemhuis.info>
Date: Sat, 12 Sep 2026 18:50:23 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: scan: Honor _DEP for Intel CVS devices
To: Miguel Vadillo <miguel.vadillo@intel.com>, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, sakari.ailus@linux.intel.com,
 mehdi.djait@linux.intel.com, wei.a.xu@intel.com, atul.raut@intel.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260601194040.18223-1-miguel.vadillo@intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
X-Enigmail-Draft-Status: N11222
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260601194040.18223-1-miguel.vadillo@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178923182456.3752792.13793600117481511174@mxe9fb.netcup.net>
X-NC-CID: eUDhzI0c5q2/AO8HjvMbjiiF2l6J7hgVrw4CQClAx3XQVxIiRas=

On 6/1/26 21:40, Miguel Vadillo wrote:
> CVS (Computer Vision Sensing) is an ACPI-enumerated device that sits
> inline in the CSI-2 path between the camera sensor and Intel IPU.
> On platforms where CVS is present, the camera sensor's ACPI node
> declares a _DEP dependency on the CVS device.
> 
> The CVS driver must be fully initialized before camera sensor drivers
> probe, because CVS controls the CSI-2 link ownership handshake (via
> GPIO REQ/RESP), the MIPI/CSI-2 lane configuration, and the camera
> power domain. Without CVS ready, the sensor driver can bind but the
> CSI-2 stream will not function correctly.
> 
> The CVS driver calls acpi_dev_clear_dependencies() at the end of its
> probe() to unblock waiting consumers once it is ready.
> 
> Move the CVS HIDs from acpi_ignore_dep_ids[] to acpi_honor_dep_ids[]
> so that camera sensor enumeration is deferred until the CVS driver has
> finished probing, matching the behavior already in place for IVSC.

TWIMC, there is a bug report where one or two people claim that this
change caused a regression; the report is quite verbose (guess LLM
assisted) and hard to grasp for me as outsider; requests for
clarifications from my side were not really fruitful. Not sure what to
make of this, but I thought I'd let you know; for details see:

https://bugzilla.kernel.org/show_bug.cgi?id=221988

Ciao, Thorsten
> Signed-off-by: Miguel Vadillo <miguel.vadillo@intel.com>
> ---
> Note: this patch has a functional dependency on the CVS driver and its
> IPU bridge support, which are queued in media-next for v7.2. Without
> those drivers, no code will call acpi_dev_clear_dependencies() for the
> CVS HIDs and camera sensors will remain deferred indefinitely.
> 
> The CVS driver series (v5) can be found at:
>   https://lore.kernel.org/linux-media/20260527170531.383871-1-miguel.vadillo@intel.com/
> 
>  drivers/acpi/scan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 530547cda8b2..1463eb3a4f6e 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -848,8 +848,6 @@ static bool acpi_info_matches_ids(struct acpi_device_info *info,
>  static const char * const acpi_ignore_dep_ids[] = {
>  	"PNP0D80", /* Windows-compatible System Power Management Controller */
>  	"INT33BD", /* Intel Baytrail Mailbox Device */
> -	"INTC10DE", /* Intel CVS LNL */
> -	"INTC10E0", /* Intel CVS ARL */
>  	"LATT2021", /* Lattice FW Update Client Driver */
>  	NULL
>  };
> @@ -861,6 +859,9 @@ static const char * const acpi_honor_dep_ids[] = {
>  	"INTC1095", /* IVSC (ADL) driver must be loaded to allow i2c access to camera sensors */
>  	"INTC100A", /* IVSC (RPL) driver must be loaded to allow i2c access to camera sensors */
>  	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
> +	"INTC10DE", /* CVS (LNL) driver must be loaded to allow camera streaming */
> +	"INTC10E0", /* CVS (ARL) driver must be loaded to allow camera streaming */
> +	"INTC10E1", /* CVS (PTL) driver must be loaded to allow camera streaming */
>  	"RSCV0001", /* RISC-V PLIC */
>  	"RSCV0002", /* RISC-V APLIC */
>  	"RSCV0005", /* RISC-V SBI MPXY MBOX */

