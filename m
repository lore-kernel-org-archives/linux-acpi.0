From: Hrvoje Habjanic <hrvoje.habjanic-+VD6v/bdhRf0NTdHYsHBKg@public.gmane.org>
Subject: IBM success ... but partial
Date: Mon, 15 Sep 2003 21:19:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200309152119.21050.hrvoje.habjanic@zg.htnet.hr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
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


Hi!

After disabling actual deallocation of memory in ACPI, laptop booted!! And i 
got working shell ... nice. But:

sh-2.05b# cat /proc/interrupts
           CPU0
  0:      49587          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:       1519          XT-PIC  serial
  8:          1          XT-PIC  rtc
  9:         18          XT-PIC  acpi
 14:        947          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0


huh?

sh-2.05b# cat /proc/acpi/power_resource/PUBS/state
state:                   on
system level:            S3
order:                   0
reference count:         0

(is this ok?)

sh-2.05b# cat /proc/acpi/processor/CPU/info
processor id:            0
acpi id:                 1
bus mastering control:   yes
power management:        yes
throttling control:      yes
performance management:  yes
limit interface:         yes

sh-2.05b# cat /proc/acpi/embedded_controller/EC/info
gpe bit:                 0x1c
ports:                   0x66, 0x62
use global lock:         no


AND FAN IS NOT DETECTED???

So, what next? Write to IBM?

H.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
