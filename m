From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Re: PROBLEM: ACPI freezes 2.6.1 on boot
Date: 21 Jan 2004 23:31:43 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1074727903.3667.49.camel@darkstar.portugal>
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
	<m3d69dhukz.fsf@reason.gnu-hamburg>
	<1074721887.3672.12.camel@darkstar.portugal>
	<m34qupdj94.fsf@reason.gnu-hamburg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <m34qupdj94.fsf-glUV91rXKAHWIjgkaejU9x2eb7JE58TQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

So you are another APIC victim :)

The funny thing, is that I thought that because,=20
Linus has write :
"It's entirely possible that the SCI is just horribly broken, and can't
be level-triggered" about "ACPI: IRQ 9 was Edge Triggered, setting to
Level Triggerd".

And thinking, can be true ? that, if SCI can't be level-triggered (like
my laptop and yours), kernel with APIC (loapic or smp) options will hang
on boot !

On Wed, 2004-01-21 at 22:33, Georg C. F. Greve wrote:
>  || On 21 Jan 2004 21:51:27 +0000
>  || S=E9rgio Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org> wrote:=20
>=20
>  smb> And disable apic (lopic and io-pic) options from kernel compilation=
 ?
>=20
> Funny -- we seemed to have had the same idea.=20
>=20
> Yes, this makes it boot (see my other mail).
>=20
> Regards,
> Georg
>=20
> --=20
> Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
> Free Software Foundation Europe	                 (http://fsfeurope.org)
> Brave GNU World	                           (http://brave-gnu-world.org)
--=20
S=E9rgio M B




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
