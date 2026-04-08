Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401837EFFC
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677214; cv=none; b=B5pZiX7lEpe3mNZNXWyMWT3iPpjKOgi5h9/xxu1UvbI2QjbZtgmpOhT/VvPrQhXuCdugoaI78i6Y3+UgTVoioNPCGEdWcS2IyXL+MA1IDg3GygVUvfNXrj1xY02Nwu5gILHUwn/F08ciqNUtwg6dJQMeO6DDD5+WOERQSwo75Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677214; c=relaxed/simple;
	bh=zJspBrIyqeVFvXwfA+wLmc8xzG4SgrlWjRHj/+PkBGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XTCPGlcKFKk9hQ6GntNayirvfy1wSJ0QLdP6fnMjM7vxN3eN8qWikV5/AaTGwkrh9Awb8MAhwACvXQlCxtctIii106OmohLqbWLwq7jknfczItGTZ5SsGPPUk8HhD+g/FnWSqjRAB+YdZEMfAWN9YICW+0VA92ToDnOC4Aua3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=KWaKnLBK; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="KWaKnLBK"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 8064A240028
	for <linux-acpi@vger.kernel.org>; Wed,  8 Apr 2026 21:40:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1775677207; bh=OzXzRs80+C/tdPr92uL1n+TMaP+DqNF5wtmPwjmIaFw=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=KWaKnLBKICmTYJZ8U1Ziune9w9/2XoZiRBBsRZOl8KJqEAavZUCe+YzeBaovDqUQ+
	 fVS8zMDslJa03+k5UE800EYEz0Gpu9A+jrR7TfYuJj3AP2CJBSeVR4XipNFdfXIFaM
	 2YgRlncMqQN/oh8kEiG5yTFiHjA+ZtbEgwd6WDr+sf510CKh2b1DMPQSm4Kl0p8E9l
	 Mc5e1gsw0guQXbt8OL6/FYI1wKtjDoNB4d30nQEp/sNuiyRNndTN0ASwCP4BwhShWF
	 2BlJ+LNmpDu0aH8eGkAzqcbn3O4YpRLcDWW9V4Su44Xy8YByZEv9MmoMHJKCkzdi5d
	 jvl8i0t595uWQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4frYLX2YrKz6twS;
	Wed,  8 Apr 2026 21:40:04 +0200 (CEST)
