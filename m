Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189023242D8
	for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683180; cv=none; b=c2ZNuHRtkMxSFKo7QwpX+P/E2G46Ce+WctDCA226mkPyJXnVmlGuM45n4wWtpUr8zGIeqy9nUCJpg+aSd9guuoz9gbv/vb4AGUczabxNTLFbX+bYJ3xbJJWElxfjzegBSZf2bPNtGZngu2NLbAT/eF1v10R7stTXEbYCOl9NY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683180; c=relaxed/simple;
	bh=Fw1cbySh1egxleCzXRJ6Ic8rJblCTXWdzDTr8/1fiTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIaeT0qAKLOaGS2r36Pn9dKCWYNGQ43+uZSpktGJ7crvZcJcDkvao2us4x2HZElfNmD7YBQi3ieyNQLTvOar35yxtotYA5ULEvaUvbN60XlDfrllZA598YUXGnXrn1+TRbpd8111irTMER/6ik7pc9wcfyGWTEUkTArD/qoOseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gz+19wq6; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gz+19wq6"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c0cf039a45so1186793eec.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Mar 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773683178; x=1774287978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfsMC73FbjdBhiPsgRz6AJiY36W81X7vESrJAOPQgi8=;
        b=Gz+19wq6WXhZfApYXhK8+RuVnGTBrkiJp5ITsXiOwv9ZQdTjdOVnCp/uW48jJpisKS
         EW5xsQIDn+33NGEF5U80Dk8nPo71Xap4ItNsGQBt1/FtsuXhD4jIV+SC9rXWXlXJRbaH
         s09HLpcbQcE2IUC139ohWrU5wCsg6gJLNdvIIOYBG/hR0O5kuaL6+J0KygzdX/H2Nsdw
         nwcjmcZUrZVL68q07ktr874F7bfMzQJi93jjfi1lo8ZGa0JMTlv8KhIO7pVy7CBha2VJ
         jcbo2N28y2L5MjLEZ2SLkCKsoAKuRmsG8YearJlyIl/0fIUptitMDDjvXiQnj/J37O6z
         RA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683178; x=1774287978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfsMC73FbjdBhiPsgRz6AJiY36W81X7vESrJAOPQgi8=;
        b=TaFFexBGP6f6/6BnKYSiTF+95wnTzutsB+AQ5TaUNHUJ4O6/1Qm+4XPFGW2ZPJpcKK
         N98iptIceeScft6RAhCEryrwfES4/X7/oTP8mCtN3S1MQF5dQyuAN45U/7Kqz1UpBjT8
         JEVymest0IsxfSfldbhs1fCpQnuMyqQuClxNa3LxPcZG0kCiqmsPOlF8QRK7LOxslztk
         u/mOiIoWDzjRn08QXr+VWP16ih7O9pVjlQQ+H6ViJ3c3uE9B6kRXXRgSYEXuHL76cuya
         2ibPFV5vb5BM59yA8dzFFUqmDIwOvPlFBPmcOmgAet2ySLrd5xwvn4mxrR+3wB4fbrLP
         7E8A==
X-Gm-Message-State: AOJu0Yw0zE3AnWX2xJcXWLKvZsEVunhkgvNfrsaEDH9Vv20+1JR8bC5x
	X4nn+zE9VkZI17nYGdGn1SkiEMsewy6mQeWCLnQ0M5CJ1R2RDpnds3CAX9E7Tw==
X-Gm-Gg: ATEYQzyh/UTpLbEE0XIXR4stuKCQtrrP46q/N/sMPUefaIsxfjAhHEB6uXRw/BiwTTs
	X4mq+m36pM0X0WKMgv/M2ht+yC0zIxpl3bGRz39W6kXBYEJZGASHkdmiJY3fxHBgfoFFeRWmOiQ
	GaYmlzX+7wkJ07pcEQ178w/4d+ASMAA/FkVHmLasevb+OLm6bt8hSdkBBenBQMlDfuC3NHuFvia
	YlN8RMUAqoJsNAghmHz2M3L1udxzclfuUJ3jbetpIt/e+CIUpsbUodlm49JK3MEIa12PaSh5yFV
	mWLaCXZxPwWlaA8F4SiN9j+XvLTUP/r31igmUbh6M/QdvyoOvlAreeoEqn+mE3WSAtWwZFtBlqT
	K+VqWwIiczunnaNJyBqTO3pW5fkHoqqMWxY9mTRzpu4Hw9g7yvFLid7V8vXHJbguROSwsFIbOf7
	uXNYOeqTRKkrE34k668xvx5KmrXZMnPfVrlsKw
X-Received: by 2002:a05:7301:3d0d:b0:2bd:e153:68bc with SMTP id 5a478bee46e88-2bea5559bc3mr6542555eec.25.1773683177973;
        Mon, 16 Mar 2026 10:46:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a1117sm18567628eec.3.2026.03.16.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:46:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Mar 2026 10:46:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Dumbre, Saket" <saket.dumbre@intel.com>
Subject: Re: [PATCH v1 05/26] ACPICA: Fix NULL pointer dereference in
 acpi_ev_address_space_dispatch()
Message-ID: <a0ef8b7a-ced8-4384-9d88-e98629596a3b@roeck-us.net>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
 <3030574.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3030574.e9J7NaK4W3@rafael.j.wysocki>

Hi,

On Wed, Jan 14, 2026 at 01:20:17PM +0100, Rafael J. Wysocki wrote:
> From: Alexey Simakov <bigalex934@gmail.com>
> 
> Cover a missed execution path with a new check.
> 
> Fixes: 0acf24ad7e10 ("ACPICA: Add support for PCC Opregion special context data")
> Link: https://github.com/acpica/acpica/commit/f421dd9dd897
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/acpica/evregion.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
> index fa3475da7ea9..b6198f73c81d 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -163,7 +163,9 @@ acpi_ev_address_space_dispatch(union acpi_operand_object *region_obj,
>  			return_ACPI_STATUS(AE_NOT_EXIST);
>  		}
>  
> -		if (region_obj->region.space_id == ACPI_ADR_SPACE_PLATFORM_COMM) {
> +		if (field_obj
> +		    && region_obj->region.space_id ==
> +		    ACPI_ADR_SPACE_PLATFORM_COMM) {
>  			struct acpi_pcc_info *ctx =
>  			    handler_desc->address_space.context;
>  
Google's experimental AI review agent provided the following feedback:

 If this setup block is executed with a NULL `field_obj`, it will skip
 initializing `ctx->length` and `ctx->subspace_id` even though they do not
 depend on `field_obj`.

 Additionally, because this initialization is part of the
 `!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE)` block, the setup flag
 will be set shortly after this. Does this mean that if the first call has a
 NULL `field_obj`, the region will be marked as setup complete, and a
 subsequent call with a valid `field_obj` will never initialize
 `ctx->internal_buffer`? Should the `field_obj` check only guard the
 assignment of `ctx->internal_buffer`?

Please let me know if this is a real concern or not to help improve the agent.

Thanks,
Guenter
