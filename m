From: Happy Camper <happy_programmer-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Howto switch system/CPU states?
Date: Sun, 3 Nov 2002 22:02:00 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021104060200.95943.qmail@web11002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I am using 2.4.20-pre10-ac1 and an older ACPI patch for that kernel.
Things comiled fine and my processor looks like it always comes up in C2
state.

$ cat /proc/acpi/processor/CPU/power 
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000]
usage[00046380]
   *C2:                  promotion[C3] demotion[C1] latency[001]
usage[01642565]
    C3:                  promotion[--] demotion[C2] latency[065]
usage[00002290]

I am trying to use some very basic ACPI features with my Linux system but
have not been able to.  Things on my wish list:

1. Suspend the system.  I have tried echo 1 > /proc/acpi/sleep and it
locks up one of my systems while my Thinkpad tries to crash and screen
goes half blank and then hitting the power button brings it back (without
a reboot) with this error:
hwsleep-0239 [09] Acpi_enter_sleep_state: Entering S1
acpi_bus-0263 [21] acpi_bus_get_device   : Error getting context for
object [c1a921c8]

2. Switch CPU C states.  When I load the processor module, I get this
in the /var/log/messages : 
Nov  3 16:09:25 localhost kernel: ACPI: Processor [CPU] (supports C1 C2
C3, 8 throttling states)
However I cant figure out how to switch these processor states.

I have tried pmtest from the pmtools package and it claims to be switching
system states, but the CPU states according to
/proc/acpi/processor/CPU/power
are not changing.

I admit I am newbie at this.  However I have not been able to locate any
current documentation on this stuff.  The Howto at : 
http://www.columbia.edu/~ariel/acpi/acpi_howto.txt
is rather out of date.

I would greatly appreciate any help anybody can provide.

Thanks a million.

Atif

__________________________________________________
Do you Yahoo!?
HotJobs - Search new jobs daily now
http://hotjobs.yahoo.com/


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
