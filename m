From: Parrenin =?ISO-8859-1?Q?Fr=E9d=E9ric?= <parrenin-6cgPr1GgFWewRP7jdkWmCvzYAJ16yAcp@public.gmane.org>
Subject: Re: ACPI on VAIO GRX516 doesn't work with klaptop
Date: 27 Dec 2002 14:42:19 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1040996539.2211.0.camel@lgge-pc176.obs.ujf-grenoble.fr>
References: <200212251248.gBPCm0t13311@cnes.fr>
Reply-To: Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200212251248.gBPCm0t13311-9uq6Vi6nF6Y@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Patrick Chemla <patrick.chemla-GILi49z+0PNQFI55V6+gNQ@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

It is more a klaptop issue.

Regards.

	Frederic


Le mer 25/12/2002 =E0 13:09, Patrick Chemla a =E9crit :
>  =20
> Hi,
> =20
> I have a VAIO PCG-GRX516SP, latest SONY laptop, with P4 2Ghz, 512Mb mem=
ory,
> 60Gb HD, .. A really fine laptop.
> =20
> I first installed a RedHat 8.0 last distribution, updated with latest
> patches on kernel 2.4.18-8-0-18.
> =20
> I downloaded a 2.4.20 kernel from kernel.org, updated with last acpi pa=
tches
> acpi-20021202-2.4.20.diff
> =20
> I build and rebuild my kernel with/out ACPI, with/out APM.
> =20
> Latest status is that /proc/acpi directory contains all info and events=
,
> working well when I plug in/out the AC adapter, when I let the battery
> discharged, I can see battery status, but KLaptopdaemon says that ACPI =
seems
> to be partially installed, info not available, no battery.
> =20
> It seems that the problem doesn't come from ACPI drivers themselves, bu=
t
> from Kalptopdaemon. I have applied some patches on Klaptop that give th=
e
> right directory path (/proc/acpi instead of /proc/sys/acpi). Doesn't wo=
rk.=20
> =20
> Do you have any idea ?
> =20
> Thanks for help.
> =20
>=20
> Patrick Chemla
> =20



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
