From: Sihan Goi <goister@gmail.com>
Subject: APIC not working on Lenovo Thinkpad x201i laptop
Date: Thu, 24 Feb 2011 17:52:13 +0800
Message-ID: <AANLkTikjRYa-cz+=zGwHn64ADHMq0-Xoz8Se3b2vUJaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

I have a problem getting my Linux kernel (2.6.30.5 and 2.6.37) to run
on a Lenovo Thinkpad x201i laptop(Intel QM57 chipset) when I enable
APIC in the kernel configuration.

I get the following errors in dmesg, and USB does not work.

pci <some number>: can't find IRQ for PCI INT A: probably buggy MP table
ata_piix <some number>: can't find IRQ for PCI INT C: probably buggy MP table
ehci_hcd <some number>: can't find IRQ for PCI INT D: probably buggy MP table

I'm also getting a lot of these errors:
usb 1-1: new high speed device using ehci_hcd and address 2
usb 1-1: device not accepting address 2, error -110

When I either pass the "noapic" kernel option during boot time, or
disable APIC in the kernal configuration (CONFIG_X86_UP_APIC), I don't
get these errors, and I also see the EHCI controller properly detected
in dmesg as follows:

usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.30.5 ehci_hcd
usb usb1: SerialNumber: 0000:00:1a.0
usb usb1: Configuration #1 chosen from 1 choice
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.30.5 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.0
usb usb1: Configuration #1 chosen from 1 choice

So far, this seems to happen only on this particular laptop. While I
can get by without APIC, I'm aware this isn't an ideal setup. Is there
any way I get get APIC to work on all systems? Perhaps some other
kernel configuration settings that needs to be enabled/disabled?

Thanks!

-- 
- Goi Sihan
goister@gmail.com
