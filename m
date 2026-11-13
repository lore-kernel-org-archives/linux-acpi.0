Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579454;
	b=CIQIOAR1qpE7LXZocrhJ8htkELk9o4IF6pFTtQo6YtMhToH5+M5PVCZ+TGPloTv1Ynkc
	 BEx5gRxxO4NYGdan/aafi7LVsAaoF0AGGJR5ilCJXY8wsrbQ4jth+eyKSt19dma5yBMMn
	 bfpJ1Ygah5GCDE9jz4c72PIAAj0e4MD1dnNraGK/gvx94C4IokWMkXX4bpf7l9RLzU3ML
	 V0eLB901QWPASfA7ggsECL0fT1ddUihxuEBc6wZNQbsS0ChhJyOp/H5yjfWA1aJFQLjIX
	 +h2mvG1HJDjlz0ZsmWBdEIpbtDOCWtUzJOTHKRC4T6PB1NRBEaLQeM7ygkBo7MKN9PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579454;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=wAr4d2rWXv5qNiuwhdGDlq/wH2H3/NP+kcpEdNzRW2Q=;
	b=R6wAYy03l77jyRA5ZKg8zyQalqv4csoNQlL0bWzrDu/FXm/2PhLHb4GlmmB2XjsIWEni
	 mGGAoUDWppH8IPBmyhsLh5DK/WcAhmEJ5uQeldrVy45Cj0jGmEdpqhen+0sbrEq2sxbIV
	 MFiUha9vnBSrUacq0Plrs+ypDdkI+7fl9fOf76eT1PJn+JNFhlRURvEMl/fV3mdk/yJBy
	 Vhb5qO5vlEjUCR1YgkiD1DYy53fYVx1oxJuz3vyQ/sOFH63x404s3kIRwLNHbqwuuz5ZO
	 XhSgeFyrukR/IyeNX1E8/IOLuBUMZQhMbWOS9Ln9qXFGlsycFgUlyuc6wli7Jl6yJcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Sduqpwo5;
	arc=none smtp.remote-ip=79.135.106.30
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BB1606A323
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 14:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64BB1606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=Sduqpwo5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794579451; x=1794838651;
	bh=wAr4d2rWXv5qNiuwhdGDlq/wH2H3/NP+kcpEdNzRW2Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Sduqpwo5gM13haVrOaExaW74MisPHwgpLn6xDUMja1Qjd8FfFi+dmGqsvktsvw7C3
	 ZgwpPX4v0abqwomqS2eeDd42D0nQc8QVrzvhjDrItl0ZojJuyFHPCvOMFdU7nRj9+l
	 Qtyp73J+dyT2NEi9Mh2JN9JoqDEyLGqt7RtfCDzMfa4Ex8bWyOdlntPnQUE4uCBE4R
	 kiI1bWnva1sgVUodior1OcDiPsDC/1nw3zywrNHMOv4d55RcJLDOAkRU/gJru6lSwc
	 XUErUboiIYmsAFPhxUuuYCSYk5NQRcwXquscN+YJVkLnMRXSl+cPk5zyqNOM91qe+4
	 gHTN/EQiiMNJA==
Date: Fri, 13 Nov 2026 14:17:23 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: penhouse24@proton.me
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andi Shyti <andi.shyti@kernel.org>, Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] i2c: acpi: Force Dell XPS 17 9720 touchpad to 100 kHz
Message-ID: <oyP4Jwe9KmZeViSughKaFgfxdsCa4bOmWguiI5_JlkvEHQ3lSwRAgU48s260tgGXfueLHta38-Zlhq9LQ-oB4aEObhQdAH7mujrH4BFSQ90=@proton.me>
In-Reply-To: <avcBBe428-3Fdonb@ashevche-desk.local>
References: <20261113083940.2583439-1-mika.westerberg@linux.intel.com> <avcBBe428-3Fdonb@ashevche-desk.local>
Feedback-ID: 217801480:user:proton
X-Pm-Message-ID: 5c39618a9f5f3ef6b348c5ec7ac3be6b7c061576
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andy,=20

Yes this post explains this exact problem (I even posted on it).=20

Since applying the 100khz patch I have had 0 issue with the touchpad. Not s=
ure why the Dell XPS 17 9720 is so unique in this issue, but amongst all th=
e firmware updates I have received since purchasing this computer, there ha=
s been 0 improvement to this.=20

I appreciate you all working to resolve this issue. Is there any further in=
formation I can provide you all to get a fix pushed to the main Linux kerne=
l?






On Friday, November 13th, 2026 at 7:22 AM, Andy Shevchenko <andriy.shevchen=
ko@linux.intel.com> wrote:

> On Fri, Nov 13, 2026 at 09:39:40AM +0100, Mika Westerberg wrote:
> > The Dell XPS 17 9720 touchpad has the same lagging issue as with others
> > when run at 400 kHz as the ACPI tables describe. This particular system
> > does not use standard ACPI ID but it seems to use "Windows Device ID"
> > VEN_04F3 for whatever reason. Add this one to the 100 kHz quirk list as
> > well but since this is not a standard ACPI ID match it also via DMI
> > strings just to be on the safe side.
>=20
> ...
>=20
> > Reported-by: penhouse24@proton.me
> > Link: https://lore.kernel.org/linux-i2c/20261109104542.GL176724@black.i=
gk.intel.com/
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Isn't this https://bugzilla.kernel.org/show_bug.cgi?id=3D214597 as well?
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
>=20
> 
