From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Date: 22 Jan 2004 18:45:30 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074797130.1585.19.camel@darkstar.portugal>
References: <m3hdyo2kce.fsf@reason.gnu-hamburg>
	<20040122140155.GC5194@hell.org.pl> <m3d69cj8hb.fsf@reason.gnu-hamburg>
	<1074790450.1585.4.camel@darkstar.portugal>
	<m3ad4fdi02.fsf@reason.gnu-hamburg>
	<1074792345.1581.8.camel@darkstar.portugal>
	<m3brov96ns.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m3brov96ns.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

well compile the kernel without any ACPI modules, compile all ACPI stuff
in the kernel.img .
Say Y to all that you used has modules (M) in kernel configuration (make
xconfig).

On Thu, 2004-01-22 at 18:31, Georg C. F. Greve wrote:
>  || On 22 Jan 2004 17:25:45 +0000
>  || S=E9rgio Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org> wrote:=20
>=20
>  smb> well ! good point.=20
>=20
> :)
>=20
>=20
>  smb> So and version with the kernel, do you compile in the kernel ?
>=20
> I'm, not sure what you are asking.
>=20
> The kernel version is 2.6.1.
>=20
> I've reproduced the problem with plain vanilla, ACPI version 20031002
> and also after applying the latest ACPI 20031203 patch, which has
> acpi4asus version 0.26.
>=20
> Regards,
> Georg
>=20
> --=20
> Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
> Free Software Foundation Europe	                 (http://fsfeurope.org)
> Brave GNU World	                           (http://brave-gnu-world.org)
--=20
S=E9rgio Monteiro Basto=20
Rua Fernando Pessoa n.=BA 226, 1 Dto=20
Vermoim=20
4470-290 Maia=20
Tel: 965508780
Email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
