From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: 2.6.3 + D600 + battery state + BUG?? [Was] Battery status sometimes missing
Date: Thu, 19 Feb 2004 17:55:19 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C69DC@wdmyexch02.my.asia.wdc.com>
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


Environment :
RH9
Kernel 2.6.3+laptop_mode+acpi_20040211
+patch http://bugzilla.kernel.org/show_bug.cgi?id=3D1791


May also occur in these listed kernels (all of them acpi patched)
May (cos I didn't really try out the 'steps to reproduce' below
but the errors are definately there.

2.6.2=20
2.6.3-rc1
2.6.3-rc2
2.6.3-rc3
2.6.2-rc2-mm1


Symptom :
Cannot read battery status from /proc/acpi/battery/BAT0/state
Sometimes OK, sometimes Error : Unable to read status

Kernel Logs:
> With Debug Statements
>=20
> acpi_battery-0207 [173] acpi_battery_get_statu: Error evaluating _BST
> dswload-0279: *** Error: Looking up [BST0] in namespace,=20
> AE_ALREADY_EXISTS
> psparse-0588 [184] ps_parse_loop         : During name lookup/catalog,
> AE_ALREADY_EXISTS
> psparse-1120: *** Error: Method execution failed=20
> [\_SB_.BAT0._BST] (Node
> c155d8a8), AE_ALREADY_EXISTS

I find that there _may_ be a race condition or simultaneous access issue
at hand. (read from someone's post on the net and tried it out)

Steps to reproduce:
1st scenerio
1. If I were to leave gkrellm's batt stat on (only) it's ok. (1 sec =
updates)
2. Put in Gnome's Battery monitor together with Gkrellm.. After a while =
gets
the
   AE_ALREADY_EXIST error

2nd scenerio
1. do watch -n1 cat /proc/acpi/battery/BAT0/state
2. Repeat Step #1 x 10 times or more??
3. KaBoom!! Like nearly instantenous (wrong spelling)

So.. Is this a bug or a feature??
How can I trace it??


Note : I still see this soometimes
osl-0886[80] os_wait_semaphore:Failed to acquire =
semaphore[dffac580|1|0],
AE_TIME

Thanks..


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
