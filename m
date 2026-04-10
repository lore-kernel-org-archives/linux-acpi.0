Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3F3D7D7B
	for <linux-acpi@vger.kernel.org>; Fri, 10 Apr 2026 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833040; cv=none; b=HIQWQ3Lv79xmZJWBnqSLdDESTqNZJ+WpwXRBex7PcBs7jgtnWQQN5K6xUVHgwEPeRoDaFRSYiGqGYvDscSlhzSksCyVXKkO25LJurhcbsCTrgtOFu7BvZ0MOONWVo2N6Nc9LXK2KfD1Gzs86LobAJ8HAP53YkAKMbNzCPHHB7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833040; c=relaxed/simple;
	bh=BBCyDm6ZOScKgHBSmWujAr9ZbowcP5MVOPw0e/pzp/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jE1n5sJxaazH7JxuUPdnQnJNtG4JbpZlbKH+WFO5QdsgipjJX+RJzFoiElhmqbc5QhtNTUOnrpSWT+rRrKx9kOBEaVPbSj6ZnZq8Zv+b1RvFwwSBKFApxgZ4mFwTbip6sHk5Bnau/moGmF0NwEbWG2+MZovhlW+NtA32a1i8g90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=SH0hoAPJ; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="SH0hoAPJ"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C6664240103
	for <linux-acpi@vger.kernel.org>; Fri, 10 Apr 2026 16:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775833035; bh=50IaxMfYb7aroQWQsATCxQ2AIuqB50Wsug3UV/yX5r0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=SH0hoAPJWm/RN+2EslAeV1OqA24xKSQIeE1fB9HpuRgjReh0ZfwCirLieMYD9gB2B
	 8hD7sKc5oupr/+KPhyYesa9d0qMl9iIrxfbedMlrKYWkpM8bSD3kppDne2h/iSOFmw
	 UvL0swjtJdj30856ZxZ6FmGk9d1Dv4LDwBavJJ5GtXhCUdeWdxAG3Lk+CUHrrt9PKg
	 dOUG6eNR3FqSslBi86DDSEofXfKCT4RfEzF6mA7o5uBLJkBASjDkZmqbYWAKFSXSG3
	 fY28mBNr4GEwnKl7O5pvYKpPy8P3XUnKhzmU/ubcq7cQqet9vElFAYwzaa24P3tZdo
	 RtiR4FJgFxJqw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fsfzD6VBWz9rxD;
	Fri, 10 Apr 2026 16:57:12 +0200 (CEST)
Message-ID: <bbf903b3db06fbe9f5042dd64dc18fbc897927a4.camel@posteo.de>
Subject: Re: [PATCH v3] rust: ACPI: fix missing match data for PRP0001
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
	acpica-devel@lists.linux.dev
Date: Fri, 10 Apr 2026 14:57:14 +0000
In-Reply-To: <DHO46CIJNVZH.1Q6ZLX1XNWRR4@kernel.org>
References: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>
	 <DHNWFFEB3HD9.1QM2XXNE6BANY@kernel.org>
	 <4d5cd9887e67007f4dabfed0986861a60e395ae6.camel@posteo.de>
	 <DHO1GI8ZAR1L.3DUWFSM1VT8BS@kernel.org>
	 <e6985ffe6d35e27b85b540e410cf92592d597a69.camel@posteo.de>
	 <DHO46CIJNVZH.1Q6ZLX1XNWRR4@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-vQ4DsA9o3Evk1s4cnEPc"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-vQ4DsA9o3Evk1s4cnEPc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-09 at 00:07 +0200, Danilo Krummrich wrote:
