From: Len Brown <lenb@kernel.org>
Subject: Re: Via Rhine II Looses Eth0 After ACPI
Date: Mon, 23 Jun 2008 14:05:05 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806231356200.2984@localhost.localdomain>
References: <40ef7d130806230513w10727e9cybec253c9cfd0c276@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:54132 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758271AbYFWSFe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 14:05:34 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2X00DFNGWINXS0@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 23 Jun 2008 13:05:07 -0500 (CDT)
In-reply-to: <40ef7d130806230513w10727e9cybec253c9cfd0c276@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Null Ack <nullack@gmail.com>
Cc: linux-acpi@vger.kernel.org


> irq 23: nobody cared (try
> booting with the "irqpoll" option)


Please confirm that booting with "irqpoll", as mentioned in the messages,
works around the problem.

You might find that "noapic" is a better work around.
It will disable the IOAPIC and run in legacy PIC mode.
There may be more interrupt sharing, but most users don't
notice any difference.

If this is an MP system and has MPS, it would be interesting
to boot with "acpi=noirq" and see what MPS does with this
device interrupt.  Though if it is a client system, it will
likely have no MPS and "acpi=noirq" will just put you into
PIC mode like "noapic" did.

If the issue goes away with "acpi=off" or "acpi=noirq",
then please open a sighting here:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and attach the output from
acpidump
lspci -vv
and for each of the test cases above,
the output from
dmesg -s64000
cat /proc/interrupts

thanks,
-Len

ps. the dmesg in this case is easier to read/compare
with CONFIG_PRINTK_TIME=n

