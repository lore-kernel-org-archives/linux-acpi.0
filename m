From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: acpi on new gateway laptops
Date: 12 Dec 2003 18:01:07 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1071252067.1706.10.camel@darkstar.portugal>
References: <Pine.LNX.4.44.0312121109510.32380-100000@data.upl.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0312121109510.32380-100000-j0XSImJ06nG869pVMd/zofZ8FUJU4vz8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Casey Harkins <charkins-TFaeeA7fOO6Gwcnyzrk3/w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

I have:
cat /proc/acpi/embedded_controller/EC/info
gpe bit:                 0x06
ports:                   0x66, 0x62
use global lock:         no
but no kind of lines appears in dmesg.

On Fri, 2003-12-12 at 17:11, Casey Harkins wrote:
>=20
> Anybody?
>=20
> On Mon, 8 Dec 2003, Casey Harkins wrote:
> > Oops, after a bit more investigating I see that there is a Device(H_EC)
> > which appears to be my embedded controller. I also see there is a line =
in
> > my dmesg output, which appears after the "Region EmbeddedControl(3) has
> > no handler..." error messages, that says:
> >
> >      ACPI: Embedded Controller [H_EC] (gpe 29)
> >
> > So, Linux appears to be detecting my Embedded Controller after it tries=
 to
> > access the "Region EmbeddedControl(3)". Does this mean that the ecdt *i=
s*
> > being found, but not until after Linux tried to access it? Or does the
> > fact that it is detected not mean that the ecdt is being read?
> >
> > cat /proc/acpi/embedded_controller/H_EC/info:
> >    gpe bit:                 0x1d
> >    ports:                   0x66, 0x62
> >    use global lock:         no
> >
=20

--=20
S=E9rgio M B




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
