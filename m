From: Andreas Mohr <andi@lisas.de>
Subject: Unhelpful "ACPI handle has no context!" warning
Date: Sat, 30 Jan 2010 20:17:38 +0100
Message-ID: <20100130191738.GA30028@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:47687 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637Ab0A3TRj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jan 2010 14:17:39 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I'm having [subject] message regularly, on several different machines
even.

The current machine (2.6.33-rc4) shows:

serial 00:0d: disabled
pnp 00:0c: legacy suspend
pnp 00:0b: legacy suspend
pnp 00:0a: legacy suspend
system 00:09: legacy suspend
pnp 00:08: legacy suspend
rtc_cmos 00:07: legacy suspend, may wakeup
i8042 kbd 00:06: legacy suspend
i8042 aux 00:05: legacy suspend
system 00:04: legacy suspend
system 00:03: legacy suspend
system 00:02: legacy suspend
pnp 00:01: legacy suspend
system 00:00: legacy suspend
ohci1394 0000:02:0f.2: suspend
ACPI handle has no context!
yenta_cardbus 0000:02:0f.1: suspend
yenta_cardbus 0000:02:0f.0: suspend
pci 0000:02:06.0: suspend
Maestro3 0000:02:03.0: suspend
Maestro3 0000:02:03.0: PCI INT A disabled
ACPI handle has no context!
pci 0000:01:00.0: suspend
pci 0000:01:00.0: PCI INT A disabled
uhci_hcd 0000:00:1f.2: suspend
uhci_hcd 0000:00:1f.2: uhci_pci_suspend
uhci_hcd 0000:00:1f.2: PCI INT D disabled
ata_piix 0000:00:1f.1: suspend
pci 0000:00:1f.0: suspend
pci 0000:00:1e.0: suspend
pci 0000:00:01.0: suspend
pci 0000:00:00.0: suspend
platform dock.0: suspend


I don't know what the hell one could inquire easily, to rectify some
thing or another that seems broken here.

Could this rather weird message (it's both "scary" _and_
very non-informational) be made a bit more user-friendly?
Print out acpi handle %p and dev_name(dev) at least?
Given this dump, one does not know any whereabouts of this message
and would have to actively hack stuff to get most basic info about which
device is being processed unsuccessfully at that particular instant.

Thanks,

Andreas Mohr