> On Wed Apr 8, 2026 at 11:42 PM CEST, Markus Probst wrote:
> > On Wed, 2026-04-08 at 21:59 +0200, Danilo Krummrich wrote:
> > > On Wed Apr 8, 2026 at 9:40 PM CEST, Markus Probst wrote:
> > > > On Wed, 2026-04-08 at 18:03 +0200, Danilo Krummrich wrote:
> > > > > On Tue Apr 7, 2026 at 11:41 PM CEST, Markus Probst wrote:
> > > > > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > > > > index aad1a95e6863..d0098f24346f 100644
> > > > > > --- a/include/acpi/acpi_bus.h
> > > > > > +++ b/include/acpi/acpi_bus.h
> > > > > > @@ -187,6 +187,10 @@ struct acpi_driver {
> > > > > >   * -----------
> > > > > >   */
> > > > > > =20
> > > > > > +bool acpi_of_match_device(const struct acpi_device *adev,
> > > > > > +			  const struct of_device_id *of_match_table,
> > > > > > +			  const struct of_device_id **of_id);
> > > > >=20
> > > > > This also has to be defined for !CONFIG_ACPI, otherwise we run in=
to the
> > > > > following compatible error.
> > > > >=20
> > > > > 	error[E0425]: cannot find function `acpi_of_match_device` in cra=
te `bindings`
> > > > > 	      --> rust/kernel/driver.rs:295:24
> > > > > 	       |
> > > > > 	   295 |       unsafe { bindings::acpi_of_match_device(adev, of_=
match_table, of_id) }
> > > > > 	       |                          ^^^^^^^^^^^^^^^^^^^^
> > > > > 	       |
> > > > > 	      ::: /mnt/nvme/work/projects/linux/driver-core/driver-core-=
testing/rust/bindings/bindings_generated.rs:118713:5
> > > > >=20
> > > > > There is an
> > > > >=20
> > > > > 	#else	/* CONFIG_ACPI */
> > > > >=20
> > > > > block at the end of acpi_bus.h for this.
> > > > I don't think the function exists in that case and bindgen can't
> > > > generate inline functions, so I will just add a `#[cfg(CONFIG_ACPI)=
]`
> > > > condition on top of the function.
> > >=20
> > > Usually we provide a stub instead of conditionalize the callers; this=
 case might
> > > be a bit special, but I'd still follow the usual pattern.
> > The usual C pattern would be
> >=20
> > static inline bool acpi_of_match_device(const struct acpi_device *adev,
> > 			const struct of_device_id *of_match_table,
> > 			const struct of_device_id **of_id);
> >=20
> > , which is ignored by bindgen (i. e. same error).
>=20
> That's where you define a Rust helper; we have lots of cases where we onl=
y have
> the Rust helper to deal with the inline function stub used when the
> corresponding CONFIG_* is disabled.
According to git commit msg [1], __rust_helper is needed to inline
these helpers into Rust code. Does this mean we could omit the extra
function declaration with #[inline(never)] and just use a helper
without __rust_helper?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Da9aabb3b839aba094ed80861054993785c61462c

Thanks
- Markus Probst

--=-vQ4DsA9o3Evk1s4cnEPc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmnZD8gbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSjTgQAJxzmgET7ENUYshXpn8f
OQo7nKxHlBxDTDb/C+h9tV3LH/AlKQ4c1xcxfIxinrW/8N3/XwHpCZEi/mgx4PG5
pmthLwQFscaChQD/jMyscKKqZjDxddHpR2KuOqR4J7OD/EBM7yEi+niXAzg3IEjw
GIZEtc3xKIk7m4hLAqNNqUXj5vO6XX4cpgTBvwkNGXVGRwHnsB4kB3XgfeJkJYjT
l3sK/w8dnhQJ8LGrmJfAKE3MLOe6SREP4Bb5ZSXaAc0/CA347cMf13NLKV8Zi8VF
I19TrBIxotc/WhvEc1jXJ0TANZ8tVmdKufaAcMmMXVbgUZCa4cvlP4hPMOO2+Vr/
MwixyugodZkyaO9d+RSTdBjduGmYuGdL7nmL4Fgchpw8QpDuDu3knldf9qOM3kU0
8TjLDdIIA9/fVYsTqb0rSPQ5onoKXiOLeNjKxiLqGYDwkeDlCr1SCZl0e0BLEbWM
tAwmb/e1uVKwgIRAj1tYV5jWlctoDofhOt356qilNT83kqpBrJoGvzFX2eZa164M
k4kso+djELpWsS4FA/ppJncxWhokjhHt6s+rqzQDeXkB56+9DLaQGajY+1i1h2Po
9R64BBAg8qE4xnTKnQMYQ6QLGUBR5EsTW4i5qIVUMT66v8PpeBratgGWZN53ySqQ
oo4cqp+8nQhxKrIc6IRy1M7f
=9POa
-----END PGP SIGNATURE-----

--=-vQ4DsA9o3Evk1s4cnEPc--
