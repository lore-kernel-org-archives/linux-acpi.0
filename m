From: Mark Stocker <pezed-K4nppHclNNFeoWH0uzbU5w@public.gmane.org>
Subject: acpi on toshiba satellite 1625CDT
Date: Mon, 10 Mar 2003 04:04:14 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303100404.14947.pezed@pezed.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

I've been trying for about a week now to get acpi working properly on this 
machine (using 2.4.21-pre5 and the latest acpi patch) but im just not having 
much luck.  The annoying problem is the fan.  The fan comes on as it should, 
but then it will never go off again. The fan is "detected" and shows up under 
/proc/acpi/fan/FAN/ and under /proc/acpi/power_resource/PFAN/.  Both of these 
directories have a "state" file which show:

mark@lappy /proc/acpi/fan/FAN]$ cat state
status:                  off

[mark@lappy /proc/acpi/power_resource/PFAN]$ cat state
state:                   off
system level:            S0
order:                   0
reference count:         0

"echo 0 > /proc/acpi/fan/FAN/state" shows the following:
acpi_power-0363 [50] acpi_power_transition : Error transitioning device [FAN] 
to D0
acpi_bus-0496 [49] acpi_bus_set_power    : Error transitioning device [FAN] to 
D0

"echo 1 > /proc/acpi/fan/FAN/state" shows:

acpi_bus-0447 [49] acpi_bus_set_power    : Device does not support D1

/proc/acpi/power_resouce/PFAN isnt writable.

cat /proc/acpi/event will properly show when the lid switch or power button is 
pressed.
battery info doesnt appear to be read correctly as it shows a battery even 
when i remove the battery. (doesnt bother me)

thermal info appears to be read correctly (temp goes up and down with system 
load).

the fan problem is the only thing that is really bothering me (the fan is 
loud!!).  i've tried to create my own dsdt file with no luck.  in the stock 
dsdt file Device(FAN) appears to be an alias to PowerResource PFAN.
i've searched the net over and cant seem to find any info on this laptop and 
acpi.  :(
any help or tips would be greatly appreciated!
thanks!


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
