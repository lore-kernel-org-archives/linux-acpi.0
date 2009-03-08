From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Sun, 8 Mar 2009 17:29:39 +0300
Message-ID: <200903081729.49003.arvidjaar@mail.ru>
References: <20090306003941.GA32403@srcf.ucam.org> <20090307202647.GA9776@srcf.ucam.org> <15e53e180903080033h5e990f08o3622afae018c38ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5614978.BGtEamftHg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.mail.ru ([94.100.176.16]:29168 "EHLO mx2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbZCHO34 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Mar 2009 10:29:56 -0400
In-Reply-To: <15e53e180903080033h5e990f08o3622afae018c38ca@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hal@lists.freedesktop.org

--nextPart5614978.BGtEamftHg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 8 =D0=BC=D0=B0=D1=80=D1=82=D0=B0 2009 11:33:48 Richard Hughes wrote:
> On Sat, Mar 7, 2009 at 8:26 PM, Matthew Garrett <mjg59@srcf.ucam.org>=20
wrote:
> > On Sat, Mar 07, 2009 at 08:19:51PM +0000, Richard Hughes wrote:
> >> Mapping KEY_SUSPEND to hibernate is just insane. Can you please
> >> change the toshiba driver to use KEY_HIBERNATE and KEY_SUSPEND as
> >> thinkpad now does? Thanks.
> >
> > Mapping KEY_SUSPEND to hibernate is what we've been doing for
> > years. It's what hal *still does*.
>
> Sure, but how much userspace now listens to HAL for these events?

Apparently KDE still does. At least it does not seem to pay any=20
attention to KEY_SUSPEND (nor KEY_SLEEP BTW).

And KDE seems to be important enough customer to not wish to break HAL.

> Xorg and evdev has taken over that role for all the session.

Oh, wait. But even Xorg 1.6.0 interprets KEY_SUSPEND as "hibernate".

KeyPress event, serial 31, synthetic NO, window 0x3e00001,
    root 0xbc, subw 0x0, time 87299792, (81,-11), root:(817,290),
    state 0x0, keycode 213 (keysym 0x1008ffa8, XF86Hibernate),=20
same_screen YES,
    XLookupString gives 0 bytes:
    XmbLookupString gives 0 bytes:
    XFilterEvent returns: False

So redefining KEY_SUSPEND is going to break Xorg too (as long as anyone=20
is using those keysyms).

> We can
> ship a trivial patch as an fdi file to HAL to remap this if required.
>
> > KEY_SLEEP has been the suspend to RAM key forever.

Ehh ... actually at least in Toshiba case it was not :) hald Toshiba=20
add-on always emitted exactly "suspend" and "hibernate" D-Bus events.=20
Not "sleep".



--nextPart5614978.BGtEamftHg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmz1lYACgkQR6LMutpd94xWtQCgzhDXlur1u6rDRtSZqZKk5Wxt
qFsAoKgyrr3DeSWKnalmE6B5rPRagmg3
=dPYj
-----END PGP SIGNATURE-----

--nextPart5614978.BGtEamftHg--
