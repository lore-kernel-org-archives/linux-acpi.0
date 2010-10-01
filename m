From: Len Brown <lenb@kernel.org>
Subject: Re: Questions about ACPI and PCI interrupt routing
Date: Fri, 01 Oct 2010 02:33:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010010229120.7033@localhost.localdomain>
References: <AANLkTinoAuRE5nmwpUo9gjc-qda6y08gEZxEUvOkN2GL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33605 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483Ab0JAGdk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2010 02:33:40 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9L002NFM82GVY1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 01 Oct 2010 01:33:40 -0500 (CDT)
In-reply-to: <AANLkTinoAuRE5nmwpUo9gjc-qda6y08gEZxEUvOkN2GL@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thawan Kooburat <kthawan@gmail.com>
Cc: linux-acpi@vger.kernel.org

> Short:
> Is it possible to use static interrupt routing on a machine that
> support configurable interrupt (via PCI Link Device)? So that kernel
> will go to IOAPIC chip directly instead of using ACPI layer (such as
> _CRS method) to manage the interrupt
>
> Long:
> I am trying to resume a kernel in a machine with different hardware
> which results in many hardware miss match problem. Right now I am
> looking into the interrupt issue. The machines I am testing support
> different interrupt routing model (Dynamic and Static). I am not sure
> if a machine that support dynamic routing will also support static
> routing or not. So is it possible to force the kernel to use only
> static model only? Bypassing ACPI layer has better chance of success
> because I think that the resume kernel does not have a correct ACPI
> handler to deal with the new device.
> 
> My understanding may be incorrect because I just read a portion of
> ACPI spec and the kernel source that related to this issue.

This doesn't make any sense.

Interrupt routing configuration reflects wires on the motherboard.
If you resume a kernel image on hardware with different wires
than were you suspended, all is lost.

To do something like this, you have to un-configure
interrupts completely, and then re-probe your devices
when you resume on changed hardware.  ie. unload all your drivers.

cheers,
Len Brown, Intel Open Source Technoloy Center
