From: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Subject: Re: Help with thermal
Date: Mon, 16 Aug 2004 09:32:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040816073231.GB2861@fuchi>
References: <1092613221.10652.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1092613221.10652.9.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello jerry..

* Jerry DeLisle <jvdelisle-H+0wwilmMs3R7s880joybQ@public.gmane.org> [2004-08-16 09:14 +0200]:
> I have acpid running.
>=20
> /proc/acpi is:
>=20
> [root@quantum acpi]# ls
> ac_adapter  battery  embedded_controller  fan             processor
> alarm       button   event                info            sleep
> asus        dsdt     fadt                 power_resource  thermal_zone
>=20
> The thermal_zone directory is empty.
>=20
> How do I read temperatures?  I have been reading the howto's but I am
> missing something here.  Thermal is compiled into kernel, not a module.=
=20

it might be that your DSDT does not define a thermal_zone. you can send
it to the list if you like to, or better send a link to it. check
http://acpi.sf.net/dsdt/index.php to learn how to extract that table.
or your DSDT is faulty which should be shown in the output of "dmesg".
are there any AE_* messages or similar errors which point to ACPI?
or the ACPI implementation of L=D1=96nux is at fault.
which machine are you running, btw?


> Also I do not find acpi client.  The howto mentions the comamnd:
>=20
> 	acpi -v
>=20
> Where do I find this?

that depends on your distribution. on Debian, just "apt-get install
acpi".

cheers,
 sebastian
--=20
::: .O.
::: ..O
::: OOO
::: lynx -source http://www.kodeaffe.de/shensche.pub | gpg --import

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIGMPreHfL3pi+bQRAvSOAJ0axUjqN8szQI3WRfbRx7r2Op1v3gCfWCPT
XBAilxbY/1DCsm/ePwF6ZeI=
=r6wL
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
