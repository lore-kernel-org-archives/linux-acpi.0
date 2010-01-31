From: Ash Milsted <ashmilsted@gmail.com>
Subject: BenQ Joybook S53W with SRS Wow! hardware: second Embedded Controller?
Date: Sun, 31 Jan 2010 21:34:13 +0100
Message-ID: <3e7b9f4b1001311234jb0b61f5t97db2d90bac15932@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:26288 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0AaUeP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Jan 2010 15:34:15 -0500
Received: by fg-out-1718.google.com with SMTP id l26so1562440fgb.1
        for <linux-acpi@vger.kernel.org>; Sun, 31 Jan 2010 12:34:14 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi.

I am an owner of a BenQ Joybook S53W laptop which unfortunately
includes a hardware SRS Wow! sound-butchering feature. It is on by
default, and BenQ supplies a windows app to turn it on or off. Having
examined this app/driver, it looks like it accesses an embedded
controller with command/status port 0x6c and data port 0x68. Linux
detects EC0 on 0x62 and 0x66 and there appears to be no info on this
second controller in the DSDT (there is no ECDT). I have tried to
replicate what the windows app/driver does in linux, which involves
disabling interrupts and then waiting for bits 1 and 2 of the status
port to be set before writing a command like 0x53 to the command port,
waiting again, then writing to the data port. When I do this under
linux, the status bits are never set - the status register just has a
value of 0x04. If I boot with acpi=off bits 1 and 2 do seem to be set
when needed, so the commands appear to succeed (although they are not
having the desired effect, AFAICT). So, my questions are:

Is linux acpi initialising this second EC in some way? Or is Windows
perhaps initialising it in a way linux isn't?
Is it likely that I need to enable the chip by writing to some other register?
Does anyone have any ideas how I could proceed?

Please CC me on reply.

Thanks!

Ashley Milsted

PS: The Windows app does essentially this:

spin_lock;
cli;
while !(inb 0x6c & 1); //with max-loops 65535
while !(inb 0x6c & 2); //with max-loops 65535

outb 0x6c, 0x53 //turn SRS effect off

while !(inb 0x6c & 2); //with max-loops 65535
while !(inb 0x6c & 1); //with max-loops 65535
while !(inb 0x6c & 2); //with max-loops 65535

outb 0x68, 0x00 //turn SRS Effect off

while !(inb 0x6c & 2); //with max-loops 65535

sti;
spin_unlock;
