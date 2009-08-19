From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH 2/3] Add rfkill support to compal-laptop
Date: Wed, 19 Aug 2009 13:39:23 -0500
Message-ID: <4A8C46DB.8040904@dell.com>
References: <4A89E768.7010207@dell.com>	 <1250558643.30166.109.camel@localhost.localdomain>	 <9b2b86520908180044l72cb8642j6256e246662f7971@mail.gmail.com>	 <9b2b86520908180752k66feda09rf9034a96ac6ef470@mail.gmail.com>	 <4A8AE459.8060102@dell.com>	 <9b2b86520908181408v5f7875b6sea31d8d95cc08c0b@mail.gmail.com>	 <1250631063.16393.14.camel@johannes.local>  <4A8B246D.7050004@dell.com>	 <1250672475.25419.7.camel@johannes.local>  <4A8C2C6C.2020007@dell.com> <1250702012.8073.1.camel@johannes.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A57CF88BCAD1AC6B4DB370D"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752876AbZHSSin@vger.kernel.org>
In-Reply-To: <1250702012.8073.1.camel@johannes.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>, Marcel Holtmann <marcel@holtmann.org>, cezary.jackiewicz@gmail.com, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A57CF88BCAD1AC6B4DB370D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johannes:

Johannes Berg wrote:
> Hi Mario,
>
> First, let me say I agree with Alan, the option 1 is more desirable if
> possible to do with the hardware. But this looks ok from an rfkill POV
> now, except there's a small bug:
>
>  =20
It looks like option 1 works properly on my hardware, so I've switched
the other code around.
>
> That doesn't error out, so
>
>  =20
>
> this will crash without NULL checks.
>
> (and you have to explicitly assign NULL in setup_rfkill() too, when
> bluetooth fails and wifi is freed)
>
>  =20
OK, i've cleaned that up to just error out on the module if rfkill
doesn't get initialized right.
> johannes
>  =20
I've resent separately, and think I have git send-email working, so
hopefully won't have to attach in the future.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig5A57CF88BCAD1AC6B4DB370D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqMRtsACgkQ2CrZjkA73YsZhgCgm+ZhkjIR2LMEVe0Oqr3Ziyxr
SJkAnRYT316wWHMYM6pzJ8eTnnysGqRw
=1+Ll
-----END PGP SIGNATURE-----

--------------enig5A57CF88BCAD1AC6B4DB370D--
