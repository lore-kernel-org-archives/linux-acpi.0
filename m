Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787429;
	b=Qqv8S+m5rWsPa3Vmz+iMCOysEIXG7cbevYtjnKCqhU60CeTQegUXf1bPMPwkSHbR8wey
	 Y7GT5wHwrg1QRvF1y9Ayvl3mqTWpNSvnmnqjAeT9vOd6gE50aWwqCdtee2krtfVIW+APW
	 V3pcR+x4+qWGjPwlUaCaAUQIgvsOugyeifYQu/PRH1w20zAMTCpJWvI/G2qXTVykTcQAr
	 mBZubRUGIb94S2zquhHKGwUEt+DKjJfeK55g9xXMPUwU2Liphu3TH3I2BHF1fN2PUrgb0
	 irQL9hhsFQQViL8F8cuZTDS9g7LekcBiF6zNIECgXv1WcSwnU838e+gKIzE54+48tug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787429;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=Al/H5Lk1G7gzp9uPEa2FrG9UA88IUol0MBzQwOwuRLU=;
	b=y16b9NBj4w/g73/h178yxKNkXjDmLvd7mrypoKu5nt1RmPoZifEXOBr+DdKdbRVzt39F
	 PB55a7qauD5I5zjQCGlrF8mkdSjaDp2MnT4GI9heA4hTxsOvpqSMClpcMnX6IjkxUPgPJ
	 Lq5K/y/ffwBDLg8iW76PE+n3XTdxkwJVxXH0ZhtDvInSVJ9OBBk4J5ETg941pZeAs8yf6
	 ajW/ICjE9hHwLpagv/n1WOeV1dTgL0PNIlGWX7UtjWM/df0QQ/LA/REaG35waXEb5wB0+
	 qXkPlwpwzDrrwF0C982paIzN8pUlTPZjreQsX1cefySg0Ix/ScAstLhvGHMkDfinHbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=WGvHrFXE;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90A606A328;
	Wed,  4 Nov 2026 10:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C90A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=WGvHrFXE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Al/H5Lk1G7gzp9uPEa2FrG9UA88IUol0MBzQwOwuRLU=; b=WGvHrFXEwU/Gh9gZh5p+vZjFh6
	o7qoXyG9yVr30Qnm44NsQiMlZJO+uPJGdq7l+uxaE1UfFO8W9HjWoSGqIOsDHCsTC3Z50jnvBtGn4
	AVG2Qec7tT7h/klfGNH/VUMeALufnDXfTkOXgO4YgochsWvn4fBRQx0hHAY73x7s6+q0vm4tl/vG7
	/ClWzznW5tEbH4+wxP869vsD8cgsWqeGd333ORjSYHXTdFCB1wk49f/Ily0tVf+UBiw9Pxa936Fb5
	kkTbA78SjoI0zJQIInJxGYad34XLMJqfEyF75vS67/EyYiDA2AvzTz5SfCDHMSJYFE8jt/zgbmdio
	CJJakX1g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOY32-007diH-1U;
	Wed, 04 Nov 2026 10:16:52 +0000
Date: Wed, 4 Nov 2026 02:16:46 -0800
From: Breno Leitao <leitao@debian.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org, 
	James Morse <james.morse@arm.com>, Mark Brown <broonie@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, Pawel Chmielewski <pawel.chmielewski@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, 
	Dan Williams <djbw@kernel.org>, Terry Bowman <terry.bowman@amd.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Morduan Zang <zhangdandan@uniontech.com>, 
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/6] cper: add Memory Error Section 2 structures
Message-ID: <ausF958TWhACbL9j@gmail.com>
References: <20261019203915.2019037-1-pierre.gondois@arm.com>
 <20261019203915.2019037-3-pierre.gondois@arm.com>
 <aunhE1aeSfk6YDgj@gmail.com>
 <20261103130038.00000f77@oss.qualcomm.com>
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
In-Reply-To: <20261103130038.00000f77@oss.qualcomm.com>
X-Debian-User: leitao

On Tue, Nov 03, 2026 at 01:00:38PM -0800, Jonathan Cameron wrote:
> On Tue, 3 Nov 2026 05:27:02 -0800
> Breno Leitao <leitao@debian.org> wrote:
> 
> > On Mon, Oct 19, 2026 at 10:38:41PM +0200, Pierre Gondois wrote:
> > > Add CPER Memory Error Section 2 definitions to the CPER headers.
> > > 
> > > Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>  
> > 
> > Reviewd-by: Breno Leitao <leitao@debian.org>
> Typo.  Just in case Pierre is using b4 or other automation!

Sorry.

Reviewed-by: Breno Leitao <leitao@debian.org>
