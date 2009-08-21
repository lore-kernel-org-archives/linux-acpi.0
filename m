From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH 3/3] Drop platform sysfs attributes from compal-laptop
Date: Fri, 21 Aug 2009 16:43:28 -0500
Message-ID: <4A8F1500.6070208@dell.com>
References: <1250706980-10424-1-git-send-email-Mario_Limonciello@Dell.com> <9b2b86520908200217j6a62b19dk6214b827af34418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig23E672FBD5FAD81401FB38C2"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932773AbZHUVms@vger.kernel.org>
In-Reply-To: <9b2b86520908200217j6a62b19dk6214b827af34418@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: cezary.jackiewicz@gmail.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig23E672FBD5FAD81401FB38C2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



Alan Jenkins wrote:
> On 8/19/09, Mario Limonciello <Mario_Limonciello@dell.com> wrote:
>  =20
>
>  =20
>
> Don't you still need to call platform_device_del() for the fail_rfkill =
case?
>
>  =20
It was previously only called if the sysfs attribute creation failed.=20
So if it does need to be called, then there was a bug previously there to=
o.
--=20
Mario Limonciello
*Dell | Linux Engineering*
mario_limonciello@dell.com


--------------enig23E672FBD5FAD81401FB38C2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkqPFQAACgkQ2CrZjkA73YtFRwCeN2o209XXx8HYBrLQ+W+epQie
krUAn0CQHxP44wuzc8HrRh+KewDpBi9H
=qw4t
-----END PGP SIGNATURE-----

--------------enig23E672FBD5FAD81401FB38C2--
