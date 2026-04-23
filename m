Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFAA37649D
	for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776984202; cv=none; b=uUjs4Q6A8TxPeebiIEVZt31xl2uRrqFrC/5Xvd0wE7vBsH1MiiKpaU+Ybn/M88veQnFhSj6FFJGNJDR/7YYgio/fq63pTyjqfkVNT9TNZGP3LEa+vbjZ+KpuJAW4ze8Wplk6xytFD/6f7Ettart+RiAoMB68Sm7PIfEs1o8yYjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776984202; c=relaxed/simple;
	bh=CBu0C4Gbw+eSGJTiQmDn0Va7Mzdh0sn3nL6uhqMgdYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVO4IzeigUaul/t9+qV5lo+E5IAYCraQccgN5sYPDh7QbHwvaHZlsnv5TOObpc3dOYIZO0kkgEX+wzBD0x8NOiNcQuyVI8MeJeU3vf9x+sOb7JaZrJVY4J9rF7hv59bdvJi1IgELQSQ7d1V8u9UgeG8gTVwoCKPzj0iWpBOxH7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=D4byo1ec; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D4byo1ec"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8eea23d01f7so192856185a.0
        for <linux-acpi@vger.kernel.org>; Thu, 23 Apr 2026 15:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776984200; x=1777589000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/T0GTDRuU/Ml1Jl3QzhDeR+2ndhb6qBdCM6HZ+ROdk0=;
        b=D4byo1ecu182ZU65NYkcLK45iIq24mCIKDJQpNLU0ZeV+bCkJHlGiJyPcDX9CdkGp6
         qrZAWy1Ds8n6lTl2ThtzakQ3rl4gGSmUeTKgUnBgNEik38F377NrL6JFh3qLcclyTz7u
         9MF8O9cjEHLcqPRh1Ut8ng+YSmRO+Cam8MYEF20HJKFvLu/S0npvRrY7YpW1UJ6YEgOj
         HqLLgs2EB6dEyIB192AOFRBSR16R1uU9fgMb6oxvn4K6Q+gwR3aZHDbQXbA47FE/Zmj9
         zd0VSjoM/RKeVzQIDmw7hIjzTafTI5O90HbieMEBIWDtH2iJ+wxZREXguFJz6nnUAXHx
         5TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776984200; x=1777589000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T0GTDRuU/Ml1Jl3QzhDeR+2ndhb6qBdCM6HZ+ROdk0=;
        b=jGKoNtNChDqXziBvI6QHfy9oTagab2JfNBq7uosfFqPpvJfFGFOQGHvoheMFOsn++v
         Vy3ClNLWXLr5IKr8/xUAfo6znPzUXV6BpxlTtw/1fSAHN0d7GbR7Lhv7FnC2yXaMGUne
         EuY9RbSBTr/cNOLfY7VtnHLL5uAs8CdMpzJVFks6IDmcbH13wDTqSDPNvWiL9Hws43t0
         EZBr2cIUTi3yx+imWqnPMiGDMsZYvzE8ZUBI5MHFadBbjKUZ5noprw2F+ORE73DzS5qo
         TqB7C9ayZS1wn19ruJzh0j6Z90mJQ/Ea8eIlQ+l2TSmq52fS2fEkdCII31EbwEz4LBvY
         KalA==
X-Forwarded-Encrypted: i=1; AFNElJ8LpRe4FzCifLqNzBqPheirIEmfBTFc8nVoh9UjDmLQlz7FzncrKyiRt3kSpDxtFDUB66xdu50Vmj2m@vger.kernel.org
X-Gm-Message-State: AOJu0YwDA/kPbV09Ln7+9fn6/QU+aVAe9eCJ8Copd8D4lqdYinT/6eqI
	errM/Xdrillkw8ntzf2lDJLw3FvVoZMWVLYm1+frcLUFTlepHaqo7FOmbgmBL2z3EDY=
