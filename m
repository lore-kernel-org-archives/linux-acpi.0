From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: Re: laptop turns itself off
Date: Mon, 30 Sep 2002 22:00:11 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021001030010.GG25319@draal.physics.wisc.edu>
References: <20020927142320.GB2821@lps.ens.fr> <20020927154542.GH7904@poup.poupinou.org> <20020930155044.GA21015@lps.ens.fr> <20020930163324.GF25319@draal.physics.wisc.edu> <20020930215142.GA413@bender.fimaluka.org> <20020930234303.GA6392@bender.fimaluka.org> <20020930215142.GA413@bender.fimaluka.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020930163324.GF25319-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org> <20020930234303.GA6392-/NKw+Yvz+g6ASgUTbsq1wEB+6BGkLq7r@public.gmane.org> <20020930215142.GA413-/NKw+Yvz+g6ASgUTbsq1wEB+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Ralf-P. Weinmann" <ralf-HCprxmsOTPNg9hUCZPvPmw@public.gmane.org>, ?ric Brunet <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ralf-P. Weinmann [ralf-HCprxmsOTPNg9hUCZPvPmw@public.gmane.org] wrote:
> Hi Bob,
>=20
> I'm having exactly the same issue that you're having with your Compal, ju=
st
> with a Satellite 3000-514 here. The laptop came back from my Toshiba repa=
ir
> shop for the second time already. Both times the mainboard was swapped, I=
 was
> told, altogether it was replaced three times, twice at the local Toshiba =
shop,
> once at Toshiba Europe in Regensburg. What happened before was that the m=
achine
> would crash occasionally afterwards refuse to turn on again. The screen k=
ept
> blank and a short beep-beep was sounded by the BIOS diagnostic routines, =
which
> according to the Phoenix site can be just about any frigging hardware err=
or.
>=20
> So now I get the machine back with system board #4 last Saturday and sinc=
e then
> it keeps spontaneously turning off on me. Four times thus far, sometimes =
even
> when the laptop was damn cold. Coming back home this Saturday, the tosh-3k
> module showed incredibly low values (26 Celsius). Few minutes later, the
> machine turns itself off. I have not been able to reproduce this under Wi=
ndows
> XP, I'd really love to hear from someone who has the same problem under X=
P,
> because I am not really sure whether it is an ACPI problem or whether it =
is
> related to something entirely different.
>=20
> The new system board seems to have an updated BIOS with a release date of
> 2002/02/19. I'm really wondering what's going on.
>=20
> I'm wondering whether it's worth to contact Toshiba on this again now, or
> whether I should wait till the mainboard fries again :)
>=20
> On the ACPI mailing list you stated that your laptop doesn't manage to st=
ay
> up for a week even if you have acpi=3Dnoacpi passed as an kernel option.
> Does it shut itself down or does it plain crash ?

Ralf-P. Weinmann [ralf-HCprxmsOTPNg9hUCZPvPmw@public.gmane.org] wrote:
> On Mon, Sep 30, 2002 at 11:51:42PM +0200, Ralf-P. Weinmann wrote:
> > Hi Bob,
> > [...]
> > when the laptop was damn cold. Coming back home this Saturday, the tosh=
-3k
> > module showed incredibly low values (26 Celsius). Few minutes later, the
> > machine turns itself off. I have not been able to reproduce this under =
Windows
> > XP, I'd really love to hear from someone who has the same problem under=
 XP,
> > because I am not really sure whether it is an ACPI problem or whether i=
t is
> > related to something entirely different.
> > [...]
>=20
> Just a quick follow-up. I moved over part of the Java development environ=
ment
> for the project I'm working on to Windows XP today. The problem is appare=
nt
> under Windows XP as well (the default install that came shipped with the
> notebook). I'd say it falls into the category "crappy hardware problem", I
> highly doubt it can be fixed by changing the AML code. But we'll see about
> that.
>=20
> All I can say is: Toshiba, I want my money back. But that's for tomorrow.

For reference, my Compal ACL00 is equivalent to a Toshiba 3000-514 (I
believe, I could be wrong on the last 3 digits).  Compal manufactures
these laptops for Toshiba.

Based on the available information, I agree with Ralf, this is a
crappy-hardware problem.

We need to figure out which models of these laptops have this problem,
and whether the problem is universal to all of them, or a hardware bug
that can be fixed by swapping out the bad hardware (Ralf's experience
would seem to indicate universality...).  Does anyone know of someone
who has this laptop and does NOT have the turn-off/hang problem?  Bruno
you have probably had the most contact with Toshiba 3k users...

Secondly, we should all pursue remedies though the vendors that sold us
this crap.  I think a class action lawsuit would be appropriate, if they
are not willing to replace the laptops with working models.
Unfortunately, Compal appears to no longer be manufacturing this laptop.

Cheers,
-- Bob

Bob McElrath (rsmcelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

    "The purpose of separation of church and state is to keep forever from
    these shores the ceaseless strife that has soaked the soil of Europe in
    blood for centuries." -- James Madison


--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2ZD7oACgkQjwioWRGe9K34XQCdHlpfzIGc+B96ypmYwBLuHjq0
LYkAoJ8sSI6IJOpfpIWN7uGp5W7LMO4q
=WXcK
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
