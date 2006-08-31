From: Todd Pytel <tppytel@sophrosune.org>
Subject: Hang on S3 resume with Acer TravelMate 222X
Date: Thu, 31 Aug 2006 18:29:04 -0500
Message-ID: <1157066944.1826.62.camel@timaeus.sophrosune.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aristotle.sophrosune.org ([66.167.100.107]:9839 "EHLO
	aristotle.sophrosune.org") by vger.kernel.org with ESMTP
	id S932418AbWHaX1T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Aug 2006 19:27:19 -0400
Received: from timaeus.sophrosune.org (timaeus.sophrosune.org [192.168.0.1])
	by aristotle.sophrosune.org (8.13.4/8.13.4) with ESMTP id k7VNRIuS011622
	for <linux-acpi@vger.kernel.org>; Thu, 31 Aug 2006 18:27:18 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I've got a rather old Acer TravelMate 222X for which I would *really*
like to get proper S3 support. Right now, doing an 

echo -n "mem" > /sys/power/state

suspends the machine to RAM OK. But when it tries to resume, it shows a
bit of disk activity and then hard locks - nothing on the screen, no
keyboard input is accepted, and it doesn't respond to pings. This is
using 2.6.17, entirely from text mode with no framebuffer. I've tried
various combinations of acpi_sleep parameters and noapic/lapic with no
visible effect.

I've been reading through many of the ACPI docs on the net, and have
fixed my DSDT and added it to the kernel according to those
instructions. This had no visible effect on the resume behavior. Most of
the fixes were pretty obvious, but one I wasn't sure about - perhaps
it's related to my problem. I received the error "Method local variable
is not initialized (Local0)" for the statement "Store (Local0,
\_SB.PCI0.PCI1.OBLN.PMES" in the following code block:

Method (_L0B, 0, NotSerialized)
{
  Store (0x0B, PX80)
  And (\_SB.PCI0.PCI1.OZ68.PWRS, 0xFC, \_SB.PCI0.PCI1.OZ68.PWRS)
  Or (\_SB.PCI0.PCI1.OZ68.PMES, 0x80, \_SB.PCI0.PCI1.OZ68.PMES)
  Store (Local0, \_SB.PCI0.PCI1.OBLN.PMES)
  Notify (\_SB.SLPB, 0x02)
}

Well, yeah... it's not initialized. I assumed that the second Store
statement was just a sloppy way to zero out the variable. So I replaced
"Local0" with "0x00". That compiles without error, but I don't know if
it makes sense - is there a way that Local0 can be used as something
like a global variable in this specification? 

Other than that, I'm not sure what information is helpful to fix this
problem, but I'm *more* than happy to do whatever diagnostics will shed
better light on the problem. I really want to get this working! There's
nothing of obvious interest in my logs - the machine doesn't get far
enough when it tries to resume to write anything to syslog, and nothing
during bootup looks particularly suspicious. But maybe I just don't what
I should be looking for. 

Thanks for any help you can provide,
Todd


