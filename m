From: John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org>
Subject: [john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org: Re: Thinkpad R40 freezes after swsusp resume]
Date: Wed, 16 Feb 2005 14:59:40 -0500
Message-ID: <20050216195940.GA32423@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
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


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If Pavel Machek's suggestion of disabling acpi alleviates my freeze
problem (which it has so far), I'll need some help debugging and
correcting the problem, so I can get swsusp and ACPI coexisting happily
on my Thinkpad R40.

Does anyone here on the ACPI list have some logical next steps for me to
test?

Thanks.

----- Forwarded message from John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org> -----

Date: 	Tue, 15 Feb 2005 08:56:30 -0500
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
=46rom: John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Thinkpad R40 freezes after swsusp resume
Cc: John M Flinchbaugh <john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org>, linux-thinkpad-l7BEYHA5S10i5T99jlK1Sh2eb7JE58TQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-Bogosity: Ham, tests=3Dbogofilter, spamicity=3D0.000000, version=3D0.93.5

On Fri, Feb 11, 2005 at 07:32:41PM +0100, Pavel Machek wrote:
> > > Try also acpi=3Doff.

> > i was hoping for a test that's a bit more granular.  might it be
> > possible to disable suspect bits of the acpi code instead of all=20
> > of it?
> > i'm open to applying and testing patches.

> Well, you'd have to write that code, I'd guess.
> And I do not think you can really turn off thermal managment once=20
> you
> enter ACPI mode.

I've gotten 2.6.11-rc4 to freeze after a swsusp, so I'm testing acpi=3Doff
now.

As Murphy's Law would have it, I usually get these lockups at=20
inopportune times when I really don't want to have to punch the power=20
button, like when I'm in a hurry trying to find something or during
long-running network backups.  It also does it when sitting idle, so
this isn't a rule.

I've run most of a backup from an NFS mount to the local drive (for
about 10 minutes), stopped it, swsusp, ran another backup, and it's
looking fine so far.

To be sure that it's not going to freeze, I'd almost have to let it go
for a week, though, because sometimes I had just gotten lucky and not
seen the issue for upto 4 days at a time.

Assuming disabling ACPI causes my trouble to go away, what's my next
step in debugging this issue?  I'd hate to just leave it at "Don't use
ACPI."

Thanks for your time.
--=20
John M Flinchbaugh
john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org



----- End forwarded message -----

--=20
John M Flinchbaugh
john-sQWoH1wgGpLQT0dZR+AlfA@public.gmane.org

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCE6YsCGPRljI8080RAgQkAJ9o4wToDeM2GQTeby4mw0c6xJer+gCeJHKJ
vtDzud754DlIN1+R8s6siqs=
=wUcz
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
