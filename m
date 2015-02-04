From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 21/21] arm64: ACPI: additions of ACPI documentation
 for arm64
Date: Wed, 4 Feb 2015 18:12:29 +0000
Message-ID: <20150204181229.GB21293@sirena.org.uk>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-22-git-send-email-hanjun.guo@linaro.org>
 <54D16A74.3030206@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xXMM6Y0U0K8Flxwk"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:50685 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161126AbbBDSNe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 13:13:34 -0500
Content-Disposition: inline
In-Reply-To: <54D16A74.3030206@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <al.stone@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com


--xXMM6Y0U0K8Flxwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 05:40:20PM -0700, Al Stone wrote:
> Much removed to cut down the size on this and to highlight a couple of sp=
ecific
> sections pertinent to the ACPI on ARMv8 TODO List.....

This is of course good practice when replying to anything!

> > +_DSD	6.2.5		To be used with caution.  If this object is used, try
> > +			to use it within the constraints already defined by the
> > +			Device Properties UUID.  Only in rare circumstances
> > +			should it be necessary to create a new _DSD UUID.
> > +
> > +			In either case, submit the _DSD definition along with
> > +			any driver patches for discussion, especially when
> > +			device properties are used.  A driver will not be=20
> > +			considered complete without a corresponding _DSD
> > +			description.  Once approved by kernel maintainers,
> > +			the UUID or device properties must then be registered
> > +			with the UEFI Forum; this may cause some iteration as
> > +			more than one OS will be registering entries.

> [snip...]

> So, this is my attempt to encapsulate what I think people want to have ha=
ppen
> around the use of _DSD; I just want to make sure I point it out so it doe=
sn't
> inadvertently get lost somehow.

> Is this far too little?  Is it sufficient?  If it only addresses part of =
the
> concerns, what did I miss?

This does take us back to the issue of how exactly one is supposed to
register/approve _DSD bindings and what format they're written in which
I don't think we ever fully got to the bottom of it (there's some stuff
on the UEFI website but it's definitely looking a bit placeholderish).

--xXMM6Y0U0K8Flxwk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0mEMAAoJECTWi3JdVIfQSlEH/1WHzR0hJ3mJuxeu+2pxQShI
4Uq6mxKJPHxKEUL953ly0KBOrDamE8DdzJUDK42YwwZhJQ41/7KrlrbsnwyL5Kfd
ikMbSk+rFgGO/wD+Go0XZuVTyjTDNS+Hiq4Dg4cc5jcrIx2PVxUPUebGxrTChuD4
RLykxLuyEdXGK/syFcrtxKaliS2kJoWfdbe6VFmddOgnEM2Bn0awiAcM8oa3ae1q
8YiR7PYbUY7TCFX5LvInUmZAtsVYHAseNnFVEiIE1yb3vrCZ4TRRedGMTKxyNXso
m+yCJC84QNKi7jA/3c5bi1DDQ3ovSqKlpeniA2C8iKoDkNw5FYRdxNv/4R0DJHI=
=c0gR
-----END PGP SIGNATURE-----

--xXMM6Y0U0K8Flxwk--
