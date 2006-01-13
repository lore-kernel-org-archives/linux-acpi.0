From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Fri, 13 Jan 2006 15:21:18 +0100
Message-ID: <87u0c8xl7l.fsf@gismo.pca.it>
References: <20060113095634.GA7112@mnementh.homelinux.org>
 <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com>
 <20060113133023.GA6527@mnementh.homelinux.org> <87y81kxlz1.fsf@gismo.pca.it>
 <20060113141232.GA8136@mnementh.homelinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha1; boundary="=-=-="
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20060113141232.GA8136-zdned+2MO19t+tyI2NedBz+iFHGzDt/a@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello!

On Fri, 13 Jan 2006 15:12:32 +0100, Fr=C3=A9d=C3=A9ric Gobry wrote:
>>           1 http://debian.fastweb.it experimental/main Packages
>
> aha ! that's why my own apt-cache search returned nothing :-)

And that's why I put that line ;-)

>> FWIW, I've a T42p with a vanilla 2.6.15: suspend-to-ram and
>> suspend-to-disk works out of the box, with all the drivers enabled
>> (included ipw2100, radeonfb and Xorg radeon without DRI), even with
>> multiple repeated cycles.
>
> vanilla 2.6.15 means "debian-vanilla" or vanilla from kernel.org ?

"vanilla" =3D "kernel.org".  The kernel is the only thing I compile by
myself.

> I use the radeon and dri modules, maybe I should try your setup. I'd
> be sad to give up dri, though.

I suggest to try without DRI and from the console.  Then in a console
and so on.  A lot were my tests...

Thx, bye,
Gismo / Luca

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDx7dhVAp7Xm10JmkRAkxKAJ9hVtJPxTB9Gx3K5Y7J46rxFNqiFQCfVD1B
pe2MLCUsdWJ0438q4+IVrjE=
=HeEa
-----END PGP SIGNATURE-----
--=-=-=--
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
