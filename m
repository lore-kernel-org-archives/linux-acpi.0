Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A25309DB5
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778603580; cv=none; b=nVhm4R3476SJgQ8Du4nEb0wS55RN1xGKWAyURBQEw/4C90bsuhUsGT4Guak2Vx9rpV9fUp/KTS0voGw/K8f2OqF51EpDXt2ZXgYTeVEm1Jv1S/b1a9G59B4eSbkLJx41yOgRqfxCSH3h/xOdH/rwA0EKou/tEZnGbw9db89X49I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778603580; c=relaxed/simple;
	bh=f1UxCDNIPzvi1HQrh3EONSucSbLfA/tkOXJSvOoEVfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uxXAFZlZ0Z60o6XzuwWiEdjiQ2NgFMbRO5TxkwLA/nA1ejmm3sxdV7le/GF+m8wXDHVt0CNdfYL0RfNmPPnjhZGJD9L8dui8LFxL25CmBiEyNcCyphag0l0A6cJ4BOnLoJAHyo40lIfcjarVLMfJ2um34bn4zX3YTyFDngBIWbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V60YwzAs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V60YwzAs"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67f7caa33easo5071266a12.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778603578; x=1779208378; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f1UxCDNIPzvi1HQrh3EONSucSbLfA/tkOXJSvOoEVfg=;
        b=V60YwzAsOI1uZIE0ozIPeoR3Q6VwB+d/2uF+OyFNu0eu81Wkq4fFu0WMa9wQSupFKA
         HJdheAkOoQ6B7EVBtWWJHo8nvP1fZANiNDEblg1UhXYib6csc5CctD0YneqdkGWtcWX4
         5/szQQWqQM4OhUp1RX18cXKNUOJ4LYHQfd4vZuqCRUah3Jk2uAvXdQlOALcejQVpA7gg
         mNGXJVkW1JDRkawLQ54gJ9Kx6yBAV8smxESDujnbqpUVDJ+pwpwrw4DZOARUbjv3fQ0/
         u//pU9po7gfRqOSLTUVLDVWuA+xvJr1LEyRAE8SKeDxEW9dCZ25lBNsyCchYAh95nIks
         U2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778603578; x=1779208378;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1UxCDNIPzvi1HQrh3EONSucSbLfA/tkOXJSvOoEVfg=;
        b=GNoNQJ+4hB9uapDMQnZIIYl0bQYd1l+baXMMk8cBSOht3o7Tq2+73K0C+81FFIvu33
         ogLgWF4BzqtYKikNSN+5KM8qnAG0eYAnUubkB6WCpmDalQTD5yMVkFmFyKnmzmIKNzws
         DovI8ZuAqYw72CG0MGylZhxsxXZzx5oq98vFZN/9Lqj+4PBVYrEZDSdDtby+2U6O8ocu
         DFgybdZmvnPiTHLX12dSMnWh0dhck5AcvKduJRBjFuPC8Da8g/Lfz2DAxYl9ETxm7LWb
         8viOfEG/ICoL7I/J65TAumeFWj3lgo/ks+1VzP6bNkqZuqshTdsWq8BCDE0H7y7gbyNh
         PfuA==
X-Forwarded-Encrypted: i=1; AFNElJ/C4loatoXOqupHldsYIezqnCoYRxKv9ZFLBDZmkxGTu2hgIiMVI0irfvUsPrgCb6f21/B5v5YWE8ft@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CjLJgasAJAnupaQBkAwECj9iJy5hZ9orvxxsOKgowcpOjU4E
	l6CpdHhfBIWP7emgt/IFwv1K3NAYg9bL/LGnE8DWWwU66Z+5PWk/co/pooltO3q1mY0=
X-Gm-Gg: Acq92OHav27QeVvH9Wz4Zdrn75VF+i37QEeFZMF6mTPUPCtIfZHSbFoR2zmNZsIrKcj
	0BFXB5Nj7cSlf7HCsnUb7NZ/5vWascubmUcPkw8AYUifhIf59qDyWhQDi5pzNb5k7WzU/CkKlKx
	wI0l5eN6O8lYtz+ijojplQgMGIMPpPbsM/5mU/noxalq5UKN87iDwDVseBUUKg1QRG1l1IyN/h1
	LhKxf9UZpLMOELwQhpUlPPbmBZIa9CUesl7mWRHXgUPK8UcN4J6p38pf/ccjbMeKAkZpBqnnQ5f
	aN6JN02J235TJ+KTQsoWftk0bwGOkrm5VdgfJGewjt3Hmri/D8SVSQn6uiBVUjmxTCbBQ2r8qeB
	+BqxV8RqxsmzBqj9V4EGKgnPdh8/gYFu97tMGKqmC5ejaP1L3afGWcKB673HURt61Vw5p0ZrIL3
	bEdHbCUVx1Kxypr8aTRTo3hnZhh1OtVcUwEM2y5qEIjKzteVLujMFLHZnBTWwRTEuww2OVIe68l
	JlT5XWN25fE21gVLE/kkeItpsdDu6/JsRCinHHRVtxh3MJaQUlhYg==
