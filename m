From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Excessive power consumption on Sony VAIO VPCZ23A4R
Date: Sun, 6 Jan 2013 18:07:53 +0600
Message-ID: <CAN_LGv1fZraYbH7LCUwS8L=KsX9vsr8NK7hG+64s51TwPG4mRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51886 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3AFMHy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2013 07:07:54 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so10878035qcr.33
        for <linux-acpi@vger.kernel.org>; Sun, 06 Jan 2013 04:07:53 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello.

I have a Sony VAIO VPCZ23A4R laptop. In Windows 7, it has a battery
life of 7 hours (but now I have only Gentoo Linux on my SSD). In
Gentoo Linux (with kernel 3.7.1), the battery lasts only 4-5 hours. I
guessed that the problem can be related to ASPM, and booted the laptop
with the "pcie_aspm=force" kernel parameter. Result:

[    0.709517] \_SB_.PCI0:_OSC invalid UUID
[    0.709518] _OSC request data:1 1f 1f
[    0.709523]  pci0000:00: ACPI _OSC support notification failed,
disabling PCIe ASPM
[    0.709524]  pci0000:00: Unable to request _OSC control (_OSC
support mask: 0x08)

acpidump output is available at
https://bugs.freedesktop.org/attachment.cgi?id=65558

What else do I need to send you in order to debug and eliminate the problem?

-- 
Alexander E. Patrakov
