From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to save
 event log
Date: Thu, 22 May 2014 21:40:58 -0400
Message-ID: <20140523014058.GA16945@gchen.bj.intel.com>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-7-git-send-email-gong.chen@linux.intel.com>
 <20140521110630.GG21205@pd.tnic>
 <20140521234626.GA1644@gchen.bj.intel.com>
 <20140522111140.GH4383@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17557 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbaEWCIT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2014 22:08:19 -0400
Content-Disposition: inline
In-Reply-To: <20140522111140.GH4383@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2014 at 01:11:40PM +0200, Borislav Petkov wrote:
> Date: Thu, 22 May 2014 13:11:40 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to sa=
ve
>  event log
> User-Agent: Mutt/1.5.23 (2014-03-12)
>=20
> On Wed, May 21, 2014 at 07:46:26PM -0400, Chen, Gong wrote:
> > On Wed, May 21, 2014 at 01:06:31PM +0200, Borislav Petkov wrote:
> > > > +	if (ras_userspace_consumers() =3D=3D 0) {
> > >=20
> > > 	if (!ras_userspace_consumers())
> > >=20
> > No, it is not a pointer so I don't think it is very
> > meaningful just to save some bytes.
>=20
> Btw, this is exactly why your patches take too long to review - you like
> to debate more instead of listening to the maintainers. Next time you
> want to speed up the process, just think about that.
>=20
Sorry, I'm afraid I can't agree with you. Why should I just follow you
blindly without any my own voice? Even if some times I act like an
idiot. If I can't say anything for so small thing, do you expect I
should shout aloud for something like kernel infrastructure?

OK, I will change soon, as you wish.=20

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfqcpAAoJEI01n1+kOSLHuA0P/1XNn+qHX4XZ4yCkI52rfdoU
IYxriYRAWDXtjMEqaSUi96saaDA/y8BwehrVZ8nhtEkL5ip9cKPPnXL1Xb135Ttz
w0Jrbp47vAhXjRuAz7LdH+tO4kd3KjR29JPlf8hn4E1N7ArZwtbffOoSK2O/Mn32
hHt30GsuMDSZllseRYLOKgonhXHRlu2Xm28FMI2mNC3sH5i+B9gpT2X0e4c5C9fb
BE7f6ZPcSDaoAkMsVm0s5ZnyMN0/E9WPuV6fTiZPUILAaDfOzDm+yTntkg5YWLpm
1s9Dw2uEI7wKX6EBl0KaaYDDt9zpQbHky1be8M2PcurVkJMdUgCLwynZZsQSSRTL
ujZK5GViCnqfm4Brkqekid96lK8+EFaao7c8tR0uCLTZVC2a7CxQR1oDfoMLQZx9
46aXfi7P3+whXBYbdXfH9SV//YV967hpr3b4e5PBfbplsXQ0gwusdG/xqX0kPaTr
UXSj3VHQ1KDsVOVKevgHuUm0ymYCDooOOy0T8RLCfLmRuzKQTn4zO5LWWjhfuuKS
eSoTR2tCE7EbZ47oSWrFU2NEO1k0zYgGydV1HGe2RClJCs5E2+kSnfW/gYGJ+VuK
Pk7E4hAYguPCiF9gnD503a3xlGJvfnz7CXn6MGB/Rsum615y2eEpPmHBCtOZk8mT
LyoGktOzb9dI23F9uyNw
=8Bt4
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