X-Gm-Gg: AeBDietU3nwM+b8Lgz5dXjz0R07Sv/EMcADFJ5XsvFbMkKkok36X1dJiyX/3rUokq6B
	n/QxJ2BLJPPuwmYxrfSvGHGOJHPDzke3LkK3F92rEeV1vaWHpWp1qXI18deiCWGe4UW0I7u0sQb
	xIg3ci1NTf0BpDaRHKOTOwb6rZClit9EZ2UpHw44+1Vhmw1venEpgQzbjimmcywTYLf+E/5jKuI
	Rsg0MHisSnLIMXHf30ZL9Q3X/7WRZ2qiF7t+OpLOWSG2HeAKRM+qD7OSzOwT7xp81vMXN2q2RBi
	C52fjixLKRVewXvrmExqSygZQ8VTm24eBqqBTJHl8qmieaMGB6ox6i7vPU1eD+AYoTGdBGdnHZN
	dM/kzSohzVcc6QZeIYqxfS3H+Tjxny1/Q7Avr2/oa1dddyrI15wDo5nMP/lbAMbIGc5VrMNfBEV
	He/0LR6YneGv7rZxT2skPFU9gx/vfP7YGFEkxY+41aNzgbeixW7IFfJXA/lpA5X0pRgTfUENdCL
	fc6+p7/fOo9cKw7nqyycjdQDG8=
X-Received: by 2002:a05:620a:3187:b0:8f0:7516:da99 with SMTP id af79cd13be357-8f07516e40bmr1047695085a.60.1776984199901;
        Thu, 23 Apr 2026 15:43:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aec3a3bsm169316686d6.49.2026.04.23.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:43:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wG2lS-0000000GLHD-1ruw;
	Thu, 23 Apr 2026 19:43:18 -0300
Date: Thu, 23 Apr 2026 19:43:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: rafael@kernel.org, lenb@kernel.org, saket.dumbre@intel.com,
	lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@kernel.org, will@kernel.org, catalin.marinas@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	praan@google.com, vsethi@nvidia.com, sdonthineni@nvidia.com,
	kthota@nvidia.com, sagar.tv@gmail.com, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, acpica-devel@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/3] ACPICA: IORT: Add Root Complex PASID Flags field
Message-ID: <20260423224318.GT3611611@ziepe.ca>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
 <20260423191417.2031652-2-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423191417.2031652-2-vidyas@nvidia.com>

On Fri, Apr 24, 2026 at 12:44:15AM +0530, Vidya Sagar wrote:
> The IORT spec, Issue E.c (ARM DEN 0049E.c, January 2022), bumps the
> Root Complex Node to revision 4 and adds two PASID descriptors:
> 
>   - PASID Capabilities at byte offset 33 (2 bytes), bits[4:0] of which
>     report the Max PASID Width supported by the Root Complex.
>   - Flags at byte offset 36 (4 bytes), bit 0 of which reports whether
>     the Root Complex itself supports PASID. This is distinct from the
>     existing ATS Attribute bit 2 (at offset 24) that only reports
>     whether the RC forwards PASID information on translated
>     transactions.
> 
> The ACPICA struct in include/acpi/actbl2.h was updated for the E.c
> PASID Capabilities descriptor (offset 33) but stops short with a
> trailing 'u8 reserved[]' flexible array, so the new Flags field at
> offset 36 is unreachable and the existing ACPI_IORT_PASID_*
> definitions have no consumer.
> 
> Replace the trailing flexible array with a fixed 'u8 reserved[1]'
> followed by 'u32 flags' so the struct fully covers RC node revision 4,
> and add the ACPI_IORT_RC_PASID_SUPPORTED mask for bit 0 of the new
> field. With #pragma pack(1) in effect for actbl2.h, this lands the new
> field at the spec-mandated absolute offset 36.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  include/acpi/actbl2.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

There is a whole process to change this file, I went through it once
for canwbs..

https://lore.kernel.org/acpica-devel/2-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com/

You have to make a pull request here:

https://github.com/acpica/acpica/pulls

And then use the 

generate/linux/make-patches.sh -u <commit-id>

Script to make this patch for linux in the perscribed format.

I think, something like that

Jason
