From: <susinho-32FzPoaopq1AfugRpC6u6w@public.gmane.org>
Subject: fan always on: ACPI on IBM ThinkPad R51
Date: Tue, 31 Aug 2004 15:06:57 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040831150517.0742C8256@smtp.causaencantada.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all. This is my first message to this list.

I recently owned an IBM Thinkpad R51 1830-BG8 (P Mobile 1.5 with ATI
Radeon M 7500). After wiping the XP thingie, I installed a GNU/ Linux
Debian (sarge) and all works *fine* except the cooling fan, wich is
always on making a really anoying noise: after started at 39 C the fan
doesn't stop, even when the machine doing nothing.

The first thing I tryed was to update the BIOS from 3.05a (the original
one shipped with the machine) to 3.06f wich theoretycally fixes the fan
noise problems. But the behaviour of the machine was exactly the same
after the BIOS update. I uploaded both (buggy) IBM original DSDTs for
reference:

http://acpi.sourceforge.net/dsdt/tables/IBM/R51_1830-BG8/IBM-R51_1830-BG8-3.0=
5a-original.asl.gz
http://acpi.sourceforge.net/dsdt/tables/IBM/R51_1830-BG8/IBM-R51_1830-BG8-3.0=
6f-original.asl.gz

following the HOWTOs, I fixed the last one (I don't understand what I
did, but at least iasl says no errors and no warnings after the fix). I
included the hex table in the kernel, but after sucesfully loaded, the
behaviour still remains the same one. Also I tryed this modified version
of the 3.03 BIOS DSDT

http://acpi.sourceforge.net/dsdt/tables/IBM/R51/IBM-R51-3.03-custom.asl.gz

, but my machine reboots as critical trip points appears to be set to
-273 C.

I did all my tests with 2.6.6, 2.6.7 and 2.6.8 debian patched kernels.
The system manually suspends ok (to memory and disk with swsusp2).
Cpufreq works ok, with powernowd the processor is always at the minimum
frecuency (600000 MHz) and C3 state. Setting the throttling to 7
doesn't changes nothing (well, the machine goes slowly, but the fan is
still on). The only hot chip is the graphics one, now managed by the
radeonfb driver: but it is hot anyway, even without kernel support,
without AGP and DRI, X or text mode.

I was reading the ACPI spec in the thermal side, but modifying passive
trip points has no effect, and active cooling mode doesn't appear to be
available, I don't know how to activate it. Also the /proc/acpi/fan/
directory is empty.

cat /proc/acpi/thermal_zone/THM0/trip_points (only shows THM0)
critical (S5):           94 C
passive:                 92 C: tc1=3D5 tc2=3D4 tsp=3D600 devices=3D0xdfe2e228

cat /proc/acpi/thermal_zone/THM0/cooling_mode
cooling mode:            passive

So, does anyone of you know how can I modify the fan starting/ stopping
points? Is it a lack of the ACPI support, or perhaps a fix to be done in
the DSDT definition? both?

thank you.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
