From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: patched sms-cm acpi/ec.c to 2.6.11.5
Date: Wed, 23 Mar 2005 17:39:46 +0000
Message-ID: <200503231739.56592.pjvenda@arrakis.dhis.org>
References: <423EF2EB.5030505@arrakis.dhis.org> <4241A77B.1070807@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1522592.DfGWAkpdVs";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
In-Reply-To: <4241A77B.1070807-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
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
Cc: =?iso-8859-1?q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart1522592.DfGWAkpdVs
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 23 March 2005 17:29, Rich Townsend wrote:
> Hi Pedro --
>
> Sorry I didn't respond sooner; I've been very busy with my job. I'll
> check through this when I get a chance, and roll it into my sbs-cm stuff
> if it looks OK.

hello rich,

take your time. we're all doing what we can.

it does NOT seem ok. after some more tests with the patch, I found out that=
=20
francois was right about most of the problems:
* timeout on boot, just after the boot loader. this is very confusing to me=
=2E..
* when I plug in the battery, it takes ages to show information about it...=
=20
more than 1 minute.
* about the usb problems, apparently I wasn't affected.

could you please tip us about what could be causing these delays? especiall=
y=20
the boot delay... it really puzzles my mind.

regards,
pedro venda.
=2D-=20

Pedro Jo=E3o Lopes Venda
email: pjvenda < at > arrakis.dhis.org
http://arrakis.dhis.org

--nextPart1522592.DfGWAkpdVs
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCQanseRy7HWZxjWERAjFGAJ93INuH+MKxXHUCEyxWJRsUhjxEQgCgkGty
JB4MTHP4CDQX1k4uLDL+yDI=
=AosQ
-----END PGP SIGNATURE-----

--nextPart1522592.DfGWAkpdVs--


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
