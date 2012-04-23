From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Mon, 23 Apr 2012 11:48:23 +0200
Message-ID: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:42126 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab2DWJsX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Apr 2012 05:48:23 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Adam Belay <abelay@mit.edu>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org

[ Please CC me I am not subscribed to this ML ]

Hi,

with a self-compiled linux-3.4-rc4 I am seeing this bugs/failures/warnings:

[    0.241572] [Firmware Bug]: ACPI: BIOS _OSI(Linux) query ignored

[    0.279385]  pci0000:00: ACPI _OSC request failed (AE_ERROR),
returned control mask: 0x1d

[    0.293699] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.294032] ACPI Error: Invalid/unsupported resource descriptor:
Type 0x00 (20120320/utresrc-650)
[    0.294037] pnp 00:0b: can't evaluate _CRS: 12311

The same outputs I have seen also with an unsupported drm-intel-next
kernel from Ubuntu/PPA archives [1].

What does ist mean? Is it harmless? Buggy firmware/bios?

Do you need more background infos (dmesg, kernel-config, etc.)?

Regards,
- Sedat -

[1] http://kernel.ubuntu.com/~kernel-ppa/mainline/drm-intel-next/current/
