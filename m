From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 13:41:37 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F12ECA0@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > Please tell me the contents of =
/proc/acpi/thermal_zone/THRM/trip_points.
>
> I have three thermal zones. The one related to CPU is:

Oops, sorry. To intimate with my rewritten naming and didn't expect more =
than one tz.

> /proc/acpi/thermal_zone/TZ1/trip_points
>=20
> critical (S5):           93 C
> passive:                 91 C: tc1=3D1 tc2=3D2 tsp=3D100 =
devices=3D0xc184c940
> active[0]:               78 C: devices=3D0xc18f1a40
> active[1]:               72 C: devices=3D0xc18f1b80
> active[2]:               67 C: devices=3D0xc18f1c80
> active[3]:               40 C: devices=3D0xc18f1d80

Ok, four trip points, four FAN "devices"/states, lowest one at 40 deg.=20
You told us that your lowest temperature is about 50 deg. Hence the last =
one
should be on and you don't see it =3D> something to investigate.

What hardware are you using?


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
