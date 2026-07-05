Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6873389E05;
	Sun,  5 Jul 2026 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264491; cv=none; b=nfarOrEvfgu52/5l8iOJyB/Ep5znzmvakEhC3usHv7iiobR6wuthggRQ3ef7a79815yg1U9pzGxey0q6rqsoyfLMQgFIevtB/oPfEIzNW6GeJ9cSnSPcXXutLyj6sODEKQrVxaKABIkgUDuEBnapllbNxmQFMtxoyTh2ifncwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264491; c=relaxed/simple;
	bh=s7FkI8LtHp0KwrigyUGJBUd79XwwhFlyQLWDASJ85Z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODQyB4XKLkBjkA1/Fcyq0a8kRTB5UQqMeFUMbHBaaTEtKSFhPTuXdut4GYE6Eur37Lvbn4vKwdWpCzRVVc5Gdl2VSad02s7LwBAXi65nQ+tFM1BOA+dnJ1hKQWuN3PJmSNUcgxtv8hLzoKaCKxCaEr0D22HekOS0kZmO6Fw9dPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aELJ83Jd; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aELJ83Jd"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 787C540E0163;
	Sun,  5 Jul 2026 15:14:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GHw9jlYOBmpj; Sun,  5 Jul 2026 15:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783264474; bh=xVGyenC0SFTxaahRR3YV9EMNLnHoYhbouZ6rWoZdi/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aELJ83Jd115SE497B2UiygLqfAClT8mpMnMFlXSttmta3//gs95Un85B/NXASrDIP
	 1NycsdFSD8Bg8OBK+vwykWBIHSrYXEqhvAr4hdfURYPjz4+r+agfJ6i8f4PmylnCUA
	 leCpEVGpt5iIBOzJK/+EgmboDVAWFbqewwRnCnnpIAhNekKUxcw6k6OUa5HHKHRN/M
	 79m0LJERxxC8kgIpMLvBnFhoWKZ/JUPDkefJonwAbSFL2j9qU9Nrb2M2mDmnLPED18
	 QQYNE9MO5GWWo11WjEyPKqLi7yisWKc0F9CAw5dATLv7CjGRy/JrSGmXk3TYwZaUms
	 geB1dZpKhBTV8n9bXktERsXdjcORAWtb6GtRSrlEAplfL5tnTe91dfe5Plpnjt4eHZ
	 s/2RCoS89ztFRULElvHotLsEp+61PwxdPEWg4MOGm4MiFEG6bu6KlFgjxCwaNcgeLl
	 PieynOZqAki8db3hMnGeJzWM94Ec4r7QIlK8r5bvoNBjKG0/O79NYisy5Y+Z+Yhual
	 iElPuVi5v9oJb/EsryKZkNisIYZw6Zl4OqdpeUpqoZNblwgHdd8HnD99kFZM8YWB4v
	 JPZKv5nbOn4PNewgAGhuv1PI5ukG+RFDuXQ5TChtPdNtPx0j7GLTrkKWQZRX6hWAEg
	 KPVD0NQmI3fZAur7nKfmpqy4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8382540E014C;
	Sun,  5 Jul 2026 15:13:57 +0000 (UTC)
Date: Sun, 5 Jul 2026 08:13:54 -0700
From: Borislav Petkov <bp@alien8.de>
To: shijujose2008@gmail.com
Cc: rafael@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	dferguson@amperecomputing.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jic23@kernel.org, linuxarm@huawei.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, wbs@os.amperecomputing.com,
	nifan.cxl@gmail.com, tanxiaofei@huawei.com,
	prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
	kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
Subject: Re: [PATCH v20 0/2] ACPI: Add support for ACPI RAS2 feature table
Message-ID: <20260705151354.GBakp0snJ4OKmlUFiI@fat_crate.local>
References: <20260704220745.110773-1-shijujose2008@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260704220745.110773-1-shijujose2008@gmail.com>

On Sat, Jul 04, 2026 at 11:07:43PM +0100, shijujose2008@gmail.com wrote:
> Changes
> =======
> v19 -> v20:
> 1. Added possible fixes for gemini AI reported issues shared by Borislav. Thanks.
>    https://sashiko.dev/#/patchset/20260408172850.183-1-shiju.jose%40huawei.com
>    Unfortunately could not get a local sashiko review setup to verify the fixes
>    before posting patches.

Yeah, there are new issues now against this set:

https://sashiko.dev/#/patchset/20260704220745.110773-1-shijujose2008%40gmail.com

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
