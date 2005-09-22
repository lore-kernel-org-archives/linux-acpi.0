From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Thu, 22 Sep 2005 14:52:48 +0200
Message-ID: <20050922125248.GD6860@orest.greek0.net>
References: <20050618004506.GE3690@orest.greek0.net> <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl> <200508191749.18016.mail@hboeck.de> <1124634977.4952.9.camel@nouse.net> <20050921090810.GS22403@orest.greek0.net> <1127309993.26683.15.camel@f100.suse.de> <20050921150851.GU22403@orest.greek0.net> <20050922121342.GA9462@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050922121342.GA9462-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hanno =?iso-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2005 at 02:13:43PM +0200, Karol Kozimor wrote:
> Thus wrote Christian Aichinger:
> > The old patch was kind of a "Want to get this thing to work
> > for me" version. This one is more the "Let's get this thing finally
> > fixed in mainline" version now.
>=20
> Doesn't the fix for kernel bug #5067 help? The object actually returned by
> INIT depends on the DSDT, how can this be a problem is explained in the
> comments in the above fix.
> Best regards,

This is quite simmilar to my first patch actually, in that it
assumes P30 if model->type !=3D ACPI_TYPE_STRING. This fixes the P30
oops, but this breaks ASUS W5A. My suspection (as mentioned
previously) is that on W5A INIT returns an ACPI_TYPE_BUFFER, which
happens to have the same memory layout as ACPI_TYPE_STRING.

So you really have to explicitly check for ACPI_TYPE_INTEGER, as my
patch does it.

As the #5067 patch does it, we can probably throw out the P30 case
in the (!buffer.pointer) path. However I'd prefer to do that cleanup
later. I just want that P30 oops fixed now without breaking other
stuff, and I'm pretty certain my patch accomplishes that.

Cheers,
Christian Aichinger

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMqkgxsP1RlTwJHsRAsIkAJ9t5KkTCL4/UyHouH08CR7LMfcbUACdHMCh
40Yllbo23vhft9csj+wO4JA=
=wPFf
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
