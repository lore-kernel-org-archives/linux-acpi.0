From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: AE_ALREADY_EXISTS bug still here
Date: Mon, 5 Apr 2004 08:28:16 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <37F890616C995246BE76B3E6B2DBE05537FC5B@orsmsx403.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Jerome Poggi <Jerome.Poggi-5fwdxd2ikk8@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

However, you should only get the error once.  After that, the method is
forced to "Serialized".

Bob

-----Original Message-----
From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
[mailto:acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Jerome
Poggi
Sent: Saturday, April 03, 2004 10:45 AM
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] AE_ALREADY_EXISTS bug still here

Hi all,

I get one bug :

Apr  3 20:12:03 efflam ACPI-0279: *** Error: Looking up [BUFF] in
namespace, AE_ALREADY_EXISTS
Apr  3 20:12:03 efflam ACPI-1133: *** Error: Method execution failed
[\_SB_.BAT1._BST] (Node c12d0f60), AE_ALREADY_EXISTS

But i had the last kernel version and the last ACPI patch :

root-mvppoxjXWBo@public.gmane.org:/proc # cat version=20
Linux version 2.6.4-hardened-r3 (root-mvppoxjXWBo@public.gmane.org) (gcc version 3.3.3
20040217 (Gentoo Linux 3.3.3, propolice-3.3-7)) #5 Fri Apr 2 15:32:48
CEST 2004

root-mvppoxjXWBo@public.gmane.org:/proc/acpi # cat info=20
version:                 20040326

# biosdecode 2.3
ACPI 1.0 present.
        OEM Identifier: TOSHIB
        RSD Table 32-bit Address: 0x0FF60000
PCI Interrupt Routing 1.0 present.
        Router ID: 00:1f.0
        Exclusive IRQs: None
        Compatible Router: 8086:122e
        Slot Entry 1: ID 00:1f, on-board
        Slot Entry 2: ID 02:07, on-board
        Slot Entry 3: ID 02:0d, on-board
        Slot Entry 4: ID 02:08, on-board
        Slot Entry 5: ID 01:00, on-board
        Slot Entry 6: ID 02:0c, on-board
        Slot Entry 7: ID 02:0a, slot number 1
        Slot Entry 8: ID 02:0b, slot number 2
        Slot Entry 9: ID 02:01, slot number 3
BIOS32 Service Directory present.
        Revision: 0
        Calling Interface Address: 0x000FC34A
SMBIOS 2.3 present.
        Structure Table Length: 1380 bytes
        Structure Table Address: 0x000EC000
        Number Of Structures: 43
        Maximum Structure Size: 92 bytes
SYSID present.
        Revision: 0
        Structure Table Address: 0x000F03A0
        Number Of Structures: 1
PNP BIOS 1.0 present.
        Event Notification: Polling
        Event Notification Flag Address: 0x00000510
        Real Mode 16-bit Code Address: F000:914B
        Real Mode 16-bit Data Address: 0000:0000
        16-bit Protected Mode Code Address: 0x000F9168
        16-bit Protected Mode Data Address: 0x00000000
        OEM Device Identifier: TOS3500

/proc/acpi/battery/BAT2/alarm
alarm:                   64 mAh
---
/proc/acpi/battery/BAT2/state
present:                 yes
capacity state:          ok
charging state:          charging
present rate:            810 mA
remaining capacity:      2283 mAh
present voltage:         10930 mV
---
/proc/acpi/battery/BAT2/info
present:                 yes
design capacity:         3400 mAh
last full capacity:      3168 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 64 mAh
design capacity low:     0 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            P71022002112
serial number:           1000172838
battery type:            Li-ION =20
OEM info:               =20
---
/proc/acpi/battery/BAT1/alarm
alarm:                   68 mAh
---
/proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            786 mA
remaining capacity:      3400 mAh
present voltage:         11270 mV
---
/proc/acpi/battery/BAT1/info
present:                 yes
design capacity:         3600 mAh
last full capacity:      3400 mAh
battery technology:      rechargeable
design voltage:          10800 mV
design capacity warning: 68 mAh
design capacity low:     0 mAh
capacity granularity 1:  1 mAh
capacity granularity 2:  1 mAh
model number:            XM2030P02  =20
serial number:           1000010554
battery type:            Li-ION =20
OEM info:               =20
---

My dmesg and DSDT are in attached piece.

Jerome.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
