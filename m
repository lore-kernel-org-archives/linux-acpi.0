Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7CC35AC14;
	Thu,  8 Oct 2026 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481349; cv=none; b=kTTJwN6ZCESjeUVXni9WE0IISdf5kaSreRAXLZNNgNa7HkILj3i/L2KtnP13202ErWsB+qH1h1eQ/QzTEBGqWFbtGAf3nu6diMUc6qumP+wvQSlwJXlD8eFlDhwR2hXl7wBX/MJL6JZT3FGPEhtkwfYbEYag5005os4vq1iBsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481349; c=relaxed/simple;
	bh=Wj95BA6tHW3eFwdf2BjqBoT01JOXddheyPo32tSgJYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdxqgatfnBcTkPuPqDdQp+8d/VbX50fNovUyVA1uwaIcang9BwDcDBpzi5ekxpJhVU/FvRdRWqzqjj9BphCMzDObfbWeAZdyldz69OzajhoapnBjO8KdDmA4KIy2UTJSXjxuDxvfSglaSpSQyL22sdqtZBSxkwE7CUGtdBqb8CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NCznZq0m; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NCznZq0m"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 75B7840E0481;
	Thu,  8 Oct 2026 17:42:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OKouzmO8Va4z; Thu,  8 Oct 2026 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791481323; bh=hdlvJ6GRE4eEi92AN9Q6cxqjIVJ+FUtN2muCFrP3Q1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCznZq0m5VBhiWjABNT9rFCDm2F4DYHj58BkQssq80FfrUR0v23C2czScOQdVuSZp
	 IMcA6OrpfGdplnp6dBR0qeLw/53OCHaVIjzgIjrKM3OK4FXO0Tcf5th1jLKU1vmvrV
	 kimWGi2pDHy4FeRMNbOMVeyBj9Vec3meLIRjeV0yMtLWMTts9praD9ajdOA4DUZUJM
	 X9scQIYHAPk63NubnCEDkaDhFb9p/eYanBZTwcHhaYl4//cCoPmpeOT80COsi+8xNx
	 gLoR5QhFcnYqYbeLMoFzI5C9mgqsrpGrAzBJKpxtYlat76NOEMKBfYNjSmGeq6gjGX
	 4Kd3grbCcOchUGoiflZeJRyu9i2s+8HAJ9a+bR0u7z4eJsOhmsM/qe4de25emwxc1a
	 U078jLI/Z1ums7Yruv+WMkW9Nwb/0lu72Cxhk0cDPJ3pA+y7gIqfdig+gZ6CT3zAvg
	 ZnBhPMqQcJyIfK1WvzihEg5flP8bvZpNTbWueTcX5WTno0ObeXgmTxiVlCM8qql7Kg
	 DL+RB4RimWDgFWpsJHl12FGixkFOmonpgb33duJXTrbQucqrZEnpyQrFXzMyWRR1Te
	 iolENDns/XXemAV6wzM1Huy/CUWUU6Yu9Z5AUlwvHd/8X6lX1+AgIglHE/a4Ws/y1n
	 oCWEvJRitqxcIUvJrfLb2V3k=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5107D40E01B4;
	Thu,  8 Oct 2026 17:41:25 +0000 (UTC)
Date: Thu, 8 Oct 2026 10:41:14 -0700
From: Borislav Petkov <bp@alien8.de>
To: Shiju Jose <shijujose2008@gmail.com>
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>, rafael@kernel.org,
	akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	Yazen.Ghannam@amd.com, mchehab@kernel.org, jic23@kernel.org,
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
	ashoraj@qti.qualcomm.com
Subject: Re: [PATCH v23 1/2] ACPI:RAS2: Add driver for the ACPI RAS2 feature
 table
Message-ID: <20261008174114.GAasfVutvsmAk8JGsD@fat_crate.local>
References: <20260726212812.89266-1-shijujose2008@gmail.com>
 <20260726212812.89266-2-shijujose2008@gmail.com>
 <20261005235021.GBasQ3vXTivT3NLbBq@fat_crate.local>
 <asU7svV8g2Hb5DZl@hu-ashoraj-lv.qualcomm.com>
 <20261008030603.GAascImzt4cv8Gz49p@fat_crate.local>
 <CAG4KcRLhN9=6xeT4qfqKLFdukiZLUc7akGcWwXJUU1-qrfxTUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG4KcRLhN9=6xeT4qfqKLFdukiZLUc7akGcWwXJUU1-qrfxTUQ@mail.gmail.com>

Shiju,

On Thu, Oct 08, 2026 at 08:18:14AM +0100, Shiju Jose wrote:
> Thanks Ashok for reporting this issue.
> 
> I debug this. nows_txdone used to set before requesting the channel
> until v16 and was changed in v17
> following a review comment by claude.
> Found this issue occurs when txdone_poll set and  setting nows_txdone
> before requesting the channel, solved.
> In my test setup,  I missed this issue, because txdone_irq was set in
> pcc_mbox_probe()
> with the acpi pcct flag set to ACPI_PCCT_DOORBELL by the firmware.

What?!? I can barely understand what you're writing here.

And tell me, how many times do I need to remind you not to top-post on public
mailing lists?

Geez.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
