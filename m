From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 3/4] i2c: i801: Do not create iTCO watchdog when WDAT
 table exists
Date: Thu, 22 Sep 2016 19:47:00 +0200
Message-ID: <20160922174700.GB1861@katana>
References: <20160920123054.195021-1-mika.westerberg@linux.intel.com>
 <20160920123054.195021-4-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160920123054.195021-4-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, Jean Delvare <jdelvare@suse.com>, Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>, Zha Qipeng <qipeng.zha@intel.com>, Darren Hart <dvhart@infradead.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2016 at 03:30:53PM +0300, Mika Westerberg wrote:
> ACPI WDAT table is the preferred way to use hardware watchdog over the
> native iTCO_wdt. Windows only uses this table for its hardware watchdog
> implementation so we should be relatively safe to trust it has been
> validated by OEMs
>=20
> Prevent iTCO watchdog creation if we detect that there is ACPI WDAT table.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5BkUAAoJEBQN5MwUoCm2PvAP/Rd68mAnochXHwsElLbv17jB
wlSUiQgy7nxfUYgJef10jHlMxBjI8Ig9/8bt5tE0m/hByjDUa0zN8Wfe3xYfpyIp
opGTbXRLsWyPSJid87j6pLdXmLU9s6tkJtdoXTLFI1ppUWZ2EPVdhsX8igOyDBwl
K9IVhf41ms4e4Dh/iKr3jX+E/cPypSyTBs+YA35Gz/xaZCY/oKhD6cIW5g56Wy7D
9xYUdBPU2x5MQMDUOTP/2Om9dawUPd3uD7r/M6misuC3MhdzxNrUq8BtUIL+/IHM
K70n9VoM4XlDekw8GPQ3m0RA8f+J4hSGmcLtjIJP7iXE5DrThsu0LNUeFrwTZ37N
aWHsLfNPkhF1krYaGx07LxDFEBIue6Nh+7ArV3Sj8UMoRV4OL9TPbWs5V4Nl7my6
u/2RFCasl+WNa7HOBDyGJPgeWl9eio3md7TzkHZrsjyADgNWHxOi1SlQ/IyoVAYb
JzJofj01YhxsdCAwmfFrLKp9tHIkrxhQO/gownMLVgNkjKh7rpp/l3ZpdyBAikU+
DCcpRM5ZKAh6LRzimSIi/GYBsgVV2UbCgawR/ZvJGKvjOWaFLRi59gwawN8/WzDZ
fViykhOUs+rJdfoYUelg3S13LU5OpOjkZIsPyCg/Wxeis/t/M3s0VsGY4eXzwDiO
sNKNUFBX0JxvsRG3ky86
=NNhZ
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
