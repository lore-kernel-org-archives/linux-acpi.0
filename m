From: simon-Ji7FXtOmRLs@public.gmane.org (Simon Fowler)
Subject: Re: Re: DockApps
Date: Sat, 22 Jan 2005 01:22:51 +1100
Message-ID: <20050121142250.GC3945@himi.org>
References: <16880.8771.253591.739342@phoenix.squirrel.nl> <20050121101018.GB3945@himi.org> <m2hdlb7xem.fsf@phoenix.squirrel.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2hdlb7xem.fsf-KjnUIgV0B0bak1Ioo/c9IoRWq/SkRNHw@public.gmane.org>
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


--vEao7xgI/oilGqZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2005 at 01:57:05PM +0100, Johan Vromans wrote:
> simon-Ji7FXtOmRLs@public.gmane.org (Simon Fowler) writes:
> > If not, try hitting http://himi.org/wmacpi/ and trying it out - it
> > should work fine on any modern system (as long as the
> > /proc/acpi/battery/ interface is there
>=20
> I did, and I can't get it to work at all. I get an empty, zero-sized
> window. Could be my lack of suitable window manager, though.
>=20
Well, you should be able to run it even without wmaker, but I
personally haven't tested it . . .=20

> libdockapp 1.50 seems to be read protected, so I couldn't test the 2.1
> RC.
>=20
Thanks for that - fixed now.

> > - if I can get some docs on the new SBS interface
> > I'll gladly add code for handling it, though I can't test it
> > myself).
>=20
> I'll send you (via private e-mail, please do not ignore it ;-)) the
> detailed output of all associated /proc/files. I hope this helps.
>=20
Thanks - I'll hack something up basd on that, but I'd still like
some documentation ;-) Richard's response to my other email shows
why it's necessary.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8RA6QPlfmRRKmRwRAj4oAJ91TIhD69dMrswlAGyYjFapk3yMCACePBcn
AkVARfob4Y8KlZ4OIwmMcNM=
=YApS
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
