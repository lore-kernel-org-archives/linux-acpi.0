From: Felix Homann <fexpop@onlinehome.de>
Subject: Problem with Novatel PCMCIA card after s2ram
Date: Sat, 17 Feb 2007 14:33:06 +0100
Message-ID: <200702171433.06857.fexpop@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59884 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946728AbXBQNdL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Feb 2007 08:33:11 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

after doing a s2ram cycle my Novatel Merlin U630 card won't work, 
as /dev/ttyS0 won't be initialized (don't know the right term).

Here are some more details:

I'm running Debian/Sid on an Acer Extensa 4100 laptop with a ATI Radeon 
Mobility X600 card. I'm using the fglrx driver as s2ram won't work with the 
free driver. EVerything was working fine (except for one issue, see below) so 
far until I got my Novatel UMTS card.

If I insert the card after a fresh boot, the card is configured correctly. 
Here's an excerpt of /var/log/messages:

########
Feb 17 13:41:30 my-machine kernel: pccard: PCMCIA card inserted into slot 0
Feb 17 13:41:30 my-machine kernel: cs: memory probe 0x0c0000-0x0fffff: 
excluding 0xc0000-0xcffff 0xe0000-0xfffff
Feb 17 13:41:30 my-machine kernel: cs: memory probe 0x60000000-0x61ffffff: 
excluding 0x60000000-0x61ffffff
Feb 17 13:41:30 my-machine kernel: cs: memory probe 0xa0000000-0xa0ffffff: 
clean.
Feb 17 13:41:30 my-machine kernel: cs: memory probe 0xc8200000-0xc82fffff: 
excluding 0xc8200000-0xc821ffff
Feb 17 13:41:30 my-machine kernel: pcmcia: registering new device pcmcia0.0
Feb 17 13:41:30 my-machine kernel: pcmcia: registering new device pcmcia0.1
Feb 17 13:41:30 my-machine kernel: pcmcia: request for exclusive IRQ could not 
be fulfilled.
Feb 17 13:41:30 my-machine kernel: pcmcia: the driver needs updating to 
supported shared IRQ lines.
Feb 17 13:41:30 my-machine kernel: 0.0: ttyS0 at I/O 0x3f8 (irq = 10) is a 
16550A
Feb 17 13:41:30 my-machine kernel: pcmcia: request for exclusive IRQ could not 
be fulfilled.
Feb 17 13:41:30 my-machine kernel: pcmcia: the driver needs updating to 
supported shared IRQ lines.
Feb 17 13:41:30 my-machine kernel: 0.1: ttyS3 at I/O 0x2e8 (irq = 0) is a 
16550A
########

/dev/ttyS0 is the serial device pppd or e.g. minicom needs to talk to.

After a s2ram cycle, I get this on card insertion:

########
Feb 17 13:44:00 my-machine kernel: 0.1: ttyS3 at I/O 0x2e8 (irq = 0) is a 
16550A
########

As you see ttyS0 isn't mentioned at all. The card isn't working.

If I do a s2disk after a fresh boot, the card is working as expected. 
Moreover, if I do a s2disk after a s2ram, the card is working again.

As I've mentioned above, there has always been one issue with s2ram:

After a s2ram cycle I could not shut down the X server, as I would be left 
with a blank black screen and could not swith to a console anymore. As with 
the Novatel card, this problem does not occur after a s2disk and the 
defective behaviour get fixed by a s2disk after s2ram.

I suspect that there's something wrong with the IRQs after s2ram: Both, the 
fglrx and ttyS0 share IRQ=10.

Any idea how to fix this?

Thanks,

Felix Homann
