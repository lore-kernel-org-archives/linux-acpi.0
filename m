From: "GUERRERO,FRANCISCO (HP-Spain,ex2)" <francisco.guerrero-VXdhtT5mjnY@public.gmane.org>
Subject: Power managment under Linux 2.4.18-2
Date: Tue, 18 Feb 2003 20:01:37 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E04A580345A7A428A74484F87A1DE62C5D9D6@dali.bpo.hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "'acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org'" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,

I'm new in the power management arena under Linux. I'm probing a suspend to
ram state on the kernel version 2.4.18 using APM and ACPI ( I compile
conveniently the kernel for each test). For APM, I'm using the command "apm
-s", and for ACPI, I'm using "echo -n 3 > /proc/acpi".  Unfortunately,
nothing works. In the case of APM, its seem that the only things the system
do is switch off the monitor, but the CPU and all the rest is alive ( I'm
measuring the power consumption, and its the same ). In the case of ACPI,
the system completely crash ( but in this case, at least the power
consumption is the one we can expected for a STR feature ).

I'm working on an intel architecture composed of an IntelCeleron 1.7G plus
the ICH4 chipset. I didn't want to change to version 2.5, as I need to
resolve the problem under 2.4, so could anybody help me about this issue.
STR works under 2.4.18 APM or ACPI ?

Also, I have been looking at the kernel code, and it seem that the acpi
infrastructure is not linked to the pm.c module as the APM one. How the
add-on devices are linked to the power management infrastructure under acpi
? I see an easy way to manage this under apm, but not under acpi. What is it
missing ? 

Many thanks in advance,

Paco Guerrero.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
