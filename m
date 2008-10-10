From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] first callers of process_deny_checkpoint()
Date: Sat, 11 Oct 2008 00:57:03 +0200
Message-ID: <200810110057.04204.rjw@sisk.pl>
References: <20081009190405.13A253CB@kernel> <200810102153.45174.rjw@sisk.pl> <20081010195339.GA509@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54727 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752110AbYJJWwb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Oct 2008 18:52:31 -0400
In-Reply-To: <20081010195339.GA509@elte.hu>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>, containers@lists.linux-foundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Friday, 10 of October 2008, Ingo Molnar wrote:
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
> 
> If we checkpoint all apps to persistent disk areas (which the checkpoint 
> patches in this thread are about), then we can just reboot the kernel 
> and forget all its state.
> 
> That capability can be used to build a really robust hibernation 
> implementation IMO: we could "hibernate/kexec" over between different 
> kernel versions transparently. (only a small delay will be noticed by 
> the user - if we do it smartly with in-kernel modesetting then not even 
> the screen contents will be changed over this.)

That actually should be called a migration of VM IMO and would be a useful
functionality.  Sure.

Hibernation, however, generally involves the restoration of the hardware and
most importantly _platform_ state which IMO is impossible without the ACPI
functionality, as well as wake-up, which may depend on ACPI too.

Thanks,
Rafael
