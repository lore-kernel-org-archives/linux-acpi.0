From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: 2.6.3-rc3 + D600 + battery status missing sometimes..
Date: Mon, 16 Feb 2004 16:50:30 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C66CA@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Just filled a bug or rather, added my own info on the bug id#2066

Kernel 2.6.3-rc3
Distro : RH9

Battery status comes and goes suddenly. I've tried it with 2.6.2,=20
2.6.2-rc2, 2.6.3-rc3.

ACPI-0279: *** Error: Looking up [BST0] in namespace, AE_ALREADY_EXISTS
ACPI-1120: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node
dff9ca60), AE_ALREADY_EXISTS

With Debug Statements

acpi_battery-0207 [173] acpi_battery_get_statu: Error evaluating _BST
dswload-0279: *** Error: Looking up [BST0] in namespace, =
AE_ALREADY_EXISTS
psparse-0588 [184] ps_parse_loop         : During name lookup/catalog,
AE_ALREADY_EXISTS
psparse-1120: *** Error: Method execution failed [\_SB_.BAT0._BST] (Node
c155d8a8), AE_ALREADY_EXISTS

I used to be running on 2.4.24 kernel and this did not show up at all
during the time when I was using it. On the 2.6 kernel, however, it =
turns
up sporadically. I'm not sure what has changed, I even tried =
back-diffing=20
the patch from 2.4.24 but failed miserably (in the sense that there was=20
lots of patching problems)

Help..

I've not tried suspend/resume etc.. but right now, battery status is #1
priority.
I don't want my laptop to dies on me suddenly.




Cheers,                                              =20
Mun Heng, Ow                                      =20



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
