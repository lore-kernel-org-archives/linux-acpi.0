From: Christian Aichinger <Greek0-hi6Y0CQ0nG0@public.gmane.org>
Subject: Re: oops with asus_acpi on P30/P35
Date: Wed, 21 Sep 2005 17:08:51 +0200
Message-ID: <20050921150851.GU22403@orest.greek0.net>
References: <20050618004506.GE3690@orest.greek0.net> <42C2BA01.2060806@gmx.net> <20050629155015.GB14659@hell.org.pl> <200508191749.18016.mail@hboeck.de> <1124634977.4952.9.camel@nouse.net> <20050921090810.GS22403@orest.greek0.net> <1127309993.26683.15.camel@f100.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gV1yUYniiDLxW66s"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1127309993.26683.15.camel-1iW2g3EOClSoYr4blSSd5g@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Hanno =?iso-8859-1?Q?B=F6ck?= <mail-60OJuG18Xr6zQB+pC5nmwQ@public.gmane.org>, Karol Kozimor <sziwan-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--gV1yUYniiDLxW66s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 03:39:53PM +0200, Timo Hoenig wrote:
> On Wed, 2005-09-21 at 11:08 +0200, Christian Aichinger wrote:
> > If this fix still breaks other laptops I'd really be puzzled, since
> > currently the value is dereferenced later when doing the string
> > comparisons. So the patch at least shouldn't break it more than it
> > already is ;)
>=20
> I can confirm that your patch works fine for the W5A which previously
> needed the mentioned workaround.  But this single case of success should
> not be taken as proof.  More testing would be reasonable.

The old patch was kind of a "Want to get this thing to work
for me" version. This one is more the "Let's get this thing finally
fixed in mainline" version now.

The patch only changes the behavior if the INIT method returns an
integer instead of a string, or a pointer to an integer or similar.

Now if an integer is returned this breaks the assumption in the
whole rest of the function, namely that model->xxx.pointer can be
dereferenced. This works for ACPI_TYPE_STRING and ACPI_TYPE_BUFFER.
Why the old patch broke you is probably because the INIT method
in your DSDT returns a _BUFFER instead of an _STRING.

In any other case (including ACPI_TYPE_INTEGER) dereferencing
model->pointer (or whatever's stored at that offset) WILL lead to an
oops.

Pointer magic isn't possible in AML AFAIK and it would be sheer luck
(and still a bug) if dereferencing some random integer gotten from
some AML function would actually work.

That's what I ment with the "if this breaks something it was at
least as broken before". If this patch changes the behavior for you,
you got a kernel oops without it.

It would probably be nice to add a check for
(model->type =3D=3D string || buffer) for defensive-programming's sake.
However that can (and should probably) be done later on.

Cheers,
Christian Aichinger

PS: Would be nice if you could test my assumption that model->type
is really ACPI_TYPE_BUFFER on your laptop, by pasting a dmesg
snippet with that patch applied (should apply to vanilla -rc2):

diff --git a/drivers/acpi/asus_acpi.c b/drivers/acpi/asus_acpi.c
--- a/drivers/acpi/asus_acpi.c
+++ b/drivers/acpi/asus_acpi.c
@@ -1006,6 +1006,7 @@ static int __init asus_hotk_get_info(voi
        }
=20
        model =3D (union acpi_object *)buffer.pointer;
+       printk(KERN_NOTICE "  DEBUG: model->type =3D=3D %d\n", model->type);
        if (model->type =3D=3D ACPI_TYPE_STRING) {
                printk(KERN_NOTICE "  %s model detected, ",
                       model->string.pointer);

--gV1yUYniiDLxW66s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMXeDxsP1RlTwJHsRArgfAJ9S5s3XhQUjo744ePAMxQSMgMy7GwCePIOu
MLI8zJ42zTxnJOjlcsjBnJg=
=KjWV
-----END PGP SIGNATURE-----

--gV1yUYniiDLxW66s--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
