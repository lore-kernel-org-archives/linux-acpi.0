From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI locking
Date: Thu, 1 Jun 2006 15:22:53 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4634758@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2356 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750801AbWFAWWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 18:22:55 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

We added the spinlock support for the GPE data structures for this
reason, that the GPE data needed to be locked at interrupt level.

If it's correct to do this with the hardware lock, then we should do
this as well -- then cleanup the Linux OSL semaphore implementation,
starting with the check for interrupt level.



> -----Original Message-----
> From: Brown, Len
> Sent: Thursday, June 01, 2006 3:15 PM
> To: Moore, Robert
> Cc: 'linux-acpi@vger.kernel.org'
> Subject: RE: ACPI locking
> 
> Bob,
> I agree that mutex vs semaphore is an optimization.
> 
> However (mutex or semaphore) vs spinlock is about correctness.
> 
> 1. Linux needs to know if the lock being requested by ACPICA
>    can be accessed at interrupt time.
> 2.  Linux needs to know if ACPICA might sleep when holding the lock.
> 
> I agree about making osl.c go away.
> We've succeeded in doing this with the kmalloc()
> interface, and I'm hopeful we can do so with the
> locking interface also.  But to #define a request
> in ACPICA to multiple types of native requests,
> ACPICA must internally differentiate between the
> different types of locks that it needs.
> 
> I'm talking about spinlock vs. mutex vs. semaphore here.
> The global lock and the routine to handle ASL Acquire()
> are special cases.
> 
> -Len
