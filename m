Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15A0416107
	for <linux-acpi@vger.kernel.org>; Mon,  6 Jul 2026 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342790; cv=none; b=r6oqQl1FBXuJKQPrBV9/YdtDNHIr4uocnNoto/YAPGlfGyQt/GaplHzhuyh1NMG4YS/dtgKBQQwO2fHftLG3QpfRK4eQuwE2LunmBJjIB4NsiXAjl7CnEJv1heHzADvTFX4PA7PFL+DhYO82BJDoIVilWeOClwERA1zgAhM078o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342790; c=relaxed/simple;
	bh=R+VnrUF/2G/LtJFqhdc87B5PmcQ91J+fzxa2A1AIvW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAmZeS1T5N3B0i2cuiaNJ/F+LZzZUNW8P9a2qeSxdMPyfCj6zsh73FR80PbChku94vE3UWnylndpEKH1c6HkkY/AI994ekd5xyghRsUCVhpXhVYJI6AW0J12YKVP1Le0X3OhLRXMUqVwpfkmdM3j6Njd8RwLk81tTDXCrWTGZS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YKQZ29mx; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YKQZ29mx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so5780623a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 06 Jul 2026 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783342787; x=1783947587; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R+VnrUF/2G/LtJFqhdc87B5PmcQ91J+fzxa2A1AIvW4=;
        b=YKQZ29mxfi1Z9d3+XUfE1ShWs0bbfkpmZ7QfM6JGw/v3y+8F4qze1QJoK3tClO+Bow
         8mtyWUiLBtFZiNroyB+uY4vMT3xoatsB504Z4+ScffQDaZZl/3n4pw4s9pT3NoEBdG5S
         636TqPAcOBbWS1VajAd2ruilSS2KfSsLrrWB7emjwBTX/bcXL07fxb7sciXIoIAE0tNd
         9M+uJJJPZOdh576TSart39eJc2wuIzV5nDB4tRpJu23ClMBbNlQ8puX65Xryc/pLnm7/
         B3AIgV6i27f7gpovmNejGHJfmw9TOZT4fIgCizj6qXdGn/2VLtQZaWjrrfDMQomMxB6L
         LwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783342787; x=1783947587;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+VnrUF/2G/LtJFqhdc87B5PmcQ91J+fzxa2A1AIvW4=;
        b=PvA64Nhb9jOEDyI36OH8Qtpbv5ihv7yHBGyHRLn6qxeUyWFvHWRkxaq6rtpw/qCIb4
         6wdJqfRqtPFeTfLI0o41oZp0SVMIO9S2VJSYbGe74xYzQGTcaYrVH3yX28MlrBXDNyvd
         HGn5T6QJDGFb7Zfp1c89ZFMsTtDdiwtOMBOgLkOVZ8Cl58ZOwaFVN6rF6ChHUglgk2Ck
         O0MJBZ2OdCwrD/TLScf8CbZ0WGiQC5qt5f4MC4L1HvbuTyj4RUiv3Rql2GlV8ZNIh0Ym
         GACCGOQOhHgrRq9uRViIJkhjGFFKEkEZTwIu8EMzjgKZ7Uiro2xPnce9k97y/3mnPBcd
         wmKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5SDs4oZD4Oe80cAl7gZKVnVHFprQyc4xaTghdkEqtoJmirVqBGqWIu9Rt4M3+iJM/mhKmb03CED56@vger.kernel.org
X-Gm-Message-State: AOJu0YyvdCMMzz/ygyWE87bS2Ll43XsGpmm5oUZXo+xAanFbtgHRfY3I
	gDqNOvjmvkHdJBYEo2q7zJmdVenrxQKlLAl+AbLXmGHt8EVmahbPBVCGEXXwWyl0ITw=
X-Gm-Gg: AfdE7cmUnIKZPbOsQ7SejfSTrxaaP0ozeW77A/ZSqZ3zw3pRQ9KBQNQcBtThHB48aSe
	mS//o5TxjCx97xQsNp2L699LBVnlNyeDQxZOCxosZffNUJlak8mTiVFlB4SMD++fEbB0HgMgKts
	7r4LG2zVrlbBvj8i+nJGBWwPkBJWdNFiKuG9YJ0+G1OUEJNPSMeTX1OXD64FKYVXNh6/GCOrZ+8
	DXasRy+YxkWxRlUSh90Psr/4k+AgnRQbZyv2X7UgC3V/S59z88/Z4pTbkKLFcm3ngHTSYaSdWIi
	sTbr2WLef2PbgM8zvpFbadtJu0Hn20oCIaORWd63cT/caKp/aH4dAZshN/QzVlhEJjlETtclsKc
	HmcyOGtpgjRnv3z0p4Bwt9KbqIc4BDhx5SMyVnXQb5PKh4vDOqHq2qebLioUEac1RJMof4Sluko
	GAIIQr6siJsBz56GrJBz0IwJt/QuI/brnUM/jenFuza82EShzL26SVLBOgFQDgvp6GXWM4t8A6n
	VxXvBY0GzEyJZj8Me/zpiy6qTHpe8BpnS5BQEPXnw8=
