From: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Subject: Re: Random shutdowns - some new details
Date: Tue, 16 Sep 2003 07:54:58 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F66A5B2.2060400@sbox.tugraz.at>
References: <3F5580DE.1060904@sbox.tugraz.at> <20030908095253.GC3944@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060607060808050702000300"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030908095253.GC3944-u08AdweFZfgxtPtxi4kahqVXKuFTiq87@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: pavel-AlSwsSmVLrQ@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------060607060808050702000300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:

> In-kernel ACPI will happily call /sbin/halt for you in case of system overheat.
> Watch /proc/acpi/thermal/*/*

Thank you for this information - when digging through the sources I was 
able to locate the responsible lines.

To get behind these shutdowns I added some lines dealing with thermal 
events, mainly cat'ting /proc/acpi/thermal_zone/THRx/temperature, to the 
script /usr/sbin/acpid_proxy.

This script is called by acpid with the text of the occured event as 
parameter (The SuSE-way of handling acpi-events).

Three days ago another shutdown occured, showing two things:
1) I made some mistake when extending acpid_proxy. But the temperatures 
were logged.
2) The temperature logged are far below the trip-points for a shutdown. 
(see the attached files)

The trip-point for my thermal zone THRS is 92C, the actual temperature 
when the event occured was 46C (logged)

What does this mean?

Any hints are welcome

Regards,
Maier Gerfried

Please mind the attached files:
acpid - a cut from the acpid-logfile
THRC-trip_points - /proc/acpi/thermal_zone/THRC/trip_points
THRS-trip_points - /proc/acpi/thermal_zone/THRS/trip_points


The System is an Acer Travelmate Notebook with
Kernel 2.4.22 acpi and the
preemptive-patch (although I do not think that preemptive has anything 
todo with my problems - the shuthdowns already occured when I knew 
nothing about preemptive, meaning with vanilla 2.4.xx + acpi-patch)
Base-system: SuSE 8.1


--------------060607060808050702000300
Content-Type: text/plain;
 name="acpid"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="acpid"

[Sat Sep 13 14:46:31 2003] starting up
[Sat Sep 13 14:46:32 2003] 1 rule loaded
[Sat Sep 13 17:39:58 2003] received event "button/sleep SLPB 00000080 00000001"
[Sat Sep 13 17:39:58 2003] executing action "/usr/sbin/acpid_proxy button/sleep SLPB 00000080 00000001"
[Sat Sep 13 17:39:58 2003] BEGIN HANDLER MESSAGES
ACPI event button/sleep SLPB 00000080 00000001
No action defined for ACPI event button/sleep SLPB 00000080 00000001
[Sat Sep 13 17:39:58 2003] END HANDLER MESSAGES
[Sat Sep 13 17:39:58 2003] action exited with status 0
[Sat Sep 13 17:39:58 2003] completed event "button/sleep SLPB 00000080 00000001"
[Sat Sep 13 17:48:07 2003] received event "thermal_zone THRS 000000f0 00000001"
[Sat Sep 13 17:48:07 2003] executing action "/usr/sbin/acpid_proxy thermal_zone THRS 000000f0 00000001"
[Sat Sep 13 17:48:07 2003] BEGIN HANDLER MESSAGES
ACPI event thermal_zone THRS 000000f0 00000001
Sat Sep 13 17:48:07 CEST 2003: event thermal_zone THRS 000000f0 00000001, THRS temperature:             46 C,  /
/usr/sbin/acpid_proxy: line 109: THRC temperature:             44 C: command not found
[Sat Sep 13 17:48:07 2003] END HANDLER MESSAGES
[Sat Sep 13 17:48:07 2003] action exited with status 0
[Sat Sep 13 17:48:07 2003] completed event "thermal_zone THRS 000000f0 00000001"
[Sat Sep 13 17:48:07 2003] received event "thermal_zone THRS 000000f0 00000000"
[Sat Sep 13 17:48:07 2003] executing action "/usr/sbin/acpid_proxy thermal_zone THRS 000000f0 00000000"
[Sat Sep 13 17:48:07 2003] BEGIN HANDLER MESSAGES
ACPI event thermal_zone THRS 000000f0 00000000
Sat Sep 13 17:48:07 CEST 2003: event thermal_zone THRS 000000f0 00000000, THRS temperature:             46 C,  /
/usr/sbin/acpid_proxy: line 109: THRC temperature:             44 C: command not found
[Sat Sep 13 17:48:07 2003] END HANDLER MESSAGES
[Sat Sep 13 17:48:07 2003] action exited with status 0
[Sat Sep 13 17:48:07 2003] completed event "thermal_zone THRS 000000f0 00000000"
[Sat Sep 13 17:48:14 2003] exiting


--------------060607060808050702000300
Content-Type: text/plain;
 name="THRC-trip_points"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="THRC-trip_points"

tical (S5):           100 C
passive:                 86 C: tc1=2 tc2=5 tsp=300 devices=0xc12c6a80


--------------060607060808050702000300
Content-Type: text/plain;
 name="THRS-trip_points"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="THRS-trip_points"

critical (S5):           92 C
passive:                 80 C: tc1=2 tc2=5 tsp=300 devices=0xc12c6a80


--------------060607060808050702000300--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
