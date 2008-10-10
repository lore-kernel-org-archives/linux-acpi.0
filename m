From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC][PATCH 2/2] first callers of process_deny_checkpoint()
Date: Fri, 10 Oct 2008 16:40:25 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810101637050.7059@localhost.localdomain>
References: <20081009190405.13A253CB@kernel> <200810101517.17809.rjw@sisk.pl>
 <20081010145422.GE11695@elte.hu> <200810102153.45174.rjw@sisk.pl>
 <20081010195339.GA509@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms172071pub.verizon.net ([206.46.172.71]:41915 "EHLO
	vms172071pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYJJUke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Oct 2008 16:40:34 -0400
In-reply-to: <20081010195339.GA509@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Dave Hansen <dave@linux.vnet.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>, containers@lists.linux-foundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>



On Fri, 10 Oct 2008, Ingo Molnar wrote:

> 
> * Rafael J. Wysocki <rjw@sisk.pl> wrote:
> 
> > > > Surely not ACPI-compliant.
> > > 
> > > what do you mean?
> > 
> > The ACPI spec says quite specifically what should be done while 
> > entering hibernation and during resume from hibernation.  We're not 
> > following that in the current code, but we can (gradually) update the 
> > code to become ACPI-compilant in that respect.  However, if we go the 
> > checkpointing route, I don't think that will be possible any more.
> 
> ah, i see. I did not mean to utilize any ACPI paths but simple powerdown 
> or reboot.

If we don't enter ACPI S4, and instead poweroff,
then we'll lose the capability to wake the system from
devices that are capable of waking S4, but incapable of waking S5.

ie. The power button will still work, but others may not.

cheers,
-Len

> If we checkpoint all apps to persistent disk areas (which the checkpoint 
> patches in this thread are about), then we can just reboot the kernel 
> and forget all its state.
> 
> That capability can be used to build a really robust hibernation 
> implementation IMO: we could "hibernate/kexec" over between different 
> kernel versions transparently. (only a small delay will be noticed by 
> the user - if we do it smartly with in-kernel modesetting then not even 
> the screen contents will be changed over this.)

