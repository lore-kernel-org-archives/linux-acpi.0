Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07736C5BF;
	Tue, 31 Mar 2026 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984214; cv=none; b=OYQDHvVA2e+wt5MsiRsSzz1zlesgtq2YpDqZN6+FLonOTI/ZwIJ+ms96v4A2wpyJinIyOh/fu0ZssU05NthAPyZi0NC9hVq6K9yF/CUbKlY9wj4BOUGthXTMZarzgVeSRPznxn+1sJCf4nuhHl25DKp+HcDvd4WhUn3BS1wpPIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984214; c=relaxed/simple;
	bh=ALCJiRWwAx1GeWPCy6deUJru+dM357tVnhevOKL3rKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYOtlEZROZKZxhtdeE7aItCS3KbRUt2Ur2lITCqTnvAlcn8DGUyEsSFCGBf4GLsKwv13KM4+2pYQbv6QBiUps8M99yTc4X+yH+YbZi17v2lfh1wd0TiAdxXcHRvk0KsWkHBZ48GoopMG8OodY4VqKtfLxRqCphNVuOt6Xkq/R4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MME+mIyP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MME+mIyP"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D7D4540E00DC;
	Tue, 31 Mar 2026 19:10:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NwInlk3m7uiH; Tue, 31 Mar 2026 19:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774984203; bh=9J4oyQdFTw1JEDTJIcVZ0yRoiRCjhJYpSNrXR3GSd6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MME+mIyPJJhkctSyuwWSM0gOGYpppwNxrd7IJMgFpEoYcFX8iZdSsxvGYWecDGsUU
	 bqcsT9CXd9xCDvyrmrfIVNnIo66+ks4s2xT+4AtZcaKMQc53WJK4MoU8QHJth2m7IT
	 k2IFeay5QV/8oQCjfTgTGcLEUYb+Gl/stATH6JytK2pPzjtTUt2uqEJwomUz2DxENf
	 pE+BmgJjh9nWjQ5mHMDBQHXEd0mXKoHzzu2ZbeRGVB57lms3XIFOJygKLH6xxz6ng6
	 btUgPU7KBJEbOQqF4c3uIF3O7bhtUtfS4wILT8lsywQWTxVtz4aayD7y/Y/AhCpFdv
	 BtrHgmjz1WcO+cKouKuOLLydR7F+ysYuKcDWDygKXWodVpYLjBvp1FOk+oLglpRes9
	 yBi5RrZcIoM9UkefH4X8zP2aEsBfaWTD22HxY0kaxE+rbr/aviGqZbrmtHqQvQ34tq
	 ztiuZPw4ELy7bwwYeqYF7BWDRDguq2SBUJ8ZoIj/p0T+1fLTlKAmrxS8PiVK5kwzec
	 NVDiebkHjC0KNKFo3QTnTcyorem2rlqY5dKsohSiukAB/PB4Q4VLI70rr1Vu04ur/E
	 GAxyNTlz8sGu83SH4SASWeTYMFBQasZiRaLoP7aATf/grvwCrGdOpJLcYG0xT4WplL
	 A5sl8rHNc6WmQEC4YTmL1zcM=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 14F1E40E0032;
	Tue, 31 Mar 2026 19:09:27 +0000 (UTC)
Date: Tue, 31 Mar 2026 21:09:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: shiju.jose@huawei.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linuxarm@huawei.com,
	rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
	dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
	james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
	erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
	gthelen@google.com, wschwartz@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com
Subject: Re: [PATCH v18 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20260331190919.GVacwb35SNFnzXUvnE@fat_crate.local>
References: <20260325165714.294-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325165714.294-1-shiju.jose@huawei.com>

On Wed, Mar 25, 2026 at 04:57:10PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add support for ACPI RAS2 feature table (RAS2) defined in the
> ACPI 6.5 specification, section 5.2.21 and RAS2 HW based memory
> scrubbing feature.
> 
> ACPI RAS2 patches were part of the EDAC series [1] and
> this is the 38th version (20 + 18) of RAS2 patches sending
> in last 3 years.
> 
> The code is based on linux.git v7.0-rc3 [2].

The other AI has more review comments:

https://sashiko.dev/#/patchset/20260325165714.294-1-shiju.jose%40huawei.com

Some of them do sound nasty...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
