From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI locking
Date: Thu, 1 Jun 2006 15:49:12 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A46347C3@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54354 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750829AbWFAWtV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 18:49:21 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Again, let's get it right before any optimizations. There are a few
semaphores that appear to be possible candidates for spinlocks. The
hardware lock is one. 

What I really mean by "getting rid of the OSL" is not so much
#define-ing it away, but be performing a direct OS interface replacement
when the time comes that the source is to be 100% integrated into the
host OS. We still a ways away from that, however.


> -----Original Message-----
> From: Brown, Len
> Sent: Thursday, June 01, 2006 3:33 PM
> To: Moore, Robert
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: ACPI locking
> 
> 
> >We added the spinlock support for the GPE data structures for this
> >reason, that the GPE data needed to be locked at interrupt level.
> >
> >If it's correct to do this with the hardware lock, then we should do
> >this as well
> 
> Agreed, that is the problem at hand.
> 
> And this suggests that the other locks in ACPICA should be examined
> to confirm that they really need a lock that can sleep,
> or see if a simple spin-lock is appropriate for any of them too.
> 
> > -- then cleanup the Linux OSL semaphore implementation,
> >starting with the check for interrupt level.
> 
> I think the cleanup here may involve not using the OSL
> semaphore implementation for anything other than supporting
> AML Acquire(), as the other locks in ACPICA should
> not need any wrapper to invoke a simple mutex.  I think this
> is consistent with the quest to reduce the need for osl.c.
> 
> -Len
