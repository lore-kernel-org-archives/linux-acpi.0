From: John <cirrus-m8NPtmh9OiN1HeySrBk8eLVCufUGDwFn@public.gmane.org>
Subject: Acer 1703 and DSDT fixing questions
Date: Tue, 10 Feb 2004 20:42:30 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200402102042.30427.cirrus@the-penguin.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hello everyone.
I have an Acer Aspire 1703SM laptop, and in the past I have fixed the dsdt 
(thanks to Ducrot Bruno), so that at least the remaining capacity is 
displayed. However no rate information are displayed. 

$ cat /proc/acpi/battery/BAT1/state
present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            unknown
remaining capacity:      5579 mAh
present voltage:         16660 mV

Also:
$ cat /proc/acpi/battery/BAT1/alarm
alarm:                   unsupported

Can someone please have a look at my dsdt (found at: http://
www.zen34434.zen.co.uk/acer.dsl ) and tell me how would it be possible to 
correct it?
When compiling with iasl, I get the following errors:

acer.dsl   816:                     Method (DRUL, 1, NotSerialized)
Warning  2019 -                                ^ Not all control paths return 
a value (DRUL)

acer.dsl  3575:             Method (Z00A, 0, NotSerialized)
Warning  2019 -                        ^ Not all control paths return a value 
(Z00A)

acer.dsl  3699:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                ^ Reserved method must return a value (_WAK)

Which can go away if I add a Return() however I don't know what values should 
be returned. Will simply anything do and is it safe to do? (Like a 
Return(0x00)). Will this fix the rate not displayed and the other problems?

Also could any of you tell me what the following (from dmesg) mean:

PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKA._CRS] (Node c1598b80), AE_TYPE
ACPI: PCI Interrupt Link [LNKA] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3)
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKC._CRS] (Node c1596100), AE_TYPE
ACPI: PCI Interrupt Link [LNKC] (IRQs 5)
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKD._CRS] (Node c1596300), AE_TYPE
ACPI: PCI Interrupt Link [LNKD] (IRQs 7 10)
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKE._CRS] (Node c1596500), AE_TYPE
ACPI: PCI Interrupt Link [LNKE] (IRQs 7 10)
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKF._CRS] (Node c1596700), AE_TYPE
ACPI: PCI Interrupt Link [LNKF] (IRQs 7 10)
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKG._CRS] (Node c1596900), AE_TYPE
ACPI: PCI Interrupt Link [LNKG] (IRQs 7 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs 7 10)
ACPI: Embedded Controller [EC0] (gpe 25)
schedule_task(): keventd has not started
PCI: Probing PCI hardware
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKB._CRS] (Node c1598d80), AE_TYPE
_CRS returns NULL! Using IRQ 3 fordevice (PCI Interrupt Link [LNKB]).
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 3
PCI: No IRQ known for interrupt pin A of device 00:02.5 - using IRQ 255
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKC._CRS] (Node c1596100), AE_TYPE
_CRS returns NULL! Using IRQ 5 fordevice (PCI Interrupt Link [LNKC]).
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKE._CRS] (Node c1596500), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKE]).
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKF._CRS] (Node c1596700), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKF]).
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKG._CRS] (Node c1596900), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKG]).
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKH._CRS] (Node c1596b00), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKH]).
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKD._CRS] (Node c1596300), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKD]).
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
    ACPI-0145: *** Error: Return object type is incorrect 
[\_SB_.PCI0.LPCB.LNKA._CRS] (Node c1598b80), AE_TYPE
_CRS returns NULL! Using IRQ 10 fordevice (PCI Interrupt Link [LNKA]).
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'

Ah and something else. Is it possible to get the iasl compiler working on 
woody, without changing to testing/unstable, as iasl need GLIB2.3 while woody 
has 2.2.5.

Thanks very much,
Cirrus
-- 
/* After several hours of tedious analysis, the following hash
 * function won.  Do not mess with it... -DaveM
 */
	2.2.16 /usr/src/linux/fs/buffer.c


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
