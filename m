From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: ACPI fail in kernel 2.4.25 and 2.6.3
Date: Tue, 24 Feb 2004 17:26:09 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040224172609.1455bc5b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



Begin forwarded message:

Date: Wed, 25 Feb 2004 00:09:27 +0100
From: Javier Gonzalez <javi-UMxcb9VqC+E@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: ACPI fail in kernel 2.4.25 and 2.6.3


Hi!

Recently I have upgraded my kernel from 2.4.22-AlanCoxPatch. I have an
Acer Travelmate 290LMi laptop (Centrino). All worked well with 2.4.22
but i have problems with new kernels.

With 2.4.25 + cpufreq patch from
ftp://ftp.linux.org.uk/pub/linux/cpufreq/ and a few minutes after boot
(when i try to know battery state with acpi command) i get this "bucle"
error:

Feb 24 23:47:00 localhost kernel: acpi_battery-0195 [1619]
acpi_battery_get_statu: Error evaluating _BST
Feb 24 23:47:01 localhost kernel:  dswload-0279: *** Error: Looking up
[PBST] in namespace, AE_ALREADY_EXISTS
Feb 24 23:47:01 localhost kernel:  psparse-0588 [1626]
ps_parse_loop         : During name lookup/catalog, AE_ALREADY_EXISTS
Feb 24 23:47:01 localhost kernel:  psparse-1120: *** Error: Method
execution failed [\_SB_.PCI0.LPC0.BAT1._BST] (Node c1562528),
AE_ALREADY_EXISTS

I tried with 2.6.3 and y get the same error :-(=20

I have twho friends with diferents laptops who have the same problem.

Thank for your help.

--=20
Un saludo:

                            Javier Gonz=E1lez
                   GNU/Linux registered user #302650


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
