Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB8217F33
	for <linux-acpi@vger.kernel.org>; Wed,  1 Apr 2026 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069208; cv=none; b=CH4seZDaYDsKGSNU+3QCN+dsHWUFMiDLfQ3A+p9M8WBtLxLjU+U1P5OTCE8gHybWaxI9gjlCUOwMp9yhhL6ccuxhQZBvMme7Qkhlh0whloNFiG3a/292IE74pjYocU+RQLDdR8ruDS5uoYetzNC/cYF2LkVuoTwAVuD4eo7FRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069208; c=relaxed/simple;
	bh=1F0syb8uvP+tEvnEWomBwv12riDQeF8sL8zgK95GjE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDGkOGLXMQB2Jj45GVuidUhH6yG0E22eegX+YrFfBfXHlBG/LWWS3nVtX/cqbqwfDI5QJbgPRsWKRbCcv2EEjfBKK167AMfmeXTDV9V7ZNhfGqHCrkrsxgEiUKhvL8Mq+gaGP7E81870sGxbblktig+WOmP9213Ud7zQ5Y0U1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=fAUl95O7; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="fAUl95O7"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 234FF240103
	for <linux-acpi@vger.kernel.org>; Wed,  1 Apr 2026 20:46:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775069205; bh=8cK4VvRERApHNEEgCHAK6eTxrBj8bnLg/R7HxGlZuCw=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=fAUl95O7KUu/wQ4gFnRLONeU5Litsml9cpKzzQKv5OIR+Ps4DAyJMDpsa++xEcSsZ
	 vExEbmZ9dSydm4w0N4XG9/EI6Gs0ej/tk5Rq9vyZF2HkX49C9CyhHkyhlmvu7AiHpu
	 7YWUVcvJbIep0SIDaHwYY7J4kTvzKxZp/b+hk2csYbIk4edWS1iZLLJ+1SFbxiDZ2+
	 ONtvD9Fhzya11tRtB01Vo9JTmFX8RUfDIDrrPVgJYewtze50lDaLJXAXRXVtNMpe17
	 p7NLW8VMn5JsPFhyi/joi8xqnMea1IRQgBfXbfpOaWOmnWkQVTTHpnZ1gzjRJUERln
	 WJPhwXsEOffkw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fmDVC1kt2z6tw7;
	Wed,  1 Apr 2026 20:46:43 +0200 (CEST)
Message-ID: <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev
Date: Wed, 01 Apr 2026 18:46:44 +0000
In-Reply-To: <2026040124-unbolted-timing-ce25@gregkh>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
	 <2026040124-unbolted-timing-ce25@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-2sBR2p9RDoqBtMCv2j/f"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-2sBR2p9RDoqBtMCv2j/f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-04-01 at 20:32 +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 01, 2026 at 02:06:25PM +0000, Markus Probst wrote:
> > Export `acpi_of_match_device` function and use it to match the of devic=
e
> > table against ACPI PRP0001 in Rust.
> >=20
> > This fixes id_info being None on ACPI PRP0001 devices.
> >=20
> > Using `device_get_match_data` is not possible, because Rust stores an
> > index in the of device id instead of a data pointer.
>=20
> I'm confused, why are we open-coding this in the rust layer?  What do we
> need to change in the C side to make both layers be able to call the
> same function instead?
No commit message I have seen has explained why it was done this way. I
don't think we would need to change anything on the C side.

Thanks
- Markus Probst

>=20
> thanks,
>=20
> greg k-h

--=-2sBR2p9RDoqBtMCv2j/f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmnNaBIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSumIQAMBSx4JpQWiAAbrCwy/3
KkrcZ9+7xpWSCGv3Yr4TYO7BKJzFMQvzTz/RIFfYHV/RY2jdDZlZ7nAdzbeJiv4h
ZiGNxFKTik3WOF2zR7QtViN6f+qOFdWYZD8Rm6npSq0t6u9JVJDnlm/qe3GRZm2r
VxgQ1gZ1zFwv19aypQrMwCiPabA9I6/EpuMA0sJfOz09UtOTVmfYXK4Fqv/+YsmK
7EmvIPm9OGFTaMkm4g/a8PbvoM7ypgcRXywO/HfcY+Z4IXJRgmS2K3Y5OEbbEpzA
XLdIxuJ4G/GK4pEPr6JVsVI/6O5SjTGRY2+9B1ivm3XcfR4NqCf4Zl57uTSgiGjA
2YR4c3OjzltMzkub8uluTSZ4lziNgOiI+BqglQFDVr7uXURB0otfVGEFGMH/6FZH
tKvE4ujE0kU7jvav2ZLNMaK8mfuE9xYA1Kkh4937+UntcV1u1ptteFZxWlxOwn0m
Zj+tQG/67pKgx0TX1bY+ZQ2rQ33BMVLqXK0clBs5+UQe4T1PVCsxyjvRBGQexWci
DInEN0brZT/YPAfOHCX3avRKy1slhxxDSHFuVd0Onvzbp9+fccGIs3lAbn4k47ls
NCyZElH88pXB6vAciDXoVx2E5tpj188Hs6lX+feFz4RHqiFS2fxGWjP5YYQRiuw+
7SYTsP9NRIkUZvTnD/iEiGB+
=kG0+
-----END PGP SIGNATURE-----

--=-2sBR2p9RDoqBtMCv2j/f--
