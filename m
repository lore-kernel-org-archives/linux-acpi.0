From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: experimental patch for toshiba_acpi
Date: Sat, 28 Feb 2009 09:13:37 +0300
Message-ID: <200902280913.45040.arvidjaar@mail.ru>
References: <200902280015.17286.arvidjaar@mail.ru> <E1LdAJL-0003Jk-EQ@tan.cit.nih.gov>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8796569.AibKpPt74l";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx48.mail.ru ([94.100.176.62]:6434 "EHLO mx48.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbZB1GNv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 28 Feb 2009 01:13:51 -0500
In-Reply-To: <E1LdAJL-0003Jk-EQ@tan.cit.nih.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles@schwieters.org
Cc: linux-acpi@vger.kernel.org

--nextPart8796569.AibKpPt74l
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 28 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2009 00:31:59 Charles@schw=
ieters.org wrote:
> Hello Andrey--
>
> > >This patch comes from
> > > http://memebeam.org/free-software/toshiba_acpi/. With this patch,
> > > the module conflicts with the toshiba module (which works only on
> > > non-acpi-enabled kernels).
> >
> > Could you please elaborate? Because (Portege 4000):
> >
> > {pts/2}% lsmod | grep tosh
> > toshiba                 4012  0
> > toshiba_acpi            7540  0
> > rfkill                 10480  1 toshiba_acpi
> > backlight               4560  2 toshiba_acpi,video
> > input_polldev           4012  1 toshiba_acpi
> > {pts/2}% sudo fan
> > Fan is on.
>
> My understanding is that with the experimental patch, both toshiba
> and toshiba_acpi use /dev/toshiba. Do you have the experimental patch
> applied? Does fan work if you remove the toshiba module?
>

May be I misunderstood you then; do you mean that *if* this patch is=20
applied module toshiba works on non-ACPI kernels only? That would be the=20
case then.

But then I do not understand why you need this in toshiba_acpi in the=20
first place. We already have in-kernel module (toshiba) that provides=20
raw user space HCI access to those who need it. Why is it necessary to=20
duplicate this functionality in toshiba_acpi in the first place?

--nextPart8796569.AibKpPt74l
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmo1hMACgkQR6LMutpd94wPWwCcDTymQd9QidoreArtK/C+0kvH
umoAoJEL82ybw9eQz4dWqv2g5TvVuZKH
=MdZS
-----END PGP SIGNATURE-----

--nextPart8796569.AibKpPt74l--
