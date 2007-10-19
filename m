From: Zan Lynx <zlynx@acm.org>
Subject: Re: 2.6.23-rc8-mm2 ACPI Battery Info in /sys but not /proc/acpi
Date: Fri, 19 Oct 2007 13:53:24 -0600
Message-ID: <1192823604.7460.3.camel@localhost>
References: <4718D46B.2070508@jbandy.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nFcjmGMQ1m84vDPUxMRa"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S936898AbXJSTyf@vger.kernel.org>
In-Reply-To: <4718D46B.2070508@jbandy.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Bandy <cbandy@jbandy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-acpi@vger.kernel.org


--=-nFcjmGMQ1m84vDPUxMRa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-10-19 at 11:59 -0400, Chris Bandy wrote:
> I had this same problem, but found that it was because I turned off the
> newly deprecated CONFIG_ACPI_PROCFS.

This was the problem.  Thank you.

What confused me was that *only* the battery information seemed to be
missing.  If all the ACPI info in /proc had been missing I would have
suspected something like this right away.
--=20
Zan Lynx <zlynx@acm.org>

--=-nFcjmGMQ1m84vDPUxMRa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBHGQs0G8fHaOLTWwgRAjRHAJ40RxSxm2ZHBKalW/nanCEHHpXq4QCgpPkq
+SvGt2RBtqRzCZgzeDx+MXY=
=z5zw
-----END PGP SIGNATURE-----

--=-nFcjmGMQ1m84vDPUxMRa--
