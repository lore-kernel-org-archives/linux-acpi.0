From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: it87 sensors need an ACPI driver (2.6.31)
Date: Sun, 20 Sep 2009 10:17:21 +0100
Message-ID: <9b2b86520909200217v71c9529ax3dbbd2341049295e@mail.gmail.com>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:42427 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbZITJRT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Sep 2009 05:17:19 -0400
In-Reply-To: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: wixor <wixorpeek@gmail.com>
Cc: lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

[CC linux-acpi]

On 9/20/09, wixor <wixorpeek@gmail.com> wrote:
> Hello,
> with recent upgrade to 2.6.31 I get
>
> it87: Found IT8712F chip at 0x290, revision 7
> it87: in3 is VCC (+5V)
> it87: in7 is VCCH (+5V Stand-By)
> ACPI: I/O resource it87 [0x295-0x296] conflicts with ACPI region IP__
> [0x295-0x296]
> ACPI: Device needs an ACPI driver
> FATAL: Error inserting it87
> (/lib/modules/2.6.31/kernel/drivers/hwmon/it87.ko): Device or resource
> busy
>
> when trying to load it87 module. On previous kernels the module worked
> fine. I tried grepping for IP__ in acpi dump and found this:
>
> OperationRegion (IP, SystemIO, 0x0295, 0x02)
> Field (IP, ByteAcc, NoLock, Preserve)
> {
>     INDX,   8,
>     DAT0,   8
> }
>
> I have also discovered that dsdt contains description of what is
> connected to each it87 input. Maybe it has also some code to access
> the chip? In /proc/acpi I can read only one temperature, while the
> chip measures three temperatures, fan speeds and voltages. This is
> desktop pc with ASUS A8N1-E maniboard, athlon64 and nforce4 chipset.
>
> Thanks for your time.