Message-ID: <4d5cd9887e67007f4dabfed0986861a60e395ae6.camel@posteo.de>
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
Date: Wed, 08 Apr 2026 19:40:06 +0000
In-Reply-To: <DHNWFFEB3HD9.1QM2XXNE6BANY@kernel.org>
References: <20260407-rust_acpi_prp0001-v3-1-c5b24590c273@posteo.de>
	 <DHNWFFEB3HD9.1QM2XXNE6BANY@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-r0pcm+OAqpqydyhwgH7P"
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-r0pcm+OAqpqydyhwgH7P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-04-08 at 18:03 +0200, Danilo Krummrich wrote:
> On Tue Apr 7, 2026 at 11:41 PM CEST, Markus Probst wrote:
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index aad1a95e6863..d0098f24346f 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -187,6 +187,10 @@ struct acpi_driver {
> >   * -----------
> >   */
> > =20
> > +bool acpi_of_match_device(const struct acpi_device *adev,
> > +			  const struct of_device_id *of_match_table,
> > +			  const struct of_device_id **of_id);
>=20
> This also has to be defined for !CONFIG_ACPI, otherwise we run into the
> following compatible error.
>=20
> 	error[E0425]: cannot find function `acpi_of_match_device` in crate `bind=
ings`
> 	      --> rust/kernel/driver.rs:295:24
> 	       |
> 	   295 |       unsafe { bindings::acpi_of_match_device(adev, of_match_ta=
ble, of_id) }
> 	       |                          ^^^^^^^^^^^^^^^^^^^^
> 	       |
> 	      ::: /mnt/nvme/work/projects/linux/driver-core/driver-core-testing/=
rust/bindings/bindings_generated.rs:118713:5
>=20
> There is an
>=20
> 	#else	/* CONFIG_ACPI */
>=20
> block at the end of acpi_bus.h for this.
I don't think the function exists in that case and bindgen can't
generate inline functions, so I will just add a `#[cfg(CONFIG_ACPI)]`
condition on top of the function.
>=20
> > +
> >  /* Status (_STA) */
> > =20
> >  struct acpi_device_status {
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_h=
elper.h
> > index 083cc44aa952..e47643ce8b50 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -96,6 +96,11 @@
> >   */
> >  #include <../../drivers/base/base.h>
> > =20
> > +/*
> > + * The driver-core Rust code needs to call `acpi_of_match_device`.
> > + */
>=20
> NIT: I'd drop this comment as such comments usually do not age very well.=
 :)
>=20
> I assume you followed the above comment for
>=20
> 	#include <../../drivers/base/base.h>
>=20
> but this one is different as it justifies why we have to include an inter=
nal
> header in general (i.e. not for a specific function).
>=20
> > @@ -278,6 +283,18 @@ fn init(
> >      }
> >  }
> > =20
> > +#[inline(never)]
> > +#[allow(clippy::missing_safety_doc)]
> > +#[must_use]
> > +unsafe fn acpi_of_match_device(
>=20
> Maybe add a very brief comment similar to the one in devres.rs for this.
>=20
> > +    adev: *const bindings::acpi_device,
> > +    of_match_table: *const bindings::of_device_id,
> > +    of_id: *mut *const bindings::of_device_id,
> > +) -> bool {
> > +    // SAFETY: Safety requirements are the same as `bindings::acpi_dev=
ice_id`.
>=20
> Typo: s/bindings::acpi_device_id/bindings::acpi_of_match_device/
>=20
> > +    unsafe { bindings::acpi_of_match_device(adev, of_match_table, of_i=
d) }
> > +}

Thanks
- Markus Probst

--=-r0pcm+OAqpqydyhwgH7P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmnWrxIbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSligQALe2ivKKk9GxR7VNoq7j
6icq9A8ix4rAFMDkZVgBGzrXazG1g1oM77T1JByoQtsTTBngQu0o1xfnqj0NrqG8
mNJitWJ+SvnpU+lSAJ1hrE39I5Uimc9Vk9JevrfsdyXHWtmSURcSKzGP1BiRlqx3
tjbT0nKUqQI76cOj1OnFzHI4OXlZ7fWixGnnshwy7onxaHPw1QCaguGCxwGSGXy8
n24U8z6OnJlNGFcKpgJzZZ0LhzkIE9XCqEzdE1vZMImAityUFIXuXF5frJtgbTdu
t0aIihN+XJCFXYM8+FpFBB7W2lpk5gdW8zp3KBns86O1fO91qB9BZ1EMKMs4r0JS
579rcCjW333rou3c7d+rEC1bcqTdPhe3onJPWbvWMzHZh37cREUR+q6hkQS6CRxf
cDi568lUD2qYQds7h6nMCeUPZNMadpda7eQ2PLB77BACCFEYDCqQqOBb0qfiJtGD
oPO+D2Bmgy6odHlMJPrCdktrbZ4BAGKi0LrG14JKzybutD7l6LdkBmQ7+MZsXb87
MiX+BttluBXljXSruLCbXkKVtHIw2ccNPbql6QMKqfwUlRDNWWSjTI+0BmJagFXo
Hx1xJF1X1Vz/2U9DfAOWmD8tVfWM4XH9yMZK1irwne+cAACAIZEicRU50NJZe48T
2K7vvRnzMNUY3nfnHdaie9Vd
=9ZyQ
-----END PGP SIGNATURE-----

--=-r0pcm+OAqpqydyhwgH7P--
