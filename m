From: Kyle Evans <kevans@android-x86.org>
Subject: Re: hp-wmi is not notified to run hotkey query...
Date: Thu, 23 Feb 2012 12:03:47 -0500
Message-ID: <CAHJdJgNq8taDN0ERJaxGF43NnMmeOYY_bVcWTzzfSMTYhHfKww@mail.gmail.com>
References: <CAHJdJgOwx0MdgZdUhQ3NzK99iW9bwWUFdswhJD+G9KSm_d3+xw@mail.gmail.com>
	<1329816650.5525.176.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:36308 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab2BWRDr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Feb 2012 12:03:47 -0500
Received: by pbcun15 with SMTP id un15so1617366pbc.19
        for <linux-acpi@vger.kernel.org>; Thu, 23 Feb 2012 09:03:47 -0800 (PST)
In-Reply-To: <1329816650.5525.176.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: linux-acpi@vger.kernel.org

Thank you Joey for sharing these debug methods.

> You might need check those buttons emit Q event or WMI event.
>
> watch -n 1 cat /sys/firmware/acpi/interrupts/gpe_all
> watch -n 1 cat /sys/firmware/acpi/interrupts/gpe[0123][0123456789ABCDEF]
>
> The value should increased when you press hotkey.
> Then reference Corentin's article: http://lwn.net/Articles/391230/
>
I found that nothing happens in gpe_all when I push a hotkey button. I
also found that GPE03 calls _Q15. _Q15 is the wireless switch method,
which I have reprogrammed to notify hp-wmi of a keypress. Where is it
defined that GPE03 runs method _Q15?

> Use wmidump to parse out wmi, find out the wmi event we might want to
> listen, the flags should has ACPI_WMI_EVENT.
>
> Then, the hard thing is we need try to poke and try to reverse engineer
> to GUESS the input/output format from event.
I did not run wmidump because first, it was not installed, and second,
because I have determined that the wmi component works.

> If the EC emit Q event when press hotkey, you can enable acpi debug log:
> acpi.debug_level=0x0000000F acpi.debug_layer=0xffffffff log_buf_len=5M
>
> To monitor which method does it run when you press hotkey.
The EC not emitting a Q event is indeed my problem. It should run
method _Q16, which is defined to notify wmi of a keypress.

> And, it's also possibility for EC direct emit scancode, you can use:
> showkey command to grub it or look at dmesg should has some messages.
The way the DSDT is written, this is not the case. However, this may
be something to look at since the EC is the one that reads the button
via SMBus. I can read the internal code via ec_read(0xA2,tmp), a.k.a
QBBB.


Here is my current thinking, something in the EC should trigger method
_Q16. Ideally, SMBus should do it when it receives the button code.
Unfortunately, that function looks like it started with ACPIspec-2
section 5.6.2.2.2. Although the manufacturer's website indicates the
EC, ENE KB3926 supports ACPI v2, my dsdt.dsl only indicates ACPI v1.
Another possibility, although probably not, is that the buttons also
trigger a GPIO when one is pressed and that the correct GPIO pin needs
to be programmed correctly. My final thought is to do polling in the
EC instead of in the kernel by programming one of the GP Timers to
check for a button press and emit a wmi event in such a case.

The problem I face now is that the GPIO pin configuration is at
0xFCxx, and the GPT configuration is at 0xFExx, neither of which can
be accessed with ec_read/write, as it is confined to 0xFFxx. Maybe
there is another function that I do not find?

Thanks,
Kyle
