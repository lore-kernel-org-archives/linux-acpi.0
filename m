From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Re: Centrino speedstep
Date: Sun, 2 Jan 2005 15:23:15 +0100
Message-ID: <20050102142315.GA2350@dominikbrodowski.de>
References: <20041229181834.GA19199@poupinou.org> <41D42E88.5080800@mega.ist.utl.pt> <m2llbfk931.fsf@phoenix.squirrel.nl> <41D43A9F.5050507@mega.ist.utl.pt> <16852.15668.315630.700537@phoenix.squirrel.nl> <41D4AA9F.7080200@mega.ist.utl.pt> <20041231082524.GA8312@dominikbrodowski.de> <m2652hh17w.fsf@phoenix.squirrel.nl> <20050102110826.GA14862@dominikbrodowski.de> <20050102134626.GA25417@hell.org.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050102134626.GA25417-DETuoxkZsSqrDJvtcaxF/A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 02, 2005 at 02:46:26PM +0100, Karol Kozimor wrote:
> Thus wrote Dominik Brodowski:
> > [**] first value: Sleep State; second value: Deep Sleep State; third va=
lue: Deeper Sleep State.
>=20
> Hmm, I always thought C3 implies at least Deep Sleep [*], at least for P4=
-M.
> Isn't that true for P-M?
>=20
> [*] It is, AFAIR, possible to make C3 transition invoke Deeper Sleep.

Intel x86 and x86_64 Processors[15]

C1      -       AutoHALT Power-Down state

C2      -       Stop-Grant state

C3      -       Sleep State

                Deep Sleep State (normally used)

                Deeper Sleep State (alternatively used, or available in
                                    addition to Deep Sleep State)

[15] Data collected from Intel(R) 440BX AGPset: 82443BX Host
Bridge/Controller Datasheet, Order Nr. 290633, rev. 01, April 1998,
p. 4-31; Intel(R) 82801DBM I/O Controller Hub 4 Mobile (ICH4-M)
Datasheet, Order Nr. 252337, rev. 01, January 2003, p. 362; Intel(R)
Pentium(R) M Processor Datasheet, Order Nr. 252612, rev. 02, June
2003, pp. 11; and Intel(R) 855GM/855GME Chipset Graphics and Memory
Controller Hub (GMCH) Datasheet, Order Nr. 252615, rev. 02, September
2003, p. 170.

:-)

	Dominik

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB2APTZ8MDCHJbN8YRAvF3AKCCAXQ9yxLmO3HSTYsZ6E/QasepMACghxzm
x8O8OXRR6o68f1d8sUrbZ/E=
=D+S9
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
