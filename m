Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854140;
	b=U2iTGXlgHsVoIljolHxy6DcVuzVnZXWulsSG7/Qru8PPRFNHY7DRTQ3gHa0O02/Ja2mF
	 pkDNg4wxDfNWMEJ7aSjuwp0HtpKvrFCf3o94wb7KpRcQzPlRFFox0OGS5rIgbX0GPjH8r
	 Mf78OEqLXuBycrYEZyIxPxu9eMeW9+7/8u/D9I0UlJKgaKM0aDas/8WE8OW8B8LYSYdV9
	 UZUWjelp2y70VaTczbs2VSOxw2qESgcRo4NRoYNSK6AgdLiRpQ0L1W2C2ig7Mnt+tt5Eu
	 tKeZJoIzJRqCkohrGKKHGNqPehrd5CQuSMxVWN9UMSP4tpr2kYSIOtKcU+ex8NjTDvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854140;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EPargW/ndTMk8W5T5ryrw8EEtwPYjCnMb9VWPm+Ydmo=;
	b=qnz10BR5dveboriiKf23zXZ2sqyQeCULpU3VxxlUcSypUsigwfsoDrilhTZ1YiXyN/rx
	 n4GbBgf+UqY68cVah4RERlh7VRWkjZlJ8uXePwdFxvmC+CaU0KhCYumaJ4KBIl6awuAae
	 rTcc1nqQn+4uHXrsm7BG4xqLEWTN+jlmo5hZmBx3X+tlluT9ujZL+zlVGE5WzGWCwdTsP
	 YQl2XCh2AZWGCQDGiW/N8sIJIouxPIh9e5/z31dFRSrrvktY04qsHH2QGrzHIS3zy8N/H
	 f58sFGJna13jS6W9eC2Pd5Y8pWtqzENIXTY9RI5rlLrkbbl/ReKfhamARAGjdbgfiJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="E3+6/1hx";
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750C606A329
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 18:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6750C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=E3+6/1hx
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dee593f18so4035796f8f.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 10:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794854138; x=1795458938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EPargW/ndTMk8W5T5ryrw8EEtwPYjCnMb9VWPm+Ydmo=;
        b=E3+6/1hxj2sx16NOC59UDyHnwicYd2BXhyX5J0HFKKh0Bi9Mmrg6Pit7Zxd7QWuruj
         rs7xrXDQra6ZSF/eTfdHvMV9IkMasjFZSUbr+DOllAIselgkMhGyy3TS8Xn9iMxGSDab
         Ge9bwzPp/nwI5nxBrxl2Gzj7UoMBIeuAgiiTPtU8/hu5kZFbIrwF4Wc2/6toi8T8DF70
         BboMkugbvcXP2EdxqjLiNJVqVickrZ9lcmh/10OmSjOKc5Ov/l/iAqgfseMnAMNeQ3kC
         Vz5uf8uPNhqWlDhJaqhfMX7P/0vFbGZWgeEQ7pz/Pi+d6ri3FCsVy2in6j1RH6blXZQF
         1Ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854138; x=1795458938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EPargW/ndTMk8W5T5ryrw8EEtwPYjCnMb9VWPm+Ydmo=;
        b=mw5mlN6FYOg/q+GUN8YHKFgG2kTFX8mg9vT0zpRfnDn3vq5KukcuO9qEodMK7lihCb
         4h2cKWY5HopyAAVUNYLsbJqxX7wkQsVmNzBxg8KTfCsvYzhB35lKd8DglALMUt9vnz/d
         cCfTd4yvJrunelVV4QEESbRrjBQkrAsF0UMNiTDwsCpTAzF+vOsd2Bg/mDOFetAZ90F7
         7ItD+q677Z+Yrh/8wlG0OYOfMI6XdGecywPqJWAqGg8Il7+tKYZQc3SZCb1CM3OH+4B2
         ne2NmKA5Dwcr3LJaZe1j+E7NjsUnvbDCvBEWeN/qaMbWxADBubBWcH/yVy0Qa2DoIq0s
         2fog==
X-Forwarded-Encrypted: i=1; AL+hErFynrnpUSx9ZxN67sV5SuMotaBM6rdN5GJBRD3+FHbYyaaDv2ixQBi9V82umfQIxM/NbO8ImsrP1GI/@vger.kernel.org
X-Gm-Message-State: APuU4Z92YCpjkBpnIMR+2MYcG0/DxC+ozd+Ro4A73M8n1E1jXPSOryN4
	f5eMpuzFfb35WDzjK255LCIJRaui1cO8C0ykBFWifRlpmQMM6f7Nj2+Ip9jaFFfwKiI=
