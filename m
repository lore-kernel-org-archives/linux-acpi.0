From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: patched sms-cm acpi/ec.c to 2.6.11.5
Date: Mon, 28 Mar 2005 23:55:56 +0100
Message-ID: <200503282355.59717.pjvenda@arrakis.dhis.org>
References: <423EF2EB.5030505@arrakis.dhis.org> <42485FE2.8040702@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart33710070.szUQnS0t6V";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <42485FE2.8040702-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart33710070.szUQnS0t6V
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 28 March 2005 20:49, Rich Townsend wrote:
> Pedro Venda wrote:
> > hi everyone,
> >
> > Since I'm still interested into using the sbs-cm DSDT patch from rich
> > townsend and the most recent release is for 2.6.10, refusing to apply to
> > 2.6.11.X, I changed it.
> >
> > here it is. rich: could you please take a look and, if it is ok, could
> > you just update your release?
>
> <snipped patch>
>
> Pedro --
>
> Thanks for the patch, which is now incorporated in the latest release
> (20050328) of the sbs-cm package. This release also includes a modified
> SMBus-CM driver, which should reduce mutex thrashing (read: less noisy
> debug output).

ok, thanks. So the patch is ok? what about the ec.c driver problems?

> FYI, It's doubtful whether I'm going to put that much work into
> furthering the sbs-cm stuff. From what a number of people have said, the
> HAL is the place to be implementing the Smart Battery support, and
> that's where I'm going to be investing most of my future effort.

I understand. I have a question though: without kernel drivers, how can the=
=20
HAL talk to smart batteries?

Also, if I apply some effort to port the kernel patch into other kernel=20
versions, could you please give it quick reviews and possibly update the=20
package? not by introducing features, but just keeping it working. That'll=
=20
imply some work from you on a less-than-montly basis, I predict, and only=20
while HAL isn't widespread enough... let's face it: few people are using it=
=20
these days, I guess.

any comments?

regards,
pedro venda.
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org

--nextPart33710070.szUQnS0t6V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCSIt/eRy7HWZxjWERAjljAKCNo78Var2TGaahNywe9B6aKYAeOACeLBlG
odd2wSxV931NuByphAP91uE=
=MjIj
-----END PGP SIGNATURE-----

--nextPart33710070.szUQnS0t6V--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
