From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Excessive power consumption on Sony VAIO VPCZ23A4R
Date: Sun, 06 Jan 2013 15:18:20 +0100
Message-ID: <1939348.oLSthUfcvW@vostro.rjw.lan>
References: <CAN_LGv1fZraYbH7LCUwS8L=KsX9vsr8NK7hG+64s51TwPG4mRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:33373 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756007Ab3AFOMk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 6 Jan 2013 09:12:40 -0500
In-Reply-To: <CAN_LGv1fZraYbH7LCUwS8L=KsX9vsr8NK7hG+64s51TwPG4mRw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sunday, January 06, 2013 06:07:53 PM Alexander E. Patrakov wrote:
> Hello.
> 
> I have a Sony VAIO VPCZ23A4R laptop. In Windows 7, it has a battery
> life of 7 hours (but now I have only Gentoo Linux on my SSD). In
> Gentoo Linux (with kernel 3.7.1), the battery lasts only 4-5 hours. I
> guessed that the problem can be related to ASPM,

Most likely that's not the case.  I suppose that the graphics power management
is more aggressive on Windows and that depends on the graphics driver.

> and booted the laptop
> with the "pcie_aspm=force" kernel parameter. Result:
> 
> [    0.709517] \_SB_.PCI0:_OSC invalid UUID
> [    0.709518] _OSC request data:1 1f 1f
> [    0.709523]  pci0000:00: ACPI _OSC support notification failed,
> disabling PCIe ASPM
> [    0.709524]  pci0000:00: Unable to request _OSC control (_OSC
> support mask: 0x08)
> 
> acpidump output is available at
> https://bugs.freedesktop.org/attachment.cgi?id=65558
> 
> What else do I need to send you in order to debug and eliminate the problem?

Can you please post the output of dmesg without the pcie_aspm=force argument?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
