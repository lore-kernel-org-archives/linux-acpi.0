From: simon-Ji7FXtOmRLs@public.gmane.org (Simon Fowler)
Subject: Re: Re: Smart Battery System driver
Date: Fri, 21 Jan 2005 21:06:19 +1100
Message-ID: <20050121100618.GA3945@himi.org>
References: <F760B14C9561B941B89469F59BA3A84708CBB988@orsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A84708CBB988-sBd4vmA9Se6krb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 20, 2005 at 02:04:16PM -0800, Grover, Andrew wrote:
> > >From a distribution point of view, it would be nice to:
> >=20
> > a) Not have to rewrite every acpi battery applet to use the sbs
> > interface directly, and
> > b) Not have to have a database of hardware that has a smart battery
> >=20
> > Is there any way to provide the legacy interface even if standard
> > battery support is built in, or alternatively some way of probing the
> > system to determine which battery module should be loaded?
>=20
> Hasn't anyone written a libpower yet? Battery applets shouldn't be
> groveling around proc, they should be making library calls. OK all
> existing apps would need to be changed (probably a big code reduction
> actually) but this would let the library look for both CM and sbs
> interfaces (which should not pretend to be a CMBatt of course) and
> handle them.
>=20
=46rom my perspective (I'm the current maintainer of the wmacpi
battery monitor dockapp), all this would be much much easier if
there was some documentation of what exactly all the files in
/proc/acpi /mean/. I've had to root around in the kernel source to
work out what some of it does.=20

I've got the beginnings of an acpi reporting library in wmacpi,
which I could fill out very easily if there was just some
documentation to base the code on . . .

> Bonus points for also supporting APM through this interface...
>=20
If I had a laptop that supported APM I'd happily do that ;-)

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB8NQaQPlfmRRKmRwRAiIYAJ9kwZQUefR9L8MkqpBY3N4Jkoqz3ACaApmR
oxAIhFJicqweEEGczIaieas=
=ngpp
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
