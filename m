From: Nathan Bryant <nbryant@optonline.net>
Subject: b44 driver suspend/resume (was Re: [ACPI] Re: Re: various problems
 with Acer TM654, suspend, ACAD, radeon)
Date: Wed, 25 Aug 2004 10:23:49 -0400
Sender: linux-net-owner@vger.kernel.org
Message-ID: <412CA0F5.4@optonline.net>
References: <20040820161911.GA24510@gamma.logic.tuwien.ac.at> <20040823070534.GD24853@message-id.gmane0305.slipkontur.de> <20040823103515.GH8635@gamma.logic.tuwien.ac.at> <20040824233153.GA15474@message-id.gmane0305.slipkontur.de> <20040825131109.GD6119@gamma.logic.tuwien.ac.at> <412C9980.803@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-net-owner@vger.kernel.org>
In-Reply-To: <412C9980.803@optonline.net>
To: Nathan Bryant <nbryant@optonline.net>
Cc: Norbert Preining <preining@logic.at>, Stefan Seyfried <seife@gmane0305.slipkontur.de>, acpi-devel@lists.sourceforge.net, linux-net@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Nathan Bryant wrote:
> Norbert Preining wrote:
> 
>> But: I cannot load b44 module, I always get this treadfull error, see
>> other thread about     b44: Error, poll already scheduled
> 
> 
> Right now this looks like a driver issue, since the driver isn't 
> claiming the interrupt after resume. (From your /proc/interrupts in your 
> previous email.)
> 
> Somebody needs to check if there is some code path that could prevent 
> b44 from calling request_irq()...
> 

Oops, never mind that. That's just because you hadn't ifup'd the device 
yet. But I still suspect a driver issue; your IRQ routing looks like it 
should be OK, but somebody is sending repeated interrupts. You could 
test with "acpi=noirq", but I don't think that will help.

What seems to be happening is the b44 hardware (or somebody else on 
irq5, maybe usb) is posting interrupts and the b44's status bit is never 
getting cleared.

This could be happening because the PCI card's I/O space hasn't been 
mapped. When I/O space is not mapped, you tend to read 0xFF from the I/O 
space, which would cause our IRQ handler to behave like this. I guess it 
wouldn't be mapped because the machine has just booted (resume from 
disk.) I'm not sure why the kernel doesn't seem to remap the I/O space 
when we call pci_enable_device(), but I have seen and fixed similar 
issues in 3c59x. See 
http://marc.theaimsgroup.com/?l=linux-net&m=109228179320361&w=2

Maybe what's happening here is the kernel believes I/O is already 
mapped, because it has loaded the memory image from before suspend.

I think the first step is to fix the b44 driver's suspend and resume 
callbacks. They are definitely missing some critical PCI calls.
