From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: RE: Re: ACPI source patches updated (20021101)
Date: 05 Nov 2002 23:57:50 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036540674.1411.12.camel@darkstar.portugal>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4A5@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A4A5-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "'earny=euM3SP4ZHrg@public.gmane.org'" <earny-euM3SP4ZHrg@public.gmane.org>, John Summerfield <summer-bdq14YP6qtSeVB85EesmETSf8X3wrgjD@public.gmane.org>, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2002-11-04 at 17:53, Grover, Andrew wrote:
> > From: Ernst Herzberg [mailto:earny-euM3SP4ZHrg@public.gmane.org]=20
> > With this patch the kernel will boot with debug messages enabled.
> >=20
> > <Earny>
> > -       acpi_set_debug(ACPI_DEBUG_HIGH);
> > +       acpi_set_debug(ACPI_DEBUG_LOW);
>=20
> Oops. That shouldn't have slipped in. Thanks, Ernst. I will upload an
> updated 2.4 patch to sourceforge right away.
>=20
> Regards -- Andy

Hi everyone
Andy, will this patch resolve the problem reported, in boot with debug
messages enabled ?

you will replace patch or you will add this small patch in one extra
file ?
I vote in second choice, because otherwise no one know if have the
correct version or not, and every email reporting problems on boot , we
will have to ask if have this patch applied=20


thanks=20
S=E9rgio Basto



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