X-Gm-Gg: AZFdTZc7lfcSOKQkJDD8Zs6VRZw+t54keV4rsHeays6i5tzHkbr55wnBiydKnowT/K0
	fuAkFXb+0GJxdvj5JbPXk1qYG+B8MQFNqpyx80DRlv8v6zWZbF8gFa9yJQOmkuZY3Z8Lab5t0rG
	qS0Ldtp14F0zoyON3YeU+RzQUnG6pk61nEIrBnMnfrG9wPvEU0zgP9+eD0ApLQKQAA0HVP5KCiK
	jYVnjCtpq+69W5q49jM4QYMMc5awCmFiO9RV65jSKR31yhDNn7DWFjxbvmIz37Pj5/Kpi1eIeYx
	l6atygecAXkwvKMlxWxo0Y+mJq+WMKCXdGyPWbK3+QnnUnTvdTjdsJ1nYvzxj5I4T4UlOQgF0bF
	r9njT1jcX/qNWA6vmkUdkoXQeisZQwwpQ4lsPjiMP0h3xcOxwH6Q7m85nM/9h8OZeBqoCxFpfEm
	JwNig0TvGPnwbqBrfvg3BSH+QG+L5Rqjyo6HyjO3PkSGHrgUa9hZJAlO06QVCbTf4Jn+WYW0O/I
	hqaVDcC64vGUGUPCP7rTmkoi+o9Z9CL19OVMnAsi8x3amO6bnuKpEpY58xZePwozAL9XNg0fdc1
	APNzawoK+3AMqBKbbBw6QsBmzE2Vmc4j7/4j8c+sP5AbPkPxj13kcvVl6eQ0SZzcMuUOAhUCrPp
	bUupX+zmrsKQ5ipjbXUAdARoWYT3Qwz7ommkmlQ==
X-Received: by 2002:a05:6000:491c:b0:48b:118e:7454 with SMTP id ffacd0b85a97d-49c70a0f0cbmr22973182f8f.31.1794854137742;
        Mon, 16 Nov 2026 10:35:37 -0800 (PST)
Received: from localhost (p200300f65f19a90439293c698a65b414.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3929:3c69:8a65:b414])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c5fe373casm23015553f8f.30.2026.11.16.10.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:35:37 -0800 (PST)
Date: Mon, 16 Nov 2026 19:35:35 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Zhang Rui <rui.zhang@intel.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	Gergo Koteles <soyer@irl.hu>, Jakob Riemenschneider <riemenschneiderjakob@gmail.com>, 
	Yauhen Kharuzhy <jekhor@gmail.com>, Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Chu Guangqing <chuguangqing@inspur.com>, Andy Shevchenko <andy@kernel.org>, 
	Mika Westerberg <westeri@kernel.org>
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id
 arrays
Message-ID: <avtL3i7n9cUARCd1@monoceros>
References: <cover.1794567577.git.ukleinek@kernel.org>
 <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
 <avs5thXfoZA4TBnE@monoceros>
 <CAJZ5v0iSJVszOCLCuK+ifCzTgx1RgDAExaYUbij=jaWmaTsb8Q@mail.gmail.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nqnngouwa55krefe"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iSJVszOCLCuK+ifCzTgx1RgDAExaYUbij=jaWmaTsb8Q@mail.gmail.com>


--nqnngouwa55krefe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id
 arrays
MIME-Version: 1.0

Hello Rafael,

On Mon, Nov 16, 2026 at 07:15:48PM +0100, Rafael J. Wysocki (Intel) wrote:
> On Mon, Nov 16, 2026 at 6:16=E2=80=AFPM Uwe Kleine-K=C3=B6nig (The Capabl=
e Hub)
> <u.kleine-koenig@baylibre.com> wrote:
> >
> > Hey Rafael,
> >
> > On Fri, Nov 13, 2026 at 05:17:30PM +0100, Rafael J. Wysocki (Intel) wro=
te:
> > > > Uwe Kleine-K=C3=B6nig (The Capable Hub) (4):
> > > >   ACPI: Unify acpi_device_id list terminators
> > > >   ACPI: Drop unused .driver_data initializers in acpi_device_id arr=
ays
> > > >   ACPI: Use named initializers for acpi_device_id arrays
> > > >   ACPI: Unify *_device_id list terminators
> > >
> > > All patches applied as 7.5 material, thanks!
> >
> > While rebasing these patches (as part of my wip tree that contains a lot
> > more similar patches) to next-20261113 I hit some merge conflicts. If
> > you tell me where you applied it, I can take a look and provide my merge
> > conflict resolution to allow double checking.
>=20
> I've rebased a couple of patches on some material merged previously.
>=20
> Please see
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commi=
t/?h=3Dlinux-next&id=3D58d4ba8979133c41cd491dff1dab40626daa924a

OK, it seems you already rebased on top of the commits that made my
rebase a bit bumpy and you did the same resolutions as me. :thumbsup:

Best regards
Uwe

--nqnngouwa55krefe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr7TPUACgkQj4D7WH0S
/k6vZQgAjLzcTYkt9CbkThW0RlljMQXJxP5fmZNoFevLodwamfhpt+348ZmhBkWR
pva0yzF64v2uFwtmOgge+e1azRuruDvxfilctoJgbCV+g8N8GlaVkT6OU7mHXpNB
C/esmpj/xKsGPaZnrbRAXqxJ+/KWjGuW2Tc4/CLmjidnaqdHoi6we+/W/YDZe/zD
hK5ahEuQfANr2sXtQMET7/79wAiZ0mquQalFQaDDF2whSgyu7dWdt3+ahdFOS9u3
DTc/gz1Yiu4f/sTzP8Hh7Gr6y/CnHyaILNhtxA3YnnMqLmQnPEONbSnbua34q36a
S4dDn9kuuyzsCa5pFr4vhDplKXzROA==
=5qsj
-----END PGP SIGNATURE-----

--nqnngouwa55krefe--
