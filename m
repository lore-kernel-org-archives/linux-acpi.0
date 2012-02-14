From: Kyle Evans <kevans@android-x86.org>
Subject: hp-wmi is not notified to run hotkey query...
Date: Tue, 14 Feb 2012 11:47:05 -0500
Message-ID: <CAHJdJgOwx0MdgZdUhQ3NzK99iW9bwWUFdswhJD+G9KSm_d3+xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46010 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756301Ab2BNQrF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Feb 2012 11:47:05 -0500
Received: by pbcun15 with SMTP id un15so586033pbc.19
        for <linux-acpi@vger.kernel.org>; Tue, 14 Feb 2012 08:47:05 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello, I have an HP tx2500 with some bezel buttons that are not
working. HP tabletPC's are notorious for this. I have discovered why
they are not working (hp-wmi is not getting the notification to query
them) and I have managed to insert some code into the DSDT that will
cause hp-wmi to successfully read these keys when the lid is closed. I
have inserted this same code into every _Q?? method from 01-8F,
including those previously undefined, but no dice. I have also
extracted the DSDT from Windows Vista, decompiled it, compared it to
the one I extracted from Linux (several small differences), recompiled
it and ran it. That didn't get it done either.

So basically, this is a BIOS problem that Windows works around. I do
not know enough about the hardware/BIOS to determine whether or not
this is something that can still be fixed in the DSDT, or something
that would have to be fixed in the kernel. For a BIOS fix, I suspect
the Embedded Controller needs to be programmed in some way, along with
a modified dsdt. For a kernel fix, I suspect Windows either polls the
WMI query, programs the EC every boot, or gets the signal some other
way (e.g. PNP0C09).

A brief description of how these hotkeys operate:
The EmbeddedController, PNP0C09, houses the internal button register,
QBBB, that stores the internal key code. When hp-wmi, PNP0C14,
performs the query, QBBB is tested for the button pressed and the
appropriate scancode is wrote to the memory location that is
subsequently read.

I have what I believe to be an accurate MB schematic, which indicates
that the embedded controller is from ENE, chip KB3926, and I have
found data sheets for similar EC's. This is something that I work on
in my spare time, so I would be grateful if someone could share some
knowledge on the subject, or kindly point me to someone who might be
able to help.

Thanks,
Kyle
