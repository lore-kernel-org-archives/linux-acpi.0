From: Parrenin =?ISO-8859-1?Q?Fr=E9d=E9ric?= <Frederic.Parrenin-uJC2I/HWIrG1lNqXp+/2b1AUjnlXr6A1@public.gmane.org>
Subject: acpi on a Samsung V20 with mandrake 9.0
Date: 11 Dec 2002 13:38:20 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200212111241.gBBCfgw08025@cnes.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello,


I am not an expert of acpi, so excuse me if my questions are basic.
(but there is no acpi-users mailing list, just an acpi-devel one...)
I try to use acpi on my laptop Samsung V20, which is supposed to support
acpi 1.0b.
I have installed Mandrake 9.0, but because acpi is not compiled in their
kernel, I have upgraded to the 2.4.20 kernel from mandrake (package
kernel-2.4.20.1mdk-1-1mdk). I have also tried to recompile that kernel.

Acpi seems to work, because I have a /proc/acpi directory with several
files and subdirectories. I have two main problems :
- I can't control the state of my battery : the subdirectory
/proc/acpi/battery is empty.
- I can't enter a suspend to ram mode. I have tried 
cat -n 1 > /proc/acpi/suspend
but nothing appears.

What is wrong in my configuration ?
Many thanks.

	Frederic



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
