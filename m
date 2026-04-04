Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40B306B0A
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775338444; cv=none; b=X14iXXP+lJuqpuO+K1r8gGOkpXobYCX1rdM+pIx2v+SrU49/O0gidcMIOvgXWje09GmvWGdp9Gu0Bn7t1nRzO2DfuRhALIBVJ6DrQZfdV1UKMndcCEQPBJ1lVcgJlOh9kiLbOkBoGvBqZ8aim64i++MmE1C9j/12pFYXKrNg9FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775338444; c=relaxed/simple;
	bh=/O7aiYcnPdqTH7QOI2VSKAinik7vnIWomIknTYQ6cFo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pRCN6WvtGwQIGJ3SdHm6BXPjl8YIT6h+52U0+D5/mXzmsPsuExKV4NFiuxhSj2uXfAs/AAI3HhlQGu1/b4moTZds2hIdak2dY2YhSPx8I7xn3/FyQXmKzkCD1BlSEusfrcgKrtVuT+QgrfQj/s3c1KrmmeuaYgJ4lS1RvuRgjFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Hg84vPCu; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Hg84vPCu"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0CD70240027
	for <linux-acpi@vger.kernel.org>; Sat,  4 Apr 2026 23:33:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775338435; bh=SSKnPkiaoKU9QHDmxkgvkEUkKVRcYkScJvXMkBCCID0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=Hg84vPCujvhKLCcT52EwaPenvGarN0R0cvVWCFm9ip9yKv0pNhLdlQGCDN8SXehCZ
	 Eqq05U4Qtd2MARTEsNn/FK8mGY/XPZpx6gUkmzySqus9CacAGDgGQmxyPYEHbs43Dv
	 jhEGTBPFP7K/ZZyShjUuK+TsHVdZIYF2cPvc3Knz1891UZk3KI5eVvpRzfaad6mpni
	 qIxn43bRLUWjG+mrMs5B0a0ysvDoqIh3SBHcVxL8jT4CVmMnfLmaFX5n8bFRMFQmOy
	 sfx9k3usPSGCQSFFxRg40HMcN2W9WJaXAm+af+0ace9cT0xRx7vQBoylBmCsEqBiXD
	 bsnwXGfyJZuWA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fp83h28CKz9rxG;
	Sat,  4 Apr 2026 23:33:52 +0200 (CEST)
