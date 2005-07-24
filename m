From: Nico Schottelius <nico-linux-acpi-xuaVFQXs+5hIG4jRRZ66WA@public.gmane.org>
Subject: S3/S2 Problems
Date: Mon, 25 Jul 2005 01:47:42 +0200
Message-ID: <20050724234742.GA18565@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Moin!

echo -n 2 > /proc/acpi/sleep
-> present with the nice ascii printout that it sleeps, but
   it awakes immeditally.
echo -n 3 > /proc/acpi/sleep
-> works partly. System sleeps. But:
   --> After first sleep, everything is ok.
   --> After second sleep, the console is broken
       (many coloured blocks)
       X is still ok.
   --> After third and every following sleep:
      console broken (grey/coloured blocks)
      X broken (everything seems to be printed doubled like
      ll)

System:
   Compaq EVO N400C notebook
   Linux 2.6.12.3

Btw,
   o is there any tool to do sleep / a nice frontend to acpi
     for the console
   o where can I find the specification of ACPI sleep states?


Sincerly,

Nico

--=20
Latest project: cinit (http://linux.schottelius.org/cinit)
Open Source nutures open minds and free, creative developers.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQuQonbOTBMvCUbrlAQLM3Q//YRnzHApPXVFliU4HPxtBBVr3XwgQfTDU
LyYt0V7R4+nH8p/cQj9d5+fz4okPZr/TQDk254BPU+3IumJ7GuAR2+CWdzVIlFTp
cBk8gnkuJce5fzRGCk1lp7ZpwKCJgUBwOTNHgwrQ+LIqQAz3K0bQVLAkvtwY/7YE
xIfuW8j8tGMH76c2+ebqIAbSuvlJRyTxin+C2JU4GKapotFryysfw4FMiLB1bvDC
jG1n5Igk7CvI6AcRZXHU8KG0sbz/T1xnAIFtLMHnYwQuf9sSvZQggE5xasGwS1C/
6sZm/UTKfHGW++hzIutQtsllAJxncIDb2KfvteGkS13uuwvhTCIXxYpQaSz2ltzg
54/MJmCIc5lYCac2siDht7SVRkHB+zWoJua2lrKX0qXQAK8hy+vXBKXpjC2zec1I
s6QkOeEh2uJCiDBYcWWHSv5dY2z4+dtaA4c4gEx+d3HAABjwwVW3RTaJs0h9639K
MyqESGjQbwyTUQagohRUcHY0jMaGOUtQQDrwTKT/2RiSGZQ4Hin42qiccQzUjthj
9A9vbk6ekyK0T+xLluAgK+91bL7R7v40qv2/w3Hs6hyGx+qwMDX6hpf51nsPdNsd
DckzbwNoVYKYNf5FHemKG5K8BVC7LcsA2XyVPL6TC4p6vRzIw2nx7R1aA2HxB3kN
TQK9pSj92qA=
=IM3/
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
