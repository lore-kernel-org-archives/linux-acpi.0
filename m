From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv3 08/13] Documentation/ABI: Add node performance
 attributes
Date: Mon, 14 Jan 2019 00:10:12 +0100
Message-ID: <20190113231012.GD18710@amd>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-9-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109174341.19818-9-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-09 10:43:36, Keith Busch wrote:
> Add descriptions for memory class initiator performance access attributes.
>=20

> +What:		/sys/devices/system/node/nodeX/classY/read_latency
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		This node's read latency in nanosecondss available to memory
> +		initiators in nodes found in this class's initiators_nodelist.
> +
> +What:		/sys/devices/system/node/nodeX/classY/write_bandwidth
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		This node's write bandwidth in MB/s available to memory
> +		initiators in nodes found in this class's initiators_nodelist.
> +
> +What:		/sys/devices/system/node/nodeX/classY/write_latency
> +Date:		December 2018
> +Contact:	Keith Busch <keith.busch@intel.com>
> +Description:
> +		This node's write latency in nanosecondss available to memory
> +		initiators in nodes found in this class's
> initiators_nodelist.

"nanosecondss", twice.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlw7xVQACgkQMOfwapXb+vKXGgCfcEUziEucdCLurHcSo0hJzfJy
bPEAmwaIAoUO698IlY0VU3WeRzDeafDq
=fjA3
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
