From: James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH] ACPI / video: Only default only_lcd to true on
 Win8-ready _desktops_
Date: Tue, 24 Apr 2018 22:50:48 +0100
Message-ID: <20180424215048.GC25058@saruman>
References: <20180417162350.12227-1-hdegoede@redhat.com>
 <57c14762-f327-aab2-7b06-5320d93010be@redhat.com>
 <CAJZ5v0hvLOPJ0aM5WLBZ0GT9Drcezvpq1CkH6S3Jxw3t6He+Xg@mail.gmail.com>
 <0b3fb04d-5dbc-19ce-0fd1-890dcf58bf52@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0b3fb04d-5dbc-19ce-0fd1-890dcf58bf52@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 11:13:25PM +0200, Hans de Goede wrote:
> FWIW this has gotten into 4.15 without it having a Cc: stable or a
> Fixes: tag, I think it was picked up by the new magic scripts scripts
> which try to find commits which should have a Cc: stable but are lacking
> one.
>=20
> In this case I deliberately did not add a Cc: stable as what gets fixed
> is not that important, whereas the possible regression this might cause
> (and actually seems to be causing) is sorta bad.

This isn't the first time I've seen patches backported that simply don't
need to be, or shouldn't be. In one case a few years back the patch had
a fixes tag, but it still wasn't important to backport, which is why I
left off the Cc stable, and in fact it broke something.

TBH its a bit distracting having to review such patches, which I've
already looked at before, determined there's no need for a backport, and
subsequently paged out of my head.

Stable folk: is there already (and should there be) a defined mechanism
to record that a given patch is:

1) not suitable/worthwhile to backport (e.g. even though it might have a
   Fixes tag or use the word "fix").

2) OR it would require a bit more human effort to backport (perhaps it
   applies cleanly but would be expected not to build/work) and probably
   shouldn't be attempted automatically.

3) OR it probably isn't worth backporting and is risky to do so, and so
   should only be carefully attempted if somebody actually complains.

other than simply stating it in prose in the commit message?

Cheers
James

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWt+muAAKCRA1zuSGKxAj
8sfOAQDj0GReVAg8OXqZ2r7Ck/C0sYEo5+W2MIheD56Zjt/F9AD+OwsOvRN4TTmF
lzwJnmrDpkEywYyTzYzn1gxtUEpVsAw=
=wG5j
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
