From: Fred Thiele <ferdy_news-Mmb7MZpHnFY@public.gmane.org>
Subject: Hardware information - what is needed [Toshiba L10]
Date: Tue, 12 Jul 2005 09:11:05 +0200
Message-ID: <20050712071105.GA14285@w0t4n.th0r.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
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
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello ML,

nobody has answered my previous mail yet and i fear nobody has an
answer what i can do. I really plan to get the AC/Battery
Information working on my Toshiba SatPro L10 within linux. Yesterday
I booted up windows in the hope to get additional hardware
information, or to know how the battery stuff is treated within
windows:

Microsoft Smart Battery
InstanceID: SMBUS\SMBBATT\7&277F0662&0&BATTERY0

Microsoft Smart Battery Subsystem
InstanceID: ACPI\ACPI0002\6&28CA2229&0

I guess the second one is the battery itself. Can anyone provide me
background information on what these things mean?=20

Another thing i found in the device manager is some information
called "energy capacity", this is in several hardware included:

PDCAP_D0_SUPPORTED
PDCAP_D3_SUPPORTED

Later on this stuff os used like this:

S0: D0
S1: n/a
S2: n/a
S3: D3
S4: D3
S5: D3

What is this meant to be, the sleep modes?

If anybody could point me to the right literature to understand this
better i'd appreciate that.=20

--=20
Best regards,

Fred Thiele=20

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC020JEBTrFk9r4jgRArUDAJwJMtwowR4ji6tALZA0XWaVKR2yWACffSId
sR88rGXpDmHbxXhK85CU8jU=
=eUW/
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
