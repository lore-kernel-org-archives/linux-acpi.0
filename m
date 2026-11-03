Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709821;
	b=LuD0Rgn2Bl19q01A7fyVwT0giQ/gkEmJokPU8mP8IC+mJg5fxUl5vw2jhjW2YkBvpn9u
	 28DO3ZJ1mJf8EC8RxugVcJKTsF7ymwpKSVAvHun0+FQLk/SizdyJ2/vhtovCGynYK79oU
	 usxe6yCsoUKdRhzyuqL9q5YP9miyZBW6pjlH4jBGvxXZhkMxwza4C7f6tNOyfdXXJ9mzS
	 BkXNY4MIyS5HcjWyjzZ9Xj6jOf7OMGTpjLwRBAscbRCFy4JmykfeT9dW2tJJjgK37Fe/2
	 kJRE76g1R76Fq/SZvoVY87TVE0Jjh0ysBKyyEjeTUHMK0R/Lk4IX/8gWDpqAkvaDrWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709821;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=pO/obBZJ4f2OForg6iRYSXhGn5yjHSurUDcBoBBJqVM=;
	b=glUCd/KV1m6b9Bkh5K+4KnMldwHi15U5W9tUo5EsgoPs0xcNblUXSIS0YIwaH4HEFlvm
	 5lgnxMVjKDTF09H220RK1DqVMMcbcj9aoZXIutmJr+2CqQIKCDeccwg7OjBvC4iSqRpyE
	 vjFwqfiS0Z711u7V0//R49/iEurAnZeM5F/tvNFyttyKg84YGehNyCzPCgAwn9+iDUC0c
	 2Kf1G0IHcgb/OBBJjOIVehEm+etr5yOpHEYkUAVtb0FbcEeuc9UgoEGlTokGEM4LL51dY
	 RuMFcQ+jz4zp4jCT6gq5QBjik5cg+hvUzL11Q7TZTv0suOrqF3r8i+AIutIhWBREBpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b="gwN0H+D/";
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C48606A329;
	Tue,  3 Nov 2026 12:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C48606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=gwN0H+D/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pO/obBZJ4f2OForg6iRYSXhGn5yjHSurUDcBoBBJqVM=; b=gwN0H+D/59hRi1GMGSu2SDIpe/
	IX9tP/uFLlN/sLTbIWiWKVv8YaHAV8YFU/LJuiLI2oxuqy0B+HigWBbPXkDu5MOBquV+art+Rss8i
	mDqArn1RpbD242BafzUmSDixjindazKjQ0ak+ZxHnCOaNPosXz8MaidvpKs2lQZvPSWlrqfEfDNKv
	Ill2neAFvWyNdnv5kaAS29Ve5PwXxt+bg7xfZo0uzomMVJsfLrcFhLYstPt3Tde3QrUXGTZlWyfO8
	j1r3raXjkMcNUh5CZ2Y9xhVZCMjy5Dnkt8tF9F9EulAXkYIdQ5UIQpVxkBeiKcep+V/T7CjxXU+Dm
	cYG5q4MA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xODrH-006wPN-1y;
	Tue, 03 Nov 2026 12:43:24 +0000
Date: Tue, 3 Nov 2026 04:43:17 -0800
From: Breno Leitao <leitao@debian.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Pawel Chmielewski <pawel.chmielewski@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	Terry Bowman <terry.bowman@amd.com>, Dan Williams <djbw@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Morduan Zang <zhangdandan@uniontech.com>, linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 5/6] ACPI: APEI: add separate Memory Error Section 2
 handlers
Message-ID: <aunWnZ0IYz2DF1JX@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-6-pierre.gondois@arm.com>
 <20261020101720.00002545@oss.qualcomm.com>
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
In-Reply-To: <20261020101720.00002545@oss.qualcomm.com>
X-Debian-User: leitao

On Tue, Oct 20, 2026 at 10:17:20AM -0700, Jonathan Cameron wrote:
> > @@ -915,7 +939,8 @@ static void ghes_log_hwerr(int sev, guid_t *sec_type)
> >  		return;
> >  	}
> >  
> > -	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> > +	if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM) ||
> > +	    guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM2)) {
> >  		hwerr_log_error_type(HWERR_RECOV_MEMORY);
> >  		return;
> >  	}

Keep in mind that this fuction has an issue, that I am proposing a fix
in here:

https://lore.kernel.org/all/20261030-ghes-hwerr-sev-v1-1-145ceb996c77@debian.org/

This is no action for you, just a heads up in case you hit this issue.

--breno
