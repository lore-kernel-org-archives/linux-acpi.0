From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Processor C states and USB problem
Date: Mon, 5 Jan 2004 17:06:12 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8E84E6C@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: mike-Z92qn3yYq0hWk0Htik3J/w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,
C3 is a kind of idle, it means deep power saving.
Actually, I observed the same symptom as you: USB devices caused many =
bus master activities, which make processor can't enter C3.
=20
Thanks,
Shaohua
> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of mike@it-loops.com
> Sent: 2004=C4=EA1=D4=C25=C8=D5 16:42
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] Processor C states and USB problem
>=20
> Recently I had problems with my network card and ACPI (see earlier =
posts
> for
> the problem and solution) so I thought I'd take a closer look at ACPI =
on
> this notebook (Acer Travelmate 800).
>=20
> Looking at the proc entries for the processor I saw the following.
>=20
> active state:            C3
> default state:           C1
> bus master activity:     80070020
> states:
>    C1:                  promotion[C2] demotion[--] latency[000]
> usage[00000010]
>    C2:                  promotion[C3] demotion[C1]
> latency[001]usage[01077887]
>   *C3:                  promotion[--] demotion[C2] latency[085]
> usage[00083507]
>=20
> This looked pretty normal to me, apart from the fact that the =
processor
> was
> spending a lot of time in C3 although the notebook was idle.
>=20
> Now I plugged in my USB mouse.
>=20
> cat /proc/acpi/processor/CPU0/power
> active state:            C2
> default state:           C1
> bus master activity:     ffffffff <---- USB is active
> states:
>    C1:                  promotion[C2] demotion[--] latency[000]
> usage[00000010]
>   *C2:                  promotion[C3] demotion[C1]
> latency[001]usage[00871647]
>    C3:                  promotion[--] demotion[C2] latency[085]
> usage[00077386]
>=20
> The processor never left the C2 state.
> After unplugging the mouse "bus master activity" showed normal values
> again.
>=20
> Now for my two questions:
>=20
> 1.) Is it normal for the notebook to spend so much time in C3, even if =
it
> is
> idle?
>=20
> 2.) Why is an USB device screwing up the bus master activity, =
resulting in
> the processor never leaving C2?
>=20
>=20
> /Michael
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for =
IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys =
admin.
> Click now! =
http://ads.osdn.com/?ad_id=3D1278&alloc_id=3D3371&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
