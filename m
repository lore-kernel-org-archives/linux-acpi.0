From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [UPDATE RFC PATCH v2] ACPI / EC: Fix an order issue in
 ec_remove_handlers()
Date: Thu, 7 Jul 2016 20:46:55 +0900
Message-ID: <20160707114654.GA2915@tetsubishi>
References: <20160706141410.GA1430@tetsubishi>
 <e48b77b7af1e8269b0ff3fac6cbf37eb480ab722.1467866123.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58382 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbcGGLrQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Jul 2016 07:47:16 -0400
Content-Disposition: inline
In-Reply-To: <e48b77b7af1e8269b0ff3fac6cbf37eb480ab722.1467866123.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Nicholas <nkudriavtsev@gmail.com>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 07, 2016 at 12:37:10PM +0800, Lv Zheng wrote:
> (Updated to add v2 indicator)
>=20
> There is an order issue in ec_remove_handlers() that the functions invoked
> in it are not invoked in the reversed order of their appearance in
> ec_install_handlers(). This existing issue has been triggered by the
> following commit:
>   Commit: dcf15cbded656a12335bc4151f3f75f10080a375
>   Subject: ACPI / EC: Fix a boot EC regresion by restoring boot EC
> The commit invokes ec_remove_handlers() during runtime, thus uncovers this
> issue. This patch fixes this regression.
>=20
> Fixes: dcf15cbded65 ("ACPI / EC: Fix a boot EC regresion by restoring boo=
t EC")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D102421
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Nicholas <nkudriavtsev@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Nicholas <nkudriavtsev@gmail.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>

Tested-by: Wolfram Sang <wsa@the-dreams.de>

The status infos are back to normal and the EC error reports are gone
=66rom the log. Looks good! Thanks for the quick fix.

   Wolfram


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfkEuAAoJEBQN5MwUoCm2qtgP/iIqam3gD6dr/rlA7zfTDQjB
Dl4Y8U7jlEorQbY4SnQReBOs6hMnfJ9vGLrM8TYcyc+BsbYREP+yO27MOQ7hI/jN
DE/TYLffec6hNWuzr6ABoLAxULafsW8cAxWX/Bw/6up+a8bHdbJcT9F18T3WWNpg
JHyhuUBDvnzxamNWVt814dd/O6IjKzbnsOXevTec7smFacytfkQtHZci7qW6ql99
ZB7JRSqU8a1cTix7jV/K+8u0HnhAdtQXYw8i7c3m88/n4WL1EFaJv2j4OjZMNGHn
O3IbBMt+2WHp9rRdKNxZaQto3vcfCzZujg4Mz2r/ovtXuZGt9jgS8xnbHn1v/KB8
6zdXAZp3fBZhHKWRmcy26YiySPPHZrbQyRS4qZbaWAwyZFILt2Ydpg4zXmQLb9ua
jkkQme5P5v5ktOz+SNoSbwtyAy/b6YYfc0ugeaeKp7WOJC5RS/IMRqlHfdIwIyC7
J2+j3V91CheAYjO+vGArTPCZJ5uMr6QqFVyfzwvyIC/zjE4QWg1MCRzGMvcXRsP8
DJ7hhbakK2g+rbUOjdJkyrbhlzgUJKiuKMJmLQkgU3MUhuKDVfrdfWhMEnVCqVVZ
JWnZILCY+0pqB/ZsZtYWCSitRDkxd80Jh+X9A8iEHoj3vosxo7BNjEc86Jz0HbeA
gstT+j7ydOrMAuVnC/ji
=XdsF
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