X-Received: by 2002:a17:907:806:b0:bab:b930:474d with SMTP id a640c23a62f3a-bc56b941773mr1835499266b.1.1778603577597;
        Tue, 12 May 2026 09:32:57 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1af63sm5198287a12.25.2026.05.12.09.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 09:32:57 -0700 (PDT)
Message-ID: <372de085-13e8-46ec-9c48-e56c2f8d504f@suse.com>
Date: Tue, 12 May 2026 18:32:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PAD: xen: Check ACPI_COMPANION() against NULL
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <3427762.aeNJFYEL58@rafael.j.wysocki>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
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
In-Reply-To: <3427762.aeNJFYEL58@rafael.j.wysocki>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------E0jYA8rpgn4HxG7qp6eL7pN4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------E0jYA8rpgn4HxG7qp6eL7pN4
Content-Type: multipart/mixed; boundary="------------nzBUPgL7bjCUzLGQA3i0ToSd";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Message-ID: <372de085-13e8-46ec-9c48-e56c2f8d504f@suse.com>
Subject: Re: [PATCH v1] ACPI: PAD: xen: Check ACPI_COMPANION() against NULL
References: <3427762.aeNJFYEL58@rafael.j.wysocki>
In-Reply-To: <3427762.aeNJFYEL58@rafael.j.wysocki>

--------------nzBUPgL7bjCUzLGQA3i0ToSd
Content-Type: multipart/mixed; boundary="------------aAF37on1kAmghWIZm5ihcCgc"

--------------aAF37on1kAmghWIZm5ihcCgc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTIuMDUuMjYgMTg6MjUsIFJhZmFlbCBKLiBXeXNvY2tpIHdyb3RlOg0KPiBGcm9tOiAi
UmFmYWVsIEouIFd5c29ja2kiIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNvbT4NCj4gDQo+
IEV2ZXJ5IHBsYXRmb3JtIGRyaXZlciBjYW4gYmUgZm9yY2VkIHRvIG1hdGNoIGEgZGV2aWNl
IHRoYXQgZG9lc24ndCBtYXRjaA0KPiBpdHMgbGlzdCBvZiBkZXZpY2UgSURzIGJlY2F1c2Ug
b2YgZGV2aWNlX21hdGNoX2RyaXZlcl9vdmVycmlkZSgpLCBzbw0KPiBwbGF0Zm9ybSBkcml2
ZXJzIHRoYXQgcmVseSBvbiB0aGUgZXhpc3RlbmNlIG9mIGEgZGV2aWNlJ3MgQUNQSSBjb21w
YW5pb24NCj4gb2JqZWN0IG5lZWQgdG8gdmVyaWZ5IGl0cyBwcmVzZW5jZS4NCj4gDQo+IEFj
Y29yZGluZ2x5LCBhZGQgYSByZXF1aXNpdGUgQUNQSV9DT01QQU5JT04oKSBjaGVjayBhZ2Fp
bnN0IE5VTEwgdG8gdGhlDQo+IFhlbiB2YXJpYW50IG9mIHRoZSBBQ1BJIHByb2Nlc3NvciBh
Z2dyZWdhdG9yIGRldmljZSAoUEFEKSBkcml2ZXIuDQo+IA0KPiBGaXhlczogMTEyYjJmOTc4
YWZlICgiQUNQSTogUEFEOiB4ZW46IENvbnZlcnQgdG8gYSBwbGF0Zm9ybSBkcml2ZXIiKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBp
bnRlbC5jb20+DQoNCkFja2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
DQoNCg0KSnVlcmdlbg0K
--------------aAF37on1kAmghWIZm5ihcCgc
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------aAF37on1kAmghWIZm5ihcCgc--

--------------nzBUPgL7bjCUzLGQA3i0ToSd--

--------------E0jYA8rpgn4HxG7qp6eL7pN4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoDVjgFAwAAAAAACgkQsN6d1ii/Ey9G
2wgAlcuqCz5dUNnYXLwNyilZTRlDbAe6f9Y18YoSAHR6cXDMx52653m8MsAtx5CEVcGYpyoMCeh/
7aZmlAfnPlDhRhZUKoql+cmN0/HgBH3N1MH+Wfc+vFUrehwoCqBVfoKSW7Us/s9OT59NeSiVQPEp
ROgX4DN9dagTJEdZYFanFJY+TCs3K+uWXRPEEMmsG/uu2ikCngBMEGIF10mhPMB6mHVisbsif1GK
oI93ohaoZ4b6NF7PLzrp4bze6h0MRsUu7BIXTeZ5wdy1SGlLGdZ6dCofqEG/Pg8Py/KORaXO6u3k
pcUeP6VIsNS/u5k8Xe6mtWCq/KRgcY+X2NPxK50J7Q==
=am8M
-----END PGP SIGNATURE-----

--------------E0jYA8rpgn4HxG7qp6eL7pN4--
