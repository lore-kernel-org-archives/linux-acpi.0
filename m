From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: PROBLEM: ACPI freezes 2.6.1 (acpi-20031203-2.6.1
	patched) on boot
Date: 26 Jan 2004 14:11:34 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1075126295.2942.8.camel@darkstar.portugal>
References: <m3oesx5wok.fsf@reason.gnu-hamburg>
	<20040122085958.GA1244@fuchi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040122085958.GA1244-5sK/Rx+du8M@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Sebastian Henschel <acpi-1rjuZeEg9oEb1SvskN2V4Q@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, greve-mXXj517/zsQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-01-22 at 08:59, Sebastian Henschel wrote:
> hi georg...
>=20
> * "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org> [2004-01-21 13:27 +0100]:
> >=20
> > FYI: below is my problem report about ACPI freezing my ASUS M2N on
> > boot with plain vanilla Linux 2.6.1.
> >=20
> > As a possible way of solving the problem I've tried the patch
> > acpi-20031203-2.6.1.diff.bz2 with date 09-Jan-2004 (have to admit the
> > version numbering isn't clear to me) I get a different error message
> >=20
> >  ACPI: IRQ9 SCI: Edge set to Level Trigger.
> >=20
> > However, this still appears to be the same problem.
>=20
> two things come to my mind:
>=20
> - disable Local- and IO-APIC. try "noapic" as boot parameter or even
>   disable it completely in .config file.
> - upgrade your bios, i think 0206 is the latest.

or try propose patch on=20
http://bugzilla.kernel.org/show_bug.cgi?id=3D1269

in this case Greve already try it with success on (
http://bugzilla.kernel.org/show_bug.cgi?id=3D1774 )

thanks=20

--=20
S=E9rgio M B




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
