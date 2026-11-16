Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849404;
	b=UOwMT61l6iefxlAkAX3I5WW0BmlkH1JsBPpbEoZQfcSba2Fj29k5NhCkGfELOq9Y1tcU
	 MLiJB9JGCeuqb/wbXLaE6PGykNrMdD+praEDiJ3Q8wuo0G5l/khQg5/2vIBNiLOFH3TIo
	 Z1bgg9KGub5390yPhAnENZ1jtFPVLxMjCfGIaY1zkHjvJ+QUqEvIeAmBJ/hCMAh9sXVG7
	 DHtRHf8nowz8XI4bE8JwVGWD83Zqs+VqwOZVzH3mhdkcM40tP9ehkxh/vT+Pey8l8t/FT
	 Tsu0MWWxTArftPSiRAuNEpwD91OvJKE9Gi0ecaGnaR5TOxekf+n/DpIYEhPNIp+q8Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mSvoaqmjg32ifr2UgUXPIKGNa+qRJ8bbbR9fyHQLo9g=;
	b=rhrMcFph+ZeMCL3OORO8x5mD7gjNXB3gnahVYviJPHPVmEPFIxrV4f7f34RnmOaZ9Eal
	 KSipQX163Xd4ilRd/8cIDiuif+jhzh2AEUObn7tjN/q8voOER6GswbFWmCDZDLDlzCMZb
	 Lxaj1gYtUL8QhGeRjxl7sAY1TxMuiJGbLZzGsrboYloaS9DX8STWvC5Ct6Kye3UTv8syT
	 +GQSpY/I9wFneJ0BAcsW72JwPGic57fXUM1IUJTiITLfIIlrD/hKI2Pb3yBKTARMgRZ4c
	 ssJINkVm8J38h21WxrSH9MxzZqT1tOrhcyUxsb1gXt/Mvn1hGD9DH99++v1dLT1PPSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CxK9VZSf;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6FA606A33B
	for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 17:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B6FA606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=CxK9VZSf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so39431395e9.2
        for <linux-acpi@vger.kernel.org>; Mon, 16 Nov 2026 09:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794849401; x=1795454201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mSvoaqmjg32ifr2UgUXPIKGNa+qRJ8bbbR9fyHQLo9g=;
        b=CxK9VZSfh79fNWhCp1NFP++dVlw2bcsnTNu1h5/kBzXtJKoJOtUg6+ISzBVyn9hDKL
         SUzXpSz652HmDYMenkzBqfGos4Bs9Egx3VVCquC0y3AF+QAIocBkxYjcVHcJb6MYKJHk
         xaqv962wIhXwvWlz0NyvYRpBpjny36vezEPmv5M8XpOfiWZeEWVmPH97qqZVVZ/C3x3z
         HNXVak8pSZjAVNIlduUeK1xaZ97f5RfnT3ZVoH3Hs3jt1V0k3ox+0V7yo1o7QKhYMb5Y
         Vo1NUvrTXlZyxWX0Wj1d7XzYTsrqtEeIXJXoHNnr+ITFHHXVyWLvy8xvEXhGTUBgNLIX
         V4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794849401; x=1795454201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mSvoaqmjg32ifr2UgUXPIKGNa+qRJ8bbbR9fyHQLo9g=;
        b=LXkze0BlS1t+S3BUevv4eLVv9oFrEWw2C7PMg7Tc974aNeaIf/5XM8g9m0yS7Kxrgr
         SRiaMbvOReP3sAbtTXVWo/ERaMc3+h8R7xf9ZgR4nfETnc6wIIN14jUbqsk8mgFsnuQs
         aJDfnUJJrHkZ1UvT0oeo1f7ysIA+2yeKNNIERKQcqaW+BRo/wx2N6FUEk/N6CI9t9lCd
         rR+7MGpar1p5xhUUkNBhQt7zvo1MF8LRKByduHumIAr8psK+6m14/as72K84sjgow+fq
         VbxI0Of73RmXkxvRFmasqgZitU8dlGgzK1w5EFrAbUs3/s9SJscm2uuT7ov+zRI7rOCL
         zxXg==
X-Forwarded-Encrypted: i=1; AL+hErF0vpa+h8j2GMbHxErZ0pTmfIiv6WDvcr4Yek24aqwGYhumtiYw4OuIAhAZwWh0I29MaX4D4vwJXeVq@vger.kernel.org
X-Gm-Message-State: APuU4Z8r4jM1UXNnbg+nbXS7ozqpKaYwcbwvlSWgOJIzusZP61Buf444
	JlJNVh1oYN5xL75rTyc7GkiFlVaZld2O+wQeKjZmqSwQV2D+e48QNRqXL+SoMYj2XHM=
