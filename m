From: Vladimir Volcko <konference-X2ABGLaSPc4@public.gmane.org>
Subject: A30-303 - acpi-20040211-2.4.25 - battery state error
Date: Sun, 29 Feb 2004 20:50:38 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4042428E.8000702@pcs.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello all!!

  On my Toshiba A30-303 - vanilla kernel 2.4.25 (acpi 20040116) or 
kernel 2.4.25 + acpi-20040211-2.4.25.diff.bz2
or kernel 2.4.24 + acpi-20040211-2.4.24.diff.bz2 I have problem with 
battery state monitoring ...  aproximately after 15-45 minutes of 
computer running I don't get right battery state. For monitoring I am 
using KDE Kapacity program, which check state of battery each 60 s. 
(errors described below)

[root-BuUY8psAA2Y@public.gmane.org /]# cat /proc/acpi/battery/BAT1/state
present:                 yes
ERROR: Unable to read battery status

/var/log/messages is full of folowing messages:
Feb 29 19:13:22 sys kernel: acpi_battery-0195 [998] 
acpi_battery_get_statu: Error evaluating _BST
Feb 29 19:13:42 sys kernel:  dswload-0279: *** Error: Looking up [PBST] 
in namespace, AE_ALREADY_EXISTS
Feb 29 19:13:42 sys kernel:  psparse-0588 [1005] ps_parse_loop         : 
During name lookup/catalog, AE_ALREADY_EXISTS

I found thread with similar problem (2.6.3 + D600 + battery state + 
BUG?? [Was] Battery status sometimes missing), but no solution.

Any idea what is wrong?

With regard Vladimir Volcko

PS: sorry for my english ;-)




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
