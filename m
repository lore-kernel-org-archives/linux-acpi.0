From: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: Random shutdowns - again some new details
Date: Mon, 20 Oct 2003 09:14:50 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F938B6A.6070203@sbox.tugraz.at>
References: <3F5580DE.1060904@sbox.tugraz.at> <20030908095253.GC3944@openzaurus.ucw.cz> <3F66A5B2.2060400@sbox.tugraz.at> <20030916120243.GD602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060704020503070601000503"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030916120243.GD602-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
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

This is a multi-part message in MIME format.
--------------060704020503070601000503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:


> So try to locate those "/sbin/halt" calling lines, and replace with
> something like "logger 'I refuse to die'", and see what happens. If it
> does not trigger, you know it is something else.

I was not that couraged to disable the shutdown completely, but I
compiled acpi with debug-statements to get more information. Here are
the results of the most recent shutdown:


Temperatures logged via cat /proc/acpi/thermal_zone/*/temperature >
file, triggered by the acpi-thermal-event:

Fri Oct 17 02:18:33 CEST 2003: event thermal_zone THRC 000000f0
00000001, THRC temperature:             39 C, THRS temperature:
      44 C

(please mind: far below the trip-points, which are around 80C)



A section from the acpid-log, where all occuring events are logged:

[Thu Oct 16 17:21:43 2003] starting up
[Thu Oct 16 17:21:43 2003] 1 rule loaded
[Fri Oct 17 02:18:33 2003] received event "thermal_zone THRC 000000f0
00000001"
[Fri Oct 17 02:18:33 2003] executing action "/usr/sbin/acpid_proxy
thermal_zone THRC 000000f0 00000001"
[Fri Oct 17 02:18:33 2003] BEGIN HANDLER MESSAGES
ACPI event thermal_zone THRC 000000f0 00000001
[Fri Oct 17 02:18:33 2003] END HANDLER MESSAGES
[Fri Oct 17 02:18:33 2003] action exited with status 0
[Fri Oct 17 02:18:33 2003] completed event "thermal_zone THRC 000000f0
00000001"
[Fri Oct 17 02:18:42 2003] exiting
[Fri Oct 17 02:33:52 2003] starting up



Attached the last few seconds of the system-log containing the
acpi-debug messages.


Is the code located in thermal.c around line 412 (function
acpi_thermal_critical, namely:
acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF)) the only
occurrence of code in acpi beeing able to do a shutdown?


I'm completely seeking in the dark. The only thing I understood by now
is that the actual temperatures _do not_ seem to exceed the trip-points.
(on my system 92C resp. 100C)


Regards,
Maier Gerfried

PS.:
I'm running kernel 2.4.22 with the acpi in this kernel. (no further
patch applied)



--------------060704020503070601000503
Content-Type: text/plain;
 name="messages_ausschn.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages_ausschn.txt"

Oct 17 02:18:29 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 0000000000000064
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: SYST of _TMP =
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 000000000000002B
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: CPU _TMP =
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: SYST of _TMP =
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 000000000000002B
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: CPU _TMP =
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: SYST of _TMP =
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 000000000000002B
Oct 17 02:18:29 acer kernel: [ACPI Debug] String: CPU _TMP =
Oct 17 02:18:29 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: SYST of _TMP =
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 000000000000002C
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: CPU _TMP =
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: ----------------- Thermal event -------------------
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: SYST of _TMP =
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 000000000000002C
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: CPU _TMP =
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: BAT0_BST_RETURN:
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: --------------------------------------- AC Present   
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 0000000000000064
Oct 17 02:18:33 acer kernel: acpi_thermal-0398 [3248] acpi_thermal_critical : Critical trip point
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: CPU _TMP =
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 0000000000000027
Oct 17 02:18:33 acer kernel: [ACPI Debug] String: SYST of _TMP =
Oct 17 02:18:33 acer kernel: [ACPI Debug] Integer: 000000000000002C
Oct 17 02:18:34 acer init: Switching to runlevel: 0
Oct 17 02:18:43 acer cardmgr[548]: executing: 'rmmod memory_cs'
Oct 17 02:18:43 acer cardmgr[548]: + rmmod: module memory_cs is not loaded
Oct 17 02:18:43 acer cardmgr[548]: rmmod exited with status 1
Oct 17 02:18:44 acer cardmgr[548]: exiting
Oct 17 02:18:44 acer kernel: unloading Kernel Card Services
Oct 17 02:18:45 acer kernel: usb.c: deregistering driver usb-storage
Oct 17 02:18:45 acer kernel: scsi : 1 host left.
Oct 17 02:18:45 acer kernel: Kernel logging (proc) stopped.
Oct 17 02:18:45 acer kernel: Kernel log daemon terminating.
Oct 17 02:18:46 acer exiting on signal 15



--------------060704020503070601000503--



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
