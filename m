Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67A2D47F4;
	Wed, 22 Jul 2026 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697620; cv=none; b=T4TLAtGIRaJjYv8YsUnNOKXMN5vtLc4ciBp5cxS1ZAHPihpkWOs/bvp/8YeImnCDKr9W5R85ST4ZVonHKZ44SWnNirkLD/07VhKa+1aQ9eshDYG5RM70K8Gg6Nq4YzoNbDn+l90QgrYlSUzcVmvNeKb5M/B9jKmVqslDu+5zP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697620; c=relaxed/simple;
	bh=QKSdvxCXY4MCKGsRHEJB/WzaqnMN6w5dZ8jpJTinIPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2uNzXBnKzxvoZVAfImEZ3LbdfJYu6kaf0EeNhLxvALBlLbPatZEhBSxJzCNrJoFf1MZ0+OPTzvyycruGhbrRDa/GcWel0xaBpf0TbAZpUTyxLNq2vfZEFbIB/2VmvsKYpJRM/FhILWWOifl39Oy6ttsjwm5eGdsqB9NJNltIvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eJ74/J1/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eJ74/J1/"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4451740E00DC;
	Wed, 22 Jul 2026 05:20:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id r3gHIk3Z3MOa; Wed, 22 Jul 2026 05:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784697604; bh=Cww537ASv8kzxMe1FGmK/V4GT98IxA5VfJnEBpkxoko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJ74/J1/mMRLlE9IAuONfD56lNUVXzhb901qTTGENZwHDUVcGgizSAaYO8wZHAExL
	 uVsJwZzSfKuJVlU/vEeiX1faUMYGtjP80CDZCEkdW0VHP9sgbFZ8/9r1/7tVg+2F6l
	 a1xEzieGWlQp/toLSUHJ5fZaTujsj8rtcfw5cm2Jpzq98Y5xMf/Zz+7kaVZg+uKJin
	 xRvfHcAnwTKFVlefasJd6TIa4frpo7LleJuPwugGmzgzYS5kSEzCM49oggSQLM9UmI
	 a+XwuGSPT+saT5toOfAhBpmeuDZb9W65QB+biIvujG9fzKzp6M2yaZ33Uw52jdIyir
	 8oSxzWtd6xfM0kVPr8c3ZNqwcw+i/Nmvs/IrfZb1KvAZ3QU8RYHLheIdibCSqasNNf
	 rM42chfSS0cdoDEwkQPxocMOY7m6G2jFLflfMxos13KnszcoK/3Ol0CJJq/xRgPF3+
	 nkzD4uYQW6VHYcQwoKCxGoJq+a6LWScYeLVcHWS+Xzq/bycwqwUj453r/7PW3qVZ5L
	 o25TaVAd7fSwvTPLLNMPh9V9TMsO6cCbD8jv9f3tjQl1J1DcDJO/O1X2F1+gefUvb7
	 sehjqYsRj4bC44uTZH4DOfADniqpy3TzT4dRs1PR3/3umimP4pzL6TGrYBSaZ9moQq
	 8NVt+GVAlinVBUQ4zPTqVEh8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B81DD40E014C;
	Wed, 22 Jul 2026 05:19:27 +0000 (UTC)
Date: Tue, 21 Jul 2026 22:19:24 -0700
From: Borislav Petkov <bp@alien8.de>
To: shijujose2008@gmail.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org,
	ashok.raj@oss.qualcomm.com, jic23@kernel.org, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v22 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20260722051924.GAamBS3KN1wWTbiMwt@fat_crate.local>
References: <20260709210750.424659-1-shijujose2008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709210750.424659-1-shijujose2008@gmail.com>

On Thu, Jul 09, 2026 at 10:07:48PM +0100, shijujose2008@gmail.com wrote:
> From: Shiju Jose <shijujose2008@gmail.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> scrubbing feature.

https://sashiko.dev/#/patchset/20260709210750.424659-1-shijujose2008%40gmail.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
