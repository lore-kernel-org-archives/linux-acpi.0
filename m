From: "Thomas Herrmann" <ollo.diab-Mmb7MZpHnFY@public.gmane.org>
Subject: nforce2 & /proc/acpi/thermal_zone/THRM/temperature
Date: Mon, 12 Apr 2004 13:36:22 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <14981.1081769782@www48.gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary149811081769782"
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

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary149811081769782
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi ACPI developers,

today I build a new kernel 2.4.26-rc2 vanilla on my NForce2 system (EPOX
8RDA+). It build fine and booted clean. But If I try to access
/proc/acpi/thermal_zone/THRM/temperature to read out the CPU temperature it gives back
"temperature:             22 C" which is not correct. lm_sensors reports:

# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.58 V  (min =  +0.00 V, max =  +4.08 V)
VCore 2:   +1.68 V  (min =  +0.00 V, max =  +4.08 V)
+3.3V:     +2.72 V  (min =  +2.82 V, max =  +3.79 V)       ALARM
+5V:       +4.94 V  (min =  +3.68 V, max =  +6.40 V)
+12V:     +11.93 V  (min =  +9.73 V, max = +13.30 V)
-12V:     -11.72 V  (min =  -4.32 V, max =  -2.42 V)       ALARM
-5V:       -5.10 V  (min =  +1.84 V, max =  -5.86 V)       ALARM
V5SB:      +5.51 V  (min =  +5.81 V, max =  +4.74 V)       ALARM
VBat:      +3.07 V  (min =  +3.82 V, max =  +3.28 V)       ALARM
fan1:        0 RPM  (min = 8653 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 4411 RPM, div = 2)              ALARM
fan3:     2556 RPM  (min = 1776 RPM, div = 8)
temp1:       +13°C  (high =   +42°C, hyst =   +85°C)   sensor = thermistor
temp2:     +32.0°C  (high =  +100°C, hyst =   +95°C)   sensor = thermistor
temp3:     +35.0°C  (high =  +100°C, hyst =   +95°C)   sensor = thermistor
vid:      +0.000 V
alarms:
beep_enable:
          Sound alarm disabled

while temp2 is my CPU temperature.

Grepping dmesg I see: ACPI: Thermal Zone [THRM] (22 C)

Please find attached the complete dmesg log.

BTW, using kernel 2.4.25 vanilla it reports the CPU temp through
/proc/acpi/thermal_zone/THRM/temperature correct.

Regards,   Thomas


-- 
NEU : GMX Internet.FreeDSL
Ab sofort DSL-Tarif ohne Grundgebühr: http://www.gmx.net/info
--========GMXBoundary149811081769782
Content-Type: application/x-gunzip; name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.gz"

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
lPNtNK6Ahe8SFvVrsPwL2hcbC/FlAAA=

--========GMXBoundary149811081769782--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
