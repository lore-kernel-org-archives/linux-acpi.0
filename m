From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Re: [PATCH] IRQ params patch#4
Date: 19 Jul 2003 23:47:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1058654828.1602.2.camel@darkstar.portugal>
References: <200307151142.12738.adq_dvb@lidskialf.net>
	<bfb7kv$oas$1@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <bfb7kv$oas$1@main.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rob North <tzwvgwv2001-O/bDAPVd7B0N+BqQ9rBEUg@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

me too,no warnings, seems work on kernel.2.4.22-pre7 + acpi 20030714

thanks=20


On Sat, 2003-07-19 at 11:49, Rob North wrote:
> Andrew de Quincey wrote:
> > OK, patch#3 is way too strict... thought a bit more about it, and I sup=
pose=20
> > the BIOS not allocating some devices an IRQ is actually OK....
> >=20
> > Anyway, patch#4 now just warns the user if an attempt to set an IRQ res=
ults in=20
> > a different IRQ than expected, and attempts to abort ACPI irq routing.=20
> > Unfortunately, it isn't able to undo the changes it has made to the rou=
ting=20
> > as it would have to call the _SRS method to do it... and its just found=
 out=20
> > that that is buggy. So at the moment it probably won't be able to=20
> > automatically "fix" devices already programmed when dropping back to a=20
> > different method (it can't on my board). Sigh.
> >=20
> > Anyway, the warning should at least help find which boards have bad ACP=
I IRQ=20
> > routing.
> >=20
>=20
> I've applied this patch to 2.4.22-pre3-ac1. (Needed to patch some of it=20
> by hand)
> It seems to work for my Asus A7N8X Deluxe. I've only checked that all=20
> drivers succesfully connect to devices. I have not checked wether all=20
> the devices work yet.
>=20
> Many thanks
> 	-Rob.
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: VM Ware
> With VMware you can run multiple operating systems on a single machine.
> WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
> same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
