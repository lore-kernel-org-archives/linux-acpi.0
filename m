Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125416;
	b=4mg+z56BLoGqcd5fva6ZdxIkIW7/QW9rn2D5/Nu2+N5ebEF8AyeiVFMaEYckGTm2qbXq
	 J51ewcqkqfSO8JOqquE9fFVFsTDZ8xggCKhrRWKCBNDCecKYvgHo/lFdQq66vP9JDW2zF
	 jAwMKvHOShva72SV9cZExhL4aXadksY2otk/OEKa5G2CRv/m88AMuQKbzQj7xbktvL4qL
	 anR93VG2h7CCOgg/TBsNfpsPKddQtO19DcMdwv2P8UpTicRVd3pYgazqFki+vSBkbK0rN
	 RO+87dOzg6ZnHdATNoHq+4g0zqpvySn8/JFuL5q3+WW7q8cWbLUcKTxIQqWKJ/6NvlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=oiRjZFoXRzRw0gpEvBGfOWMwsbRXgKI6jIlRNPp4PPI=;
	b=QRGDPkmUNIHOrAk20uwg7fq37C+jXEO+4sybsAd0zp4zCyia14vPiUMbCVY9GLcwIY3i
	 wTvR9IxuIsIit/2smZMSimDomh5IhJI693kEg++ptXS3vLI0sDFJBzok2MYmbXa3omteF
	 uDKonfIUDLru1HW4Zwbi++WQvt34/SKGZMVhtJW8PqChPO+q4P0ZX3tlDqypgWWYqtYK7
	 +11OW/PgFjTCZxg4JABEYEi/xiBbMccKXAkT4QTv6B98OxeceqxOVd0m3T+3USRbtg6ch
	 fCzDEnfOKYhcROAeMN3BOYKEPgMpXxpo35jNHhADQNqEdw22hmYFbf6gGmfBdkP0czw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L1R7hwnk;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAD9606A331
	for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 21:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CAD9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=L1R7hwnk
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2af4c8d00so483793c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Nov 2026 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795125414; x=1795730214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oiRjZFoXRzRw0gpEvBGfOWMwsbRXgKI6jIlRNPp4PPI=;
        b=L1R7hwnkf7vfoVXDR74uG48MMHL+ho5RguSCAfgj6A3GXFz1Xby4x7wBR2KYwJL347
         DW6PbEI+fnajayqwuvG/fmvUHgiMasrKsBUe0q3qojACsmEK15lPCV/1SDEcLp+gOboB
         d0aqjmmWhh7XXkhLpw5PWftXOxFS9RpVGhhIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125414; x=1795730214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oiRjZFoXRzRw0gpEvBGfOWMwsbRXgKI6jIlRNPp4PPI=;
        b=wB+Tt1VD1svhM8JcSRH/uRIhTLk8O/InrE3tdbcfTCZYAU6jK/C4npGTi5dn32hfpH
         FhnoLWIXESe6yHQPv5D89HASYBHU4U7BhU0NWkrWHTKbgNlxpSYUEXZPP5/RmrJVhn/c
         G80ZD0wBxGtmrOqK/WMj5USXjb2bkSxacYuhkSgM31CfLRVy3uCWsWVGqXUMmGBJl6QI
         4BOKIxM/YLcc58gZuITe0ujv2BxkockW1P08bvY4+vmWqcHQ387Tkj6eldlqWuvcBUKe
         H1Ry6Cejva1JpCNunlWZQHJWr7FgDYJIVhiJBpRpnpVsqlWxzDf21re00zo8xVmsq5XO
         f3Jg==
X-Gm-Message-State: APuU4Z/3nrGJ581c4tb+P/Nsb49jDpxNl7CaVruRd97m2pxDJJDk2CeM
	h/SpG6LFsjU+6pkyjbbJVkxVNVh/wyDpY5sIyDXgRsQfng5RMcwDC7SizfzMn7qPKw==
