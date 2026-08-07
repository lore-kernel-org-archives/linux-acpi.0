Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655EA44683A;
	Fri,  7 Aug 2026 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082449; cv=none; b=P7w+bWY/21yH1XNHyC64EkXwGjiOdzGJdWu9ecDbQJtEkE7xtgSM7o3zYgcmnM/eFvsMxZtI4luTqvwdSttKdBVOZoIYlFg6WU3mDADfO2neBnkiccOYZYs183Z+NlRK8+JwXvA5qYOosl5vkTtAOotSi62jKaORHF1ykzscr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082449; c=relaxed/simple;
	bh=5iCUd0HV92C1OK5Pl+OH0sfT0wUckvSw0Bi3kxDA2X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRjLRZDEZZC9V78nAE+00BM4GTa9L3S0CoT73jMWxFY1ihmbqqntQT4SLF0siSS5RbURDEfCoWNMSB+v3w+acZlbUUPc7FlMI7Bx2sRfdwq/OxH5d2+VbDRtSgvI8AyhyKrkXINd3m+fYfovQv7EtU1hRUpWZCJS0jufaZDuffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dx1PqtKq; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dx1PqtKq"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4FB2F40E00B8;
	Fri,  7 Aug 2026 06:00:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pPJzRbAhWiuE; Fri,  7 Aug 2026 06:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786082432; bh=qYhI0fwC8PZZssZoGwGoCXzMpJcSZ4YzBIlml3eONO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dx1PqtKqAVe76ho+lYRP90RfoiVidM4o5srU//3AoWiYRtlQ2bacoCRB3ybVKgKd3
	 ZObnyWdGjhbOfZxFSa77uP31O5aLgYnGUrh3dkyJytSMm7kCIcgXTTFKCdIwvQAyGF
	 GnBV9MtMKV1Re9YKUin/9FuAZZNhUyaWlH7hCYtMKAS/d+3ymoxOi5F/J8e0ykWU87
	 NVkBv6z5BJK2A7Q/Ct0AUFco/DzYjs//z+iD3mqlTF3i3I0H4XgHwtrPQbjtnyCFFu
	 VX1SCJyvTufXUFtZNV9ssNxnYQAsrJvF9iUW8xche/+onBIV/wo0FcmjIZET8E4JEr
	 8M2cNaHwisw8EuHOzD9PCCuzJSGT35cCn9BYtkVxJKbjwyt19wyWMn9YTitHcSx541
	 /iJzG/CMeZB2zhqCsqziiBtdzH9LeD3dzaPq1LN/jAR2ifsM/HCFy7Spf3YNPWlVLn
	 M5lvWzqfz5+EOzr8gveQL944/fVM7KpUwPZxS5j+rOWnR9cq4e1U5SUKP9uktsFHrc
	 6Guq4+5VVwbLXMKalbQPpZCUMBsshIWsrfiqwuzMdG4PrDceLo0YzXrdNCCNO5MGEF
	 4YB9BoIxJJTSXi7HdKhl63M2dpCALaswTSOLcEMOB5jr54GJ4qZ/L97o3STjTgM3s3
	 NhJKL4bQJi3gIA9AMWx6gUeg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3F8140E0140;
	Fri,  7 Aug 2026 05:59:55 +0000 (UTC)
Date: Thu, 6 Aug 2026 22:59:52 -0700
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
Subject: Re: [PATCH v23 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20260807055952.GIanV0WDlB9-eP9VdV@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260726212812.89266-1-shijujose2008@gmail.com>

On Sun, Jul 26, 2026 at 10:28:10PM +0100, shijujose2008@gmail.com wrote:
> From: Shiju Jose <shijujose2008@gmail.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> scrubbing feature.
> 
> ACPI RAS2 patches were part of the EDAC series [1].
> 
> The code is based on linux.git v7.2-rc2 [2].

You're probably going to hate Sashiko by now but there's more issues against
patch 2:

https://sashiko.dev/#/patchset/20260726212812.89266-1-shijujose2008%40gmail.com

Please sanity-check them if they even make sense. If they don't, you can say
why and we can ignore.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
