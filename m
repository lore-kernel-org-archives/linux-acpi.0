From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: acpi: broken suspend to RAM with v4.7-rc1
Date: Fri, 10 Jun 2016 23:32:10 +0300
Message-ID: <20160610203210.GA2262@nest>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend to RAM.
Laptop doesn't finish suspend to RAM process (disks are off, but WiFi
and Power LEDs are still on). The only way to get it out of this
state, is to turn the power off.

I've bisected the issue to commit 66b1ed5aa8dd25
[ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for acpi_h=
w_write()].

If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to RAM is
working again.

The cause of this problem is that after this commit write to PM1A Control B=
lock
(16-bit register) is done using two 8-bit writes. If I force this write
to be 16-bit, then all is working as before.

To get it working 'access_width' for PM1A Control Block needs to be 2 (16-b=
it), but it's=20
1 (8-bit).

The root of the problem seems to be not the commit 66b1ed5aa8dd25 itself, b=
ut the ACPI
tables in BIOS where wrong access_width comes from. I fixed problem in FACP=
 table,
put it in initrd to override FACP table from BIOS. This fixed the issue,
suspend to RAM is working now again.

But I'm not sure whether is this proper fix for this problem.
Is there any place in the kernel, where such ACPI quirks are placed?


--=20
Best regards,
Andrey Skvortsov



--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXWyPKAAoJEAF8y6L1SLCtmfoP/1FEo0EJzNCOLvQXhnVq5gXk
NuBC6rJddAA176BalI3+lxj4WOpT/LJpQgnGvheL/lnxqEzhAZu8wbAlVMXHkoVD
8++Tx+QfamfuVrk0Wh+/GKpgfIuydf0HXfnUxkd8V+y2hlRAy8j2CNyI/71Pyc/t
ai3/I3kd3YFSlXkWdNmXbIo+PR4LK9xGOsPZeerUbtJmsqWoSvhHSrX13e3RjL89
/jv538lefWEgpEKk4d8oJYuHtEgh6IFCspeVa1a//KyiPBg8zA6zt/R4i8FOgblF
9mXwxQiKc3fzejs3TzrOReJ1KTNlYdLnDFMZ9M9Yr5Iv6fGnkNJnLhw03nyzsP20
Dsqx471w6ruOVve6DPcmnI0WZW1tNAScrlD6CuGhrxZVTyfTrf/5UEXciJRvP9iE
o/g+O14TjlQ6+SpEoEm5Cqg+He5zSO0+vDukNIQ0Dg9TmA0dGCzq5ebp4yUnV9AJ
vMl/xPpzjZvu3/OZtDVWjmSg1PT5LJFYlGC1iNQ3Qw/NKn5v3UlGecBz9kIY7rgT
kJ99v842gKfxkobyWtciChRFHxvkRRrfXOc5KX3+KnAXsO29Es3XozmRBmjPcqwN
gu7a48Ob6nhPdHD90PRlBf074cxx8bjdSZFN/zQuJ4W/OXryy7TjamP4a7mcVDLV
uuTloX/K0HX3nwS2Of9+
=l+eI
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