X-Gm-Gg: AYBFou0vdsk6zT/bbDAYetuRzjScES8Lw+10jJ07wT/qACfc3JC4qHvjydCQuF8Ldf8
	qQz9q1GEHVNsqvk80vuUo+u0Sd+R06MwW7HBzeRkC76VxTMetqcVi91jpAIhcrxPCeAjnL3d491
	A9a208Yjtu08r173G1RdBAvRmrnpQ+wYMcrDnG08Q3gnO9CN253Dd9KnkEzoe73JUKdnBx2ma3o
	LNaS9hSw7lo9gOjFWF37nRSRio380aPhego8Zl3QEnYOmOqcYNRnkh1e294rpM/WLUUN9of3w6+
	HBXC6ayTgpAxVy+ADYy5EVIghuC1u+J0Ye5I9fMmXQ/1sKmQa8Q+R46X/rV7LYipRJPDygb18pk
	1PmgcU/UF1vKu+gmHHrOcXS4llBAwm5E8qmNXTOp1q3nfpJ8DbUVHdIj4/R3eAkZ71hwzRjLlwD
	ACps6+gnMKDL4aPUPbwTBfaulcANrZm6ZqNpeTwDJ4f2PW1iMqz3Ezm6TMzoEVjiHnxUz0ytR/v
	AKjsJRzkq3Gq4GQQUz2jNSxA0fUpRsPZ0GNocLlmce6a4d2UuIEsky25OA1MKKsgbE5LHoNoux5
	3blj7x2gxxmq5Wueryqzhxw24K8p99mSOf4LV6Yl2QgmUcDaZBf89NSEqTqlT441NGeV
X-Received: by 2002:a05:701b:4555:20b0:1a2:2da2:b278 with SMTP id a92af1059eb24-1b556894b6emr982950c88.14.1795125414255;
        Thu, 19 Nov 2026 13:56:54 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bdc0:a95f:45fc:7172])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b5568592adsm1652441c88.15.2026.11.19.13.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 13:56:53 -0800 (PST)
Date: Thu, 19 Nov 2026 13:56:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: TAD: Improve runtime PM handling during driver
 removal
Message-ID: <av9wpJqw6D1m_izi@google.com>
References: <6052490.DvuYhMxLoT@rafael.j.wysocki>
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
In-Reply-To: <6052490.DvuYhMxLoT@rafael.j.wysocki>

On Thu, Nov 19, 2026 at 08:58:26PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In acpi_tad_remove(), instead of attempting a runtime suspend of the
> device which may be blocked by user space via "power/control", change
> the device's runtime PM status to "suspended" after disabling runtime
> PM for it to potentially unblock the runtime suspend of its parent and
> suppliers (if any).
> 
> Since pm_runtime_suspend() is not called in acpi_tad_remove() any more,
> the latter need not drop the runtime PM reference to the device held by
> it, so make it use guard()() instead of scoped_guard() for acquiring
> that reference and reduce the indentation level.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpi_tad.c |   22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -850,19 +850,21 @@ static void acpi_tad_remove(void *data)
>  
>  	device_init_wakeup(dev, false);
>  
> -	scoped_guard(pm_runtime_noresume, dev) {
> -		if (dd->capabilities & ACPI_TAD_AC_WAKE) {
> -			acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
> -			acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
> -		}
> -		if (dd->capabilities & ACPI_TAD_DC_WAKE) {
> -			acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
> -			acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
> -		}
> +	guard(pm_runtime_noresume)(dev);
> +
> +	if (dd->capabilities & ACPI_TAD_AC_WAKE) {
> +		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
> +		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
> +	}
> +	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
> +		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
> +		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
>  	}
>  
> -	pm_runtime_suspend(dev);
>  	pm_runtime_disable(dev);
> +	/* Allow the parent and suppliers (if any) to suspend. */
> +	pm_runtime_set_suspended(dev);
> +	/* No need to power down, the PM domain detach will take care of it. */

Personally, I think it's a little odd to require coding patterns like
this (and comments, because it's admittedly subtle!) that assume
.runtime_suspend() is a no-op. But it works for simple drivers like
this, where the real work is done by others.

Anyway, that's just a general observation, and more of a framework
thing. This patch looks fine:

Reviewed-by: Brian Norris <briannorris@chromium.org>

BTW, should we drop pm_runtime_suspend() from probe() too? It's
susceptible to the same sort of problem, although it's a benign one
there. It's also a bit redundant, since there will be a post-probe()
idle request anyway.

Brian

>  }
>  
>  static int acpi_tad_probe(struct platform_device *pdev)
> 
> 
> 
