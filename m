From: marcogi-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org
Subject: Sony Vaio fx601 doesn't suspend
Date: Fri, 23 Aug 2002 22:26:53 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0208232207120.1112-100000@flyby>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

Hi,

I'm using vanilla 2.4.18 kernel + acpi-20020726 on a Sony Vaio
PCG-FX601.
My problem is that Fn+F12 (suspend to disk) keys do not work.
Fn combinations key for LCD/VGA/TV switch work fine, only the
suspend to disk doesn't work.

cat /proc/interrupts says:
         CPU0
0:     326430          XT-PIC  timer
1:       7465          XT-PIC  keyboard
2:          0          XT-PIC  cascade
5:      17605          XT-PIC  VIA686A
7:          0          XT-PIC  parport0
8:          3          XT-PIC  rtc
9:        364          XT-PIC  acpi, usb-uhci, usb-uhci
12:     10676          XT-PIC  PS/2 Mouse
14:     23437          XT-PIC  ide0
15:       773          XT-PIC  ide1
NMI:        0
ERR:        0

If I press Fn+F12, irq 9 counter increases by 2; irq counter increases
the same way pressing Fn combination for LCD/VGA/TV switch too.
I tried 2.4.19 kernel + acpi-20020821 patch too, but doesn't help.
I have Local APIC turned off and 'PnP OS' into BIOS is set to 'NO'.

Am I doing something wrong? Suggestion?
Thanks a lot.

--
Regards,  Marco Gigante
Student at Pisa University - Computer Engineering



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
