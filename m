From: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez@opensuse.org>
Subject: ACPI problems, Dell XPS 15z laptop
Date: Sun, 25 Dec 2011 18:07:00 -0300
Message-ID: <4EF79074.90605@opensuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:32812 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab1LYVHE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 25 Dec 2011 16:07:04 -0500
Received: by ggdk6 with SMTP id k6so7406679ggd.19
        for <linux-acpi@vger.kernel.org>; Sun, 25 Dec 2011 13:07:03 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

(please CC me your replies, I am not subscribed)

Hi:

The laptop in $SUBJECT freezes at boot time, at random points sometimes 
after

[FIRMWARE BUG] ACPI(PEGP) defines _DOD but not _DOS

But in other ocassions, just after udev attempts to mount filesystems.

Using the following boot options make the system boot and work somewhat 
stable.

(these are single options, not combined)

- acpi=noirq

- pci=noacpi --> with this option I get warnings telling me to try 
"usepirqmask..."

- nox2apic

- intremap=off

This is a very recent sandy bridge system, the only clues I get from the 
log is:

"Not all IO-APIC's listed under remapping hardware
x2apic not enabled, IRQ remapping init failed"


cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:        115          0          0          0    XT-PIC-XT-PIC    timer
   1:      28425          0          0          0    XT-PIC-XT-PIC    i8042
   2:          0          0          0          0    XT-PIC-XT-PIC 
cascade
   8:          1          0          0          0    XT-PIC-XT-PIC    rtc0
   9:       4256          0          0          0    XT-PIC-XT-PIC    acpi
  11:        491          0          0          0    XT-PIC-XT-PIC 
ehci_hcd:usb1, ehci_hcd:usb2
  12:     879880          0          0          0    XT-PIC-XT-PIC    i8042
  16:          0          0          0          0  DMAR_MSI-edge      dmar0
  17:          0          0          0          0  DMAR_MSI-edge      dmar1
  19:     686343          0          0          0   PCI-MSI-edge      ahci
  20:        405          0          0          0   PCI-MSI-edge 
xhci_hcd
  21:          0          0          0          0   PCI-MSI-edge 
xhci_hcd
  22:          0          0          0          0   PCI-MSI-edge 
xhci_hcd
  23:          0          0          0          0   PCI-MSI-edge 
xhci_hcd
  24:          0          0          0          0   PCI-MSI-edge 
xhci_hcd
  25:    3520576          0          0          0   PCI-MSI-edge 
i915@pci:0000:00:02.0
  26:         11          0          0          0   PCI-MSI-edge      mei
  27:        375          0          0          0   PCI-MSI-edge 
snd_hda_intel
  28:    1532198          0          0          0   PCI-MSI-edge 
iwlwifi
  29:          2          0          0          0   PCI-MSI-edge      eth0
NMI:       1313       3051       2636       1046   Non-maskable interrupts
LOC:    4948209    3236187    4238022    1512561   Local timer interrupts
SPU:          0          0          0          0   Spurious interrupts
PMI:       1313       3051       2636       1046   Performance 
monitoring interrupts
IWI:          0          0          0          0   IRQ work interrupts
RES:    4388750    1211150    6693282    1763936   Rescheduling interrupts
CAL:       6680       1712       7089       1737   Function call interrupts
TLB:     194156      67706     128984      79637   TLB shootdowns
TRM:          0          0          0          0   Thermal event interrupts
THR:          0          0          0          0   Threshold APIC interrupts
MCE:          0          0          0          0   Machine check exceptions
MCP:        125        125        125        125   Machine check polls



The system is running with the most current BIOS (released 3 days ago)

If someone has an idea what other info I can provide to track down this 
issue just let me to know.

ps: I tried with acpi debug boot options, but do not yield much info..

Thanks in advance.




