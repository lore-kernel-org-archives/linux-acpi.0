From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: 2.6.3 + D600 + battery state + BUG?? [Was] Battery status sometimes missing
Date: Fri, 27 Feb 2004 12:05:54 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6CA2@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
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
To: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Yu, Luming [mailto:luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Friday, February 27, 2004 11:20 AM
> To: Ow Mun Heng; Acpi-List (E-mail)
> Subject: RE: [ACPI] 2.6.3 + D600 + battery state + BUG?? [Was] Battery
> status sometimes missing
>=20
>=20
> > Note : I still see this soometimes
> > osl-0886[80] os_wait_semaphore:Failed to acquire=20
> > semaphore[dffac580|1|0],
> > AE_TIME
>=20
> Hmm, this is unusual inforation. I'm curious about the semaphore which
> is timeout to
> be acquired by whom?  Would you help with add dump_stack just before
> that debug
> message? This is a interesting bug. :)
>=20
> I'm not sure, but maybe the following two patch can help, only because
> they aim  to
>  global lock/mutex issue.
> 1.) http://bugme.osdl.org/show_bug.cgi?id=3D1781#c18
> 2.) http://bugme.osdl.org/show_bug.cgi?id=3D1669#c6

Can you tell me how to add the dump_stack??

in /proc/acpi/debug_layer ??? how to do it?? Echo what??


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
