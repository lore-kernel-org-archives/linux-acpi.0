From: mizu <michal-VaXaUECoPuY@public.gmane.org>
Subject: Re: [SOLVED] TM632 and S3. Network after wakeup. (kernel 2.6.10-rc3-mm1)
Date: Tue, 4 Jan 2005 19:55:26 +0100
Message-ID: <20050104185526.GA18862@icmza.sk>
References: <20041216091137.GB5605@alfa.intrak.sk> <200412162130.27395.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200412162130.27395.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yeah !

  -laptop Acer TM632=20
  -with vanilla kernel 2.6.10
  -with GNU nvidia driver.

  S3 state (sleep and wakeup) works perfectly.

  I think, it looks like we have full ACPI support.


  Good job, thanks !


  			mizu

		=09
On Thu, Dec 16, 2004 at 09:30:27PM +0100, Stefan D?singer wrote:
> >    Resolver did not work, i guess.
> >
> >    When i try to ping to another site: Uknown host.
> >
> >    But when i try to ping with IP address, it is all right.
> Looks like you lost your network configuration. This is not really a bug,=
 as=20
> you might have moved your computer somewhere else while it was suspended.
>=20
> Try to restart your network, e.g. /etc/init.d/network restart, depending =
on=20
> your disto. The ifplugd daemon could take care of this for you. If you mo=
ve=20
> between different WLANs you may want to use waproamd too.
>=20
> Cheers,
> Stefan

--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB2uae9kFXwDL4DRkRAtKqAKCOc9ch1KwzoDvITgrEquSv9vRNlwCgq8el
+s7bW/CCunCBMvjzR2+/2Vw=
=ejkg
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
