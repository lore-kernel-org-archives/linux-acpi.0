From: Allan Mcintosh <amcintosh-sAvY64jVBerkQYj/0HfcvtBPR1lH4CV8@public.gmane.org>
Subject: "Found HC with no IRQ" empty /proc/bus/usb
Date: Fri, 01 Apr 2005 13:00:40 -0500
Message-ID: <424D8C48.1090804@atreus-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

Hey,

On my debian Dual 550MHz Pentium III machine, I am unable to get usb
working. I didn't notice anything obvious in the bios that would disable
USB. Any suggestions would be greatly appreciated.

I have tried several kernels, most recently 2.6.10 and 2.6.11.5.
I have also tried booting with variations of

append="noapic acpi=off pci=biosirq"


Upon loading uhci_hcd module I see the following

$ dmesg
<snip>
usbcore: registered new driver usbfs
usbcore: registered new driver hub
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
USB Universal Host Controller Interface driver v2.2
PCI: Enabling device 0000:00:07.2 (0000 -> 0001)
PCI: No IRQ known for interrupt pin C of device 0000:00:07.2. Probably
buggy MP table.
uhci_hcd 0000:00:07.2: Found HC with no IRQ.  Check BIOS/PCI
0000:00:07.2 setup!



$ lspci -vv
<snip>
0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at ef80 [size=32]


$ lsmod
Module                  Size  Used by
uhci_hcd               34640  0
ehci_hcd               34180  0
usbhid                 33184  0
usbcore               123096  3 uhci_hcd,ehci_hcd,usbhid
<snip>









-- 
Allan McIntosh

Software Designer


Atreus Systems, Inc.

613-233-1741 ext: 217 (Office)

613-233-8204 (Fax)

amcintosh-sAvY64jVBerkQYj/0HfcvtBPR1lH4CV8@public.gmane.org <mailto:amcintosh-sAvY64jVBerkQYj/0HfcvtBPR1lH4CV8@public.gmane.org>

www.atreus-systems.com <http://www.atreus-systems.com/>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
