From: Lee Howard <faxguy@howardsilvan.com>
Subject: controlling ACPI IRQ routing
Date: Thu, 27 Dec 2007 14:00:35 -0800
Message-ID: <47742083.5060903@howardsilvan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from frodo.howardsilvan.com ([66.119.206.113]:49044 "EHLO
	mail.howardsilvan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbXL0WIn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Dec 2007 17:08:43 -0500
Received: from bilbo.x101.com (localhost.localdomain [127.0.0.1])
	by mail.howardsilvan.com (Postfix) with ESMTP id 95AA4C0080
	for <linux-acpi@vger.kernel.org>; Thu, 27 Dec 2007 14:00:35 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello.

I frequently work with certain Asterisk-compatible PCI telephony 
interfaces that use the "zaptel" module/driver.  This module generates 
1000 interrupts per second (yes, I know...) and any noticeable latency 
in handling that interrupt can cause significant problems for modulated 
data audio (such as fax) passing through those telephony interfaces.

It's become apparent that IRQ priorities seem to have to a lot to do 
with the performance of the zaptel driver.  For example, if the zaptel 
device sits on interrupt 16, and the network interfaces and hard drive 
interfaces are on higher-numbered interrupts then things tend to go 
well.  But if the zaptel device sits on interrupt 19, and the network 
interfaces and hard drive interfaces are on lesser-numbered interrupts 
(such as 16, 17, and 18) then things tend to go poorly.

The zaptel driver comes with a utility called "zttest" which basically 
indicates the reliability for the application to retrieve audio samples 
from the device driver before too much time passes... or in other words, 
the latency (or lack thereof) in handling device interrupts.  A good 
zttest score on a well-configured system is 100%, although scores as low 
as 99.98% seem to be tolerable for modulated data audio.  However, 
anything less... 99.97%, 99.96, I've even seen 99.91% and worse... these 
constitute poor scores and inevitably indicate that audio samples will 
be lost during usage.  (You can see that the difference between "good" 
and "poor" is rather a narrow margin.) Lost audio samples is tolerable 
for voice applications, but it is detrimental to data/fax applications.

Usually the trick, then, has been to simply start rearranging the PCI 
cards in the system and disabling unused devices (such as serial, 
parallel, and USB ports with the respective drivers) until some 
combination was reached where zttest scores were good - inevitably 
meaning that the device had a high-priority (low-numbered) interrupt.

Recently this trick is seemingly more and more difficult to perform... 
and it's especially difficult in cases where (like on a 1U rack-mount 
server) there is but one PCI slot and the motherboard BIOS offers no 
helpful IRQ configuration mechanism.  For example, a recent installation 
of Fedora 8 on such a server put the zaptel device at a low-priority 
interrupt.  After hours of futile BIOS option changes and tests and even 
after testing a kernel (2.6.23.11) patched with Ingo Molnar's "rt" 
Real-Time patches (and using chrt for the associated IRQ to increase 
priority) nothing seemed to help.  Then I simply reverted to an old 
2.6.20 kernel from Fedora Core 5 that we had used successfully on 
previous deployments on similar hardware... and all was fine.  And, of 
course, the apparent difference was that the 2.6.23.11 kernel put the 
device interrupt high-numbered while the 2.6.20 kernel put the device 
interrupt low-numbered.

Sometimes, however, it's just not ideal ... or even possible ... to 
downgrade to a "known good" kernel.  It's certainly not desirable.  So 
my question is, "How can we deliberately control the IRQ routing 
assignments made by ACPI so that certain PCI devices get the 
highest-priority interrupts?"

I've looked into the pirq kernel option ... only to find that it's 
insanely difficult to understand *how* to use... and simply trying it 
out with various values doesn't seem to accomplish much as far as I can 
tell.  (Yes, I have read Documentation/i386/IO-APIC.txt many times... 
not that it reading it makes the pirq usage any easier to understand.)

I've looked into the setpci utility... but besides the man page for it 
being mostly unhelpful, it's difficult to know whether or not using 
setpci will actually do anything for us in this respect, as there seems 
to be a lot of conflicting information in various posts and mail 
archives on whether or not an IRQ assignment can actually be changed by 
using setpci.  And then there's the fear that by using setpci 
incorrectly I may actually break the hardware.

I'm fairly certain that this is simply a matter of ACPI tuning... 
because with one kernel the interrupt assignments are one way while with 
another kernel the interrupt assignments are a different way... and both 
kernels use IO-APIC and IRQ routing by ACPI.

I would appreciate any feedback or assistance in this matter.  How can 
we deliberately control the IRQ routing assignments made by ACPI so that 
certain PCI devices get the highest-priority interrupts?

Thanks,

Lee.
