From: Michael Notforyou <sqfreak-goaWJWIt5zpWk0Htik3J/w@public.gmane.org>
Subject: Update on my Compaq Presario 730US
Date: Sun, 25 Aug 2002 00:49:34 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <5.1.0.14.0.20020825003345.03296a68@pop-server.triad.rr.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_2091048198==_.ALT"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=====================_2091048198==_.ALT
Content-Type: text/plain; charset="us-ascii"; format=flowed

Most things are working now. AMD Duron 1.0GHz on a VIA motherboard.
I was compiling an SMP kernel which forces local APIC. I'm stupid.
Now it's using Duron/Athlon/K7 optimizations.

Using ACPI 20020404 kernel 2.4.18.

The processor is not SpeedStep compliant, so processor speed is controlled 
by /proc/acpi/processor/CPU0/limit

Battery % and time remaining is accessible.
The computer isn't hot all the time - the fan isn't even on now!
No thermal_zone directory.
Battery power alarm not supported.
Buttons detected:
lid
power
power
sleep
AC Adapter status reads OK.
embedded_controller directory (what's that?)

cat info on the processor in ACPI returns:
processor id:                   0
acpi id:                        1
bus mastering control:          no
power management:               yes
throttling control:             yes
performance management: no
limit interface:                        yes

Supports states C1, C2, not C3
Supports 16 T-states. (It's sitting in state 9 forced by limit)


Any of the weird (no thermal_zones, no P-states) fixed by newer versions?


Also, can I get it to sleep? Or hibernate (save state to disk)?

*Michael Notforyou*

"My God, I'm full of stars!"
Darmok and Jalad at Tanagra!
--=====================_2091048198==_.ALT
Content-Type: text/html; charset="us-ascii"

<html>
Most things are working now. AMD Duron 1.0GHz on a VIA motherboard.<br>
I was compiling an SMP kernel which forces local APIC. I'm stupid.<br>
Now it's using Duron/Athlon/K7 optimizations.<br><br>
Using ACPI 20020404 kernel 2.4.18.<br><br>
The processor is not SpeedStep compliant, so processor speed is
controlled by /proc/acpi/processor/CPU0/limit<br><br>
Battery % and time remaining <b>is</b> accessible.<br>
The computer isn't hot all the time - the fan isn't even on now!<br>
<b>No</b> thermal_zone directory.<br>
Battery power alarm <b>not</b> supported.<br>
Buttons detected:<br>
lid<br>
power<br>
power<br>
sleep<br>
AC Adapter status reads <b>OK</b>.<br>
embedded_controller directory (what's that?)<br><br>
cat info on the processor in ACPI returns:<br>
processor
id:<x-tab>&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>0<br>
acpi id:
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>1<br>
bus mastering
control:<x-tab>&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>no<br>
power
management:<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>yes<br>
throttling
control:<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>yes<br>
performance management:<x-tab>&nbsp;</x-tab>no<br>
limit
interface:<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab><x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>yes<br><br>
<b>Supports</b> states C1, C2, <b>not</b> C3<br>
<b>Supports</b> 16 T-states. (It's sitting in state 9 forced by
limit)<br><br>
<br>
Any of the weird (no thermal_zones, no P-states) fixed by newer
versions?<br><br>
<br>
Also, can I get it to sleep? Or hibernate (save state to disk)?<br>
<x-sigsep><p></x-sigsep>
*Michael Notforyou*<br><br>
&quot;My God, I'm full of stars!&quot;<br>
Darmok and Jalad at Tanagra!</html>

--=====================_2091048198==_.ALT--



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
