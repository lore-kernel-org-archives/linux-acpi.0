From: "Gabor Gabris" <gaborgabris@gmail.com>
Subject: Synaptic touchpad freezes and lost sync messages in dmesg
Date: Sun, 4 Feb 2007 21:18:14 +0100
Message-ID: <f6dfbef00702041218r403147dse04a771fc46e5b73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:4470 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbXBDUSP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Feb 2007 15:18:15 -0500
Received: by nz-out-0506.google.com with SMTP id x7so1452579nzc
        for <linux-acpi@vger.kernel.org>; Sun, 04 Feb 2007 12:18:15 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!

I encountered problems on my laptop, which is an Albacomp Eco
Traveller V4 (AFAIK it is a rebranded Clevo M660S), it does not bot
Linux without ACPI (at least my UHU-Linux with kernel 2.6.17 does not
boot with acpi=off parameter), but when I use the Synaptics touchpad
in X, the cursor often freezes, and in dmesg i can see the following:

[17186729.044000] psmouse.c: bad data from KBC - bad parity
[17186729.048000] psmouse.c: bad data from KBC - timeout
[17186729.056000] psmouse.c: bad data from KBC - bad parity
[17186729.056000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186729.060000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186729.060000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186729.068000] psmouse.c: bad data from KBC - bad parity
[17186729.068000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 4
[17186729.072000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186729.072000] psmouse.c: issuing reconnect request
[17186757.108000] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x81a0b1,
caps: 0xa04713/0x204000
[17186757.144000] input: SynPS/2 Synaptics TouchPad as /class/input/input3
[17186807.068000] psmouse.c: bad data from KBC - bad parity
[17186807.068000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 4
[17186807.072000] psmouse.c: bad data from KBC - timeout
[17186807.076000] psmouse.c: bad data from KBC - bad parity
[17186807.076000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186807.080000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186807.080000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186807.080000] psmouse.c: bad data from KBC - bad parity
[17186807.084000] psmouse.c: TouchPad at isa0060/serio4/input0 lost
sync at byte 1
[17186807.084000] psmouse.c: issuing reconnect request
[17186807.712000] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x81a0b1,
caps: 0xa04713/0x204000
[17186807.752000] input: SynPS/2 Synaptics TouchPad as /class/input/input4

I googled a bit an I found that not I am the first with this problem.
The thread, titled "Synaptics and keyboard losing interrupts w/ACPI ?"
and acpi.sf.net and the FreeBSD ACPI chapter gave me some hints, but I
am only a user, I am not really into programming. But as I can
understand the problem is caused by the querying of the battery.
Unfortunately the simple workaround - disable battery monitoring apps
- did not solved the problem. As I wrote earlier, the machine does not
want to boot Linux without ACPI.
But! I tried to disassemble and recompile the DSDT table, which was
found very buggy: the iasl compiler found 47 errors, from which 1
could I solve (a ByteAcc instead of AnyAcc).
My question is that, what do you think, is there any chance, that
fixing the DSDT table will solve the problem?

Thanks

Gabor Gabris