Message-ID: <398ba2627148b9224ed41d383c906ca23427986f.camel@posteo.de>
Subject: Re: [PATCH] rust: ACPI: fix missing match data for PRP0001
From: Markus Probst <markus.probst@posteo.de>
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev
Date: Sat, 04 Apr 2026 21:33:54 +0000
In-Reply-To: <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
References: <20260401-rust_acpi_prp0001-v1-1-f6a4d2ef9244@posteo.de>
	 <2026040124-unbolted-timing-ce25@gregkh>
	 <565d58a4b766bd4a63a45da81849ea178dce5f63.camel@posteo.de>
	 <DHI5Y6PNVJSJ.SCAJL0A4W2TR@kernel.org>
	 <DHKOQBER5U5N.IHLHH5ORAZCQ@garyguo.net>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=mQINBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93
 qReNLkOWguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVA
 m76Ww+/pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt
 9k5JARhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbm
 fAjaoT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwT
 jRQxBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1
 J+FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN
 6OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
 8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJCX
 CeMe4BO4iaxUQARAQABtCdNYXJrdXMgUHJvYnN0IDxtYXJrdXMucHJvYnN0QHBvc3Rlby5kZT6JAl
 QEEwEIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSCdBjE9KxY53IwxHM0dh/4561
 D0gUCaIZ9HQIZAQAKCRA0dh/4561D0pKmD/92zsCfbD+SrvBpNWtbit7J9wFBNr9qSFFm2n/65qen
 NNWKDrCzDsjRbALMHSO8nigMWzjofbVjj8Nf7SDcdapRjrMCnidS0DuW3pZBo6W0sZqV/fLx+AzgQ
 7PAr6jtBbUoKW/GCGHLLtb6Hv+zjL17KGVO0DdQeoHEXMa48mJh8rS7VlUzVtpbxsWbb1wRZJTD88
 ALDOLTWGqMbCTFDKFfGcqBLdUT13vx706Q29wrDiogmQhLGYKc6fQzpHhCLNhHTl8ZVLuKVY3wTT+
 f9TzW1BDzFTAe3ZXsKhrzF+ud7vr6ff9p1Zl+Nujz94EDYHi/5Yrtp//+N/ZjDGDmqZOEA86/Gybu
 6XE/v4S85ls0cAe37WTqsMCJjVRMP52r7Y1AuOONJDe3sIsDge++XFhwfGPbZwBnwd4gEVcdrKhnO
 ntuP9TvBMFWeTvtLqlWJUt7n8f/ELCcGoO5acai1iZ59GC81GLl2izObOLNjyv3G6hia/w50Mw9MU
 dAdZQ2MxM6k+x4L5XeysdcR/2AydVLtu2LGFOrKyEe0M9XmlE6OvziWXvVVwomvTN3LaNUmaINhr7
 pHTFwDiZCSWKnwnvD2+jA1trKq1xKUQY1uGW9XgSj98pKyixHWoeEpydr+alSTB43c3m0351/9rYT
 TTi4KSk73wtapPKtaoIR3rOFHLQXbWFya3VzLnByb2JzdEBwb3N0ZW8uZGWJAlEEEwEIADsWIQSCd
 BjE9KxY53IwxHM0dh/4561D0gUCaIO9eAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCR
 A0dh/4561D0oHZEACEmk5Ng9+OXoVxJJ+c9slBI2lYxyBO84qkWjoJ/0GpwoHk1IpyL+i+kF1Bb7y
 Hx9Tiz8ENYX7xIPTZzS8hXs1ksuo76FQUyD6onA/69xZIrYZ0NSA5HUo62qzzMSZL7od5e12R6OPR
 lR0PIuc4ecOGCEq3BLRPfZSYrL54tiase8HubXsvb6EBQ8jPI8ZUlr96ZqFEwrQZF/3ihyV6LILLk
 geExgwlTzo5Wv3piOXPTITBuzuFhBJqEnT25q2j8OumGQ+ri8oVeAzx24g1kc11pwpR0sowfa5MvZ
 WrrBcaIL7uJfR/ig7FyGnTQ1nS3btf3p0v8A3fc4eUu/K2No3l2huJp3+LHhCmpmeykOhSB63Mj3s
 3Q87LD0HE0HBkTEMwp+sD97ZRpO67H5shzJRanUaDTb/mREfzpJmRT1uuec0X2zItL7a6itgMJvYI
 KG29aJLX3fTzzVzFGPgzVZYEdhu4y53p0qEGrrC1JtKR6DRPE1hb/OdWOkjmJ75+PPLD9U5IuRd6y
 sHJWsEBR1F0wkMPkEofWsvMYJzWXx/rvTWO8N4D6HigTgBXAXNgbc3IHpHlkvKoBJptv6DRVRtIrz
 0G0cfBY0Sm7he4N2IYDWWdGnPBZ3rlLSdj5EiBU2YWgIgtLrb8ZNJ3ZlhYluGnBJDGRqy2jC9s1jY
 66sLA9rQZMHhJTzMyIDwweGlvMzJAcG9zdGVvLmV1PokCbQQTAQgAVxYhBIJ0GMT0rFjncjDEczR2
 H/jnrUPSBQJpa71VGxSAAAAAAAQADm1hbnUyLDIuNSsxLjExLDIsMgIbAwULCQgHAgIiAgYVCgkIC
 wIEFgIDAQIeBwIXgAAKCRA0dh/4561D0gKJD/9uOQKYlsDoQX65Gd0LiMT0C+5vXgr3VI0PHDOwcv
 51fJ3A1vNyPZRFPGrz8+mDEXUQOF/INfnz5Tu1QHwf+iYcWcTGAN/FHgVR6ET6VBNU2hJaKhu+Ggo
 kjYyJTOvyX+3yNRUfSny0GjTjIPuPTErjqmHF+BtjXslpgwqnNMznf3lRIuUjRORupos6p3k1DndE
 5vzUTmXSvMyXyOD2KhBl/kL76k0bHYyAQytZPag12pltrtFbA/r2phDGN2si8PooDT99bSTJjaM45
 MTAAHbHKJfvgfK41bNFD5mMtpWpL195XRtS0Nrxdg3PaYBxN5gtTG0RyZfpYRlkdEhm+jj/8RxuSG
 i/qdhRdbiI7K2IELWeQVHSNDi9JabR/UzlR4NSnhfAjRIVlRM+eFbUl8XwxwVrAkojF5IraH2qRvg
 VCmuFsHUW07FUlrDrzpjXsD73cKppoFGDCdDR0BHJepXbFLS9+AqkT+guRJlnCTg2p+TQtnbwPgKp
 Vj98JixovCl99zRYTsL2bRNU5+q8iET65VMJ1ydyNanvLd5vI/NqDkXhlXLsGmdaDTtu4R21PkToX
 dQNGrZ91M9nlIBKw8Y7c7xZ4098qX2b8JX/CxD+gC1r4C8vuA3GkhFLx+KlkON7LyiJPkrePp6Qky
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-PPtNJ3QtMKIhOXT+vasR"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-PPtNJ3QtMKIhOXT+vasR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-04-04 at 22:23 +0100, Gary Guo wrote:
> On Wed Apr 1, 2026 at 11:15 PM BST, Danilo Krummrich wrote:
> > On Wed Apr 1, 2026 at 8:46 PM CEST, Markus Probst wrote:
> > > On Wed, 2026-04-01 at 20:32 +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Apr 01, 2026 at 02:06:25PM +0000, Markus Probst wrote:
> > > > > Export `acpi_of_match_device` function and use it to match the of=
 device
