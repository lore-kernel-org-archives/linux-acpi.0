From: Jurgen Kramer <gtm.kramer-c1aixF9oqgPk1uMJSBkQmQ@public.gmane.org>
Subject: 2.4.21 + ACPI 20030619 eats system time
Date: 26 Jun 2003 21:28:45 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1056655725.3845.4.camel@paragon.slim>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I've just tried 2.4.21 with ACPI patch from 20030619 on my P4 system
with HT enabled. I noticed the being very sluggish. Checking top
revealed a high system load. This is supposedly caused by interrupt #18
going crazy:

           CPU0       CPU1
  0:      20747          0    IO-APIC-edge  timer
  1:          2          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:       4221          1    IO-APIC-edge  ide0
 15:          2          0    IO-APIC-edge  ide1
 16:         70          0   IO-APIC-level  usb-uhci, usb-uhci
 17:          0          0   IO-APIC-level  Intel ICH5
 18:   38420092          9   IO-APIC-level  ide2, usb-uhci
 19:        721          0   IO-APIC-level  usb-uhci
 21:        114          0   IO-APIC-level  eth0
 22:        263          0   IO-APIC-level  SysKonnect SK-98xx
 23:         36          0   IO-APIC-level  ehci-hcd
NMI:          0          0
LOC:      20672      20678
ERR:          0
MIS:         10

38 processes: 37 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:   0.0% user  46.4% system    0.0% nice   0.0% iowait  53.0%
idle
CPU1 states:   0.2% user   0.3% system    0.0% nice   0.0% iowait  99.0%
idle
Mem:   515236k av,   67996k used,  447240k free,       0k shrd,    8536k
buff
        25592k active,              28584k inactive
Swap:  787176k av,       0k used,  787176k free

What could be wrong here?

Thanks,

Jurgen




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
