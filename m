From: Frederic Riss <frederic.riss@gmail.com>
Subject: Re: ACPI on Macbook
Date: Sat, 10 Jun 2006 06:04:30 +0000 (UTC)
Message-ID: <loom.20060610T075754-74@post.gmane.org>
References: <1149576347.660.9.camel@moonpix.desrt.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:46996 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030303AbWFJGKH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 10 Jun 2006 02:10:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Fowfa-0006R3-Kt
	for linux-acpi@vger.kernel.org; Sat, 10 Jun 2006 08:10:03 +0200
Received: from pas38-3-82-229-199-15.fbx.proxad.net ([82.229.199.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 10 Jun 2006 08:10:02 +0200
Received: from frederic.riss by pas38-3-82-229-199-15.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 10 Jun 2006 08:10:02 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Ryan Lortie <desrt <at> desrt.ca> writes:
> I have been working on getting my new Macbook working with Ubuntu dapper
> for suspend.
>[...]
> After this fix I noticed that ACPI was non-functional after reboot.
> This is because the irq9 handler gets disabled with the "nobody cared"
> message.
> 
> This happens because when the machine comes up, irq9 is high
> (level-triggered) but the ACPI code doesn't think it has anything to do.
> It therefore returns IRQ_NONE instead of IRQ_HANDLED and the kernel
> starts ignoring irq9 (preventing ACPI from working).
> 
> I found that the cause of this problem is that when the laptop returns
> from sleep the SCI_EN bit has been cleared.  
> [...]
> Currently in my custom-patched kernel I have a quick outw(1, 0x404); as
> soon as the system comes back from sleep (before re-enabling interrupts,
> even).  This fixes the problem and no spurious irq9's are issued.

Same symptoms for me on an Intel Core Duo Mac Mini (I had filed a bug about it
http://bugzilla.kernel.org/show_bug.cgi?id=6670 ). Ryan's hack does fix it as
well for me; anybody has any clue how to fix that properly ?

Fred.