> > > > > table against ACPI PRP0001 in Rust.
> > > > >=20
> > > > > This fixes id_info being None on ACPI PRP0001 devices.
> > > > >=20
> > > > > Using `device_get_match_data` is not possible, because Rust store=
s an
> > > > > index in the of device id instead of a data pointer.
> > > >=20
> > > > I'm confused, why are we open-coding this in the rust layer?  What =
do we
> > > > need to change in the C side to make both layers be able to call th=
e
> > > > same function instead?
> > > No commit message I have seen has explained why it was done this way.=
 I
> > > don't think we would need to change anything on the C side.
> >=20
> > The Rust code stores an index into the array the contains the actual de=
vice ID
> > info in the driver_data field of a device ID instead of a raw pointer t=
o the
> > device ID info.
> >=20
> > The reason for this is that it was the only way to build this in a way =
that
> > results in an API that is convinient and obvious to use for drivers whe=
n
> > declaring the device ID table, can be evaluated in const context (i.e. =
at
> > compile time), and does not rely on unstable language features. Fulfill=
ing all
> > three of those requirements at the same was a rather tricky one.
> >=20
> > The unfortunate consequence is that device_get_match_data() does not gi=
ve us a
> > pointer to the actual device ID info, but it gives us the index of the =
device ID
> > info in the device ID table.
> >=20
> > The problem is that this does not really help, because now we know the =
index,
> > but not which table it belongs to.
> >=20
> > I.e. we wouldn't know whether to call
> >=20
> > 	Self::acpi_id_table().info(index)
> >=20
> > or
> >=20
> > 	Self::of_id_table().info(index)
> >=20
> > to obtain the actual device ID info.
> >=20
> > So, unfortunately, I think we have to open code this for now.
> >=20
> > But I think this is still a minor inconvinience for being able to fulfi=
ll the
> > requirements mentioned above.
>=20
> I think there might be a chance that we can use const_refs_to_static to a=
ctually
> put pointer there. Of course, doing so is probably still quite tricky wit=
h
> feature support given all const generics hackery that we're doing :)
>=20
> I might have a go when I have time.
What does this mean for this patch series?

Will it be merged in the meantime or should we wait for your rewrite?
>=20
> BTW, if most drivers use driver_data of ID as pointers, why is it defined=
 as
> kernel_ulong_t instead of just `void*`?
The return type of `device_get_match_data` is `const void *`.
`of_device_id->data` has type `const void *`.
`acpi_device_id->driver_data` and `pci_device_id->driver_data` has type
kernel_ulong_t.

Kernel doc of pci_device_id:
"
Data private to the driver.
Most drivers don't need to use driver_data field.
Best practice is to use driver_data as an index
into a static list of equivalent device types,
instead of using it as a pointer.
"
suggests it was intended for use as index in the first place.

Thanks
- Markus Probst

>=20
> Best,
> Gary

--=-PPtNJ3QtMKIhOXT+vasR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmnRg78bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSfrEP/2zmv9JaSNQNMkkwq1PU
/foNlZgvGITdSG0BWhC2mP79SFz45qDbJN7QUeCEcDi5lgsaEpqCOZuaYmVCoI0e
4NQpf8j2ic98derNkUeq2dyGYUFeB2+GeuklI40FU6kA+A6PvXlIbhvFBJoM3QE9
jhXQ8t3MJYq6w3vGJWUuVZhjWUsoJOVnYu7JobYdXExrJyvHHKKKkbEhuSy8iPXc
WbvrF5CfLKTtsuwX4sCJDCRAUTAntR2L665qVd9aOjjKiKCCwcpKI7fw6qh+jsDE
pHTbBmeQlNTGy51hFIp02Tq7HbklOrft6hdbuaaIJKlXkBKVW8+MXw3rabhc/KaK
b4rwMieh5uffNqJgc6cRX8sSebY4s78YIv/6ZUF467yLS4EKXOHeXu2hcgVNI8Db
QjhuDTENXN1oxJunIco6rDvV+FaQ+faRXRT0b/zZ6aUYR7va+s6HHmaFQ5nXYX+b
WZHN+ZE5nXfNCn6KXcPIXyx9HAM0ec57ICFruGyfWBzIzA1ue89URjHfxWgB3UmY
p5CbeeJREM7lI1P10NaoBkjUp70YbFRFozVn0T2U7quVuj1/EyVfy4xYHGLKud0u
tLL6TbZ+NCS4Xs/nY8qaoCDRq9cgNDBnMrm7yODqkrgKG2IAOCuLMSznUNPMj58T
gPd2nIHqp9TNxhKiHNO7Itjx
=3F6L
-----END PGP SIGNATURE-----

--=-PPtNJ3QtMKIhOXT+vasR--