X-Gm-Gg: AYBFou39jDTK/Xa6AJiPF1wHSIEENIWpJeXbNyzriDmfRJcV5PcnRcp1kMStkMCuJbJ
	Hdr14yrIvyfoVRiorFx1+76Pa2lnqX8014jGmqoI1RxBf2pRlBv9mZm6/veIHax2Fpjzw1yiCNi
	wdblZxcXwbnM2+hHxMLggdR4cHckHqZXddcwrTTEy1jNdmGcOYEHpJBVlp8nLoYbzWeFQoepBJ6
	LSCsCUfdBbKZC8mZoFib/ifQyS0l4BTmXhgmjvw03BzUEFcmVSprV1jecLSC1qtjEaNxFMFb2IV
	lK3hm+9atfpivl3Q9v+BY7K8wlZSSr7vfstDMSAgZ6txhWUNVps36YKirsJcuhQiYXOgxeIPneb
	2F0chiK9TpWQxskxwAekeZ47csCOrsN8a290bjIunLZEb2jvc/QnIh3XpZ+NOIZLHxGi4wAdc2Q
	VBg33XtZOrPLddwbA2DHBlNxGKql4t7orbSF+Xk1DEYfMQvAZo0sMVD9vtNSmR8Y9fz/zybhowN
	R90ldXWDp/athhOb5v0NKSOXIR4YkAg2gSvJ3stYOgfJB/OmADo5uubj9MTJnZ1oWaA4QJrKAZI
	Xkv69HaYJPZKmkRmWrrvL7mak56LRJ3DdygqlFDR08QoDz9+g04aCfEYLqd3+qGeZWn+E1kKVVw
	PwNbPuUfmUd2KOuvU3FJTYyEqpOpjYMlVhgEI450=
X-Received: by 2002:a05:600c:3ba5:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb741d1238mr63980765e9.13.1794849401463;
        Mon, 16 Nov 2026 09:16:41 -0800 (PST)
Received: from localhost (p200300f65f19a90439293c698a65b414.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3929:3c69:8a65:b414])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49c5fb58fefsm25945708f8f.26.2026.11.16.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:16:40 -0800 (PST)
Date: Mon, 16 Nov 2026 18:16:38 +0100
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
Message-ID: <avs5thXfoZA4TBnE@monoceros>
References: <cover.1794567577.git.ukleinek@kernel.org>
 <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="xs75une3ctdjt36i"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jC5YXsLgB6Qd55KNCU0oCsN86X5WpRfL+Ycz0MJ8vGqA@mail.gmail.com>


--xs75une3ctdjt36i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 0/4] ACPI: Use named initializers for acpi_device_id
 arrays
MIME-Version: 1.0

Hey Rafael,

On Fri, Nov 13, 2026 at 05:17:30PM +0100, Rafael J. Wysocki (Intel) wrote:
> > Uwe Kleine-K=F6nig (The Capable Hub) (4):
> >   ACPI: Unify acpi_device_id list terminators
> >   ACPI: Drop unused .driver_data initializers in acpi_device_id arrays
> >   ACPI: Use named initializers for acpi_device_id arrays
> >   ACPI: Unify *_device_id list terminators
>=20
> All patches applied as 7.5 material, thanks!

While rebasing these patches (as part of my wip tree that contains a lot
more similar patches) to next-20261113 I hit some merge conflicts. If
you tell me where you applied it, I can take a look and provide my merge
conflict resolution to allow double checking.

Best regards
Uwe

--xs75une3ctdjt36i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmr7OnMACgkQj4D7WH0S
/k5UDgf/Zh/cCBQS3AfcJY+xVzINeExpvzUmIZMMajOqIRB1Ogb1iu0eC9qNdona
axu6POUJXrXH/4pRKQXevRF3+h/9JnryHBdTIe266MjPuRwUmMbGA8WFTkyAB4B1
QWyO8s+I+vnTdOB8Epy5gtqS4T4GHHGkl77vuo+C1qWDCVa9rLVrAvtFGSJ8ULGz
w1dFA50z67Fbkzs1CIqH/smn3i2pPtGjZvfJ3APm3MUbEXCY3U5vKugaE9w7fFF/
RnDbWck5jZ7cSr2Z4gmAk05o1kwfeDTGzRJ6/1zxIdAlPzXZFzMQWhDcgVE+3pQm
cX2okMKS7qwTP1K50XaZeXSwd0t3mA==
=+qin
-----END PGP SIGNATURE-----

--xs75une3ctdjt36i--