X-Received: by 2002:a17:906:6296:b0:c12:7d53:cc88 with SMTP id a640c23a62f3a-c15a69a0053mr30183266b.58.1783342787130;
        Mon, 06 Jul 2026 05:59:47 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c53c1sm754382966b.45.2026.07.06.05.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 05:59:46 -0700 (PDT)
Message-ID: <00950283-092b-43cb-8f33-3bb5032b1074@suse.com>
Date: Mon, 6 Jul 2026 14:59:46 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PAD: xen: Stop setting acpi_device_name/class()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <2384190.iZASKD2KPV@rafael.j.wysocki>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <2384190.iZASKD2KPV@rafael.j.wysocki>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wSr4p00ExieEUv5Sm0CazCJe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wSr4p00ExieEUv5Sm0CazCJe
Content-Type: multipart/mixed; boundary="------------KnEK0Gs25Phek1BNYJK3vQuJ";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <00950283-092b-43cb-8f33-3bb5032b1074@suse.com>
Subject: Re: [PATCH v1] ACPI: PAD: xen: Stop setting acpi_device_name/class()
References: <2384190.iZASKD2KPV@rafael.j.wysocki>
In-Reply-To: <2384190.iZASKD2KPV@rafael.j.wysocki>

--------------KnEK0Gs25Phek1BNYJK3vQuJ
Content-Type: multipart/mixed; boundary="------------8tGsdDjQMzVFt50wA5bfssHx"

--------------8tGsdDjQMzVFt50wA5bfssHx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDYuMDcuMjYgMTQ6NDIsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBGcm9tOiAi
UmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gDQo+
IFRoZSBkcml2ZXIgc2V0cyBhY3BpX2RldmljZV9uYW1lKCkgYW5kIGFjcGlfZGV2aWNlX2Ns
YXNzKCkgd2hpY2ggYXJlDQo+IG5ldmVyIHJlYWQgYWZ0ZXJ3YXJkLCBzbyBtYWtlIGl0IHN0
b3AgZG9pbmcgdGhhdCBhbmQgZHJvcCB0aGUgc3ltYm9scw0KPiBkZWZpbmVkIHNwZWNpZmlj
YWxseSBmb3IgdGhpcyBwdXJwb3NlLg0KPiANCj4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25h
bCBpbXBhY3QuDQo+IA0KPiBUaGlzIHdpbGwgZmFjaWxpdGF0ZSB0aGUgcmVtb3ZhbCBvZiBk
ZXZpY2VfbmFtZSBhbmQgZGV2aWNlX2NsYXNzIGZyb20NCj4gc3RydWN0IGFjcGlfZGV2aWNl
X3BucCBpbiB0aGUgZnV0dXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5
c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29tPg0KDQpBY2tlZC1ieTogSnVlcmdl
biBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg==
--------------8tGsdDjQMzVFt50wA5bfssHx
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------8tGsdDjQMzVFt50wA5bfssHx--

--------------KnEK0Gs25Phek1BNYJK3vQuJ--

--------------wSr4p00ExieEUv5Sm0CazCJe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpLpsIFAwAAAAAACgkQsN6d1ii/Ey+D
tQf/aCXUsyxYz22Hs6BRSsVA+VOInGaPVyTUb7hwBhiPnte94PmHmgCO3oFSrqcW197fOS3y3/K3
LnU9MfYEcQV0XPas5isWMwOyKMyskX6Aey70a7G8AGALSPd3bHaQbpDYt+xYbmdYFSwPq3FskDM7
m6qeo9TIV75xjWJ4/08d57qUG0a0zs0ovk6ZSadhrjrqMuQKMNAujKRr8g0u2vUOWkaY6xB0kN2s
bzUYo1PN/bm5gcMjtw6yy+QIJEgtjD1h6Z0YdpahlHNZRwrAbE8YGGGLk60KzctAM1+X2IyfwwuN
f3bNGnbf/Ql4IXI4DDF5BgOe+eR8h8LJJO/tMuusdQ==
=Dhwg
-----END PGP SIGNATURE-----

--------------wSr4p00ExieEUv5Sm0CazCJe--
