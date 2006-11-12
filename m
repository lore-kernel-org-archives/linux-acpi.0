From: jm@jm10.no-ip.com
Subject: Asus A6T(c)
Date: Sun, 12 Nov 2006 21:34:57 +0100
Message-ID: <45578571.1030905@jm10.no-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ble59-2-81-56-123-123.fbx.proxad.net ([81.56.123.123]:30736
	"EHLO jm10.no-ip.com") by vger.kernel.org with ESMTP
	id S1753129AbWKLUfA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 12 Nov 2006 15:35:00 -0500
Received: from julien ([192.168.0.2])
	by jm10.no-ip.com with esmtpa (Exim 4.50)
	id 1GjM2c-0005Nv-5F
	for linux-acpi@vger.kernel.org; Sun, 12 Nov 2006 21:34:58 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,


I have Debian/Sid/2.6.18.2-amd64-smp on an Asus A6Tc-AP014H laptop and there are
many problems with ACPI. But the most annoying one is that I'd like it to
suspend-to-ram.

More precisely, it does suspend, but doesn't resume: the hard-drive does not
return from power-saving mode. The screen remains off, the system freezes, with
solid HD activity light. This is common with SATA disks... but mine is a PATA one.

Apart from that, as you asked:
> Asus Laptop ACPI Extras version 0.30
>   Error calling BSTS
>   unsupported model A6Tc, trying default values
>   send /proc/acpi/dsdt to the developers
you'll find it on http://81.56.123.123/~jm/A6Tc-AP014H/
with other information about my config.
Note there are unknown opcodes, and even after having removed the 4 errors at
the beginning of dsdt.dsl, it still fails to recompile.

Linux 2.6.18-486 (Debian) boots but Linux 2.6.18-amd64-smp doesn't: it crashes
just after
> io scheduler noop registered
> io scheduler anticipatory registered (default)
(or just before "0000:00:0b.0 OHCI: BIOS handoff failed (BIOS bug ?) 000007b4")
I need to add either "acpi=noirq" or "noapic" to the kernel command line.
"acpi=noirq" gives better results: USB doesn't work with "noapic" (I have
exactly the same problem as
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=205672)

There are really a lot of awful things in the dmesg:
* yet another invitation:
> PCI: Bus #04 (-#07) is hidden behind transparent bridge #03 (-#04) (try
'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
* "pcie_portdrv_probe->Dev[02fd:10de] has invalid IRQ. Check vendor BIOS"
 (I already have the latest BIOS)


By curiosity, is CONFIG_ACPI_SLEEP required for suspend-to-ram? Before I enable
it, I couldn't write to /sys/power/state:
> echo: write error: Operation not permitted
Google always tells me CONFIG_HOTPLUG_CPU is required (it was already enabled)
but never mentions CONFIG_ACPI_SLEEP, while Linux says:
"This option is not recommended for anyone except those doing driver power
management development." (drivers/acpi/Kconfig:64)


JM
