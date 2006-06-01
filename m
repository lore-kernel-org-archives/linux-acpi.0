From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI locking
Date: Thu, 1 Jun 2006 11:43:06 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4601D05@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27436 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965116AbWFASnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 14:43:14 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

It has been a while since we have looked at the ACPICA locking stuff,
and I suppose now is as good a time as any. I am also concerned with the
Linux-only implementation and deployment of the OsWaitEventsComplete
interface, in terms of how the locking interacts with it. (I am also
concerned with why only Linux has requested this interface.)

The historical note on the OSL semaphore interfaces is that we felt that
if a "mutex" object was available in the host OS, it could be used for
the case where the OsCreateSemaphore() call specified a MaxUnits
parameter of one (a binary semaphore) - rather than having an entirely
separate "mutex" OSL interface. The OSL spinlock interfaces were added
later and are currently only used in a limited way. Of course, when the
day comes that the ACPICA code is fully integrated into the host OS, the
OSL interfaces will probably be replaced by native OS calls, so we
always thought of the OSL interface as a somewhat interim oil-slick,
therefore we wanted to minimize the number of different interfaces to
it.

3) The list of global mutexes should be looked at. I suspect that a
couple of them are obsolete and not used or could be merged with
another. As far as spinlock vs. mutex, we certainly may be able to
replace some mutexes with spinlocks, but certainly not all. The best
example of where a mutex is required would be the Interpreter mutex,
another example would be the Namespace mutex where we need to lock the
namespace while possibly extensive allocations take place during a
dynamic table load. Where we could possibly use a spinlock is to replace
the ACPI hardware mutex.

5.1) We may be able to delete the units parameter for OsWaitSemaphore,
it's just there to match Signal.  We use the units parameter with signal
during global lock operations.

5.2) As far as the semaphore timeout code in the Linux OSL
implementation, it is my understanding that this polled-timeout code was
written because (at least at the time), Linux did not have a convenient
interface to allow a semaphore wait for a specific amount of time. It is
clearly very bad and should go away ASAP. Also, now that Linux has mutex
interfaces in addition to semaphore interfaces, it would be best to
migrate the use of binary semaphores to mutexes in the Linux OSL.
Hopefully, the new mutex interfaces in Linux allow a simple timeout,
that may remove the need for a timeout on a semaphore wait entirely.

I will continue to look at these issues further.

Bob





> -----Original Message-----
> From: Brown, Len
> Sent: Thursday, June 01, 2006 12:05 AM
> To: Moore, Robert
> Cc: linux-acpi@vger.kernel.org
> Subject: ACPI locking
> 
> Bob,
> I've updated
> http://bugzilla.kernel.org/show_bug.cgi?id=6612
> (the button state clear on S3 resume bug)
> asserting that acpi_set_register() needs to be able
> to be called at interrupt-time, and should be using
> a spin-lock underneath, not a mutex or semaphore.
> 
> I've filed
> http://bugzilla.kernel.org/show_bug.cgi?id=6634
> to address that specific issue and the bigger problem
> that ACPICA is using semaphores when it would be more
> efficient to use mutexes on Linux, and perhaps
> lower overhead still to use spin-locks.
> 
> A quick scan of the locking code looks like:
> 
> 1. global lock to handle OS vs EC -- a special case.
> 	okay.
> 
> 2. acpi_gbl_gpe_lock
> 	only current user of
> 	acpi_os_create_lock()/acpi_os_delete_lock()
> 	acpi_os_acquire_lock()/acpi_os_release_lock()
> 
> 	On Linux,
> 	this translates to spin_lock_irqsave()/spin_lock_irqrestore()
> 
> 3. NUM_MUTEX
> 	This array of mutexes is implemented using semaphores
> 	on Linux, and definitely could be implemented in terms of
mutexes.
> 
> 	The next question is really if any of them could be implemented
> 	in terms of spin locks, or if they really need sleep capability.
> 
> 	ACPI_MTX_HARDWARE needs to be a spin-lock to fix 6612 above.
> 
> 4. AML Acquire/Release operators
> 	acpi_ex_system_wait_semaphore() seems to be the only
> 	place we really need to call acpi_os_wait_semaphore()
> 	with its timeout capabilities.
> 
> 5. acpi_os_wait_semaphore(handle, units, timeout)
> 	units is always 1 -- the param can be deleted?
> 
> 	the workaround checking in_atomic() must go --
> 	after any callers that are using this from
> 	interrupt context have
> 	been converted to use spinlocks.
> 
> 	could we get away with "acpi_os_wait_mutex()",
> 	or is the semaphore capability really necessary?
> 
> 	It would be intersting if we had a test that
> 	could verify if the timeout code actually works.
> 	There must be a better way of sleeping on a semaphore
> 	with a timeout than a loop with down_trylock()
> 	and schedule_timeout_interruptable(1) until the
> 	timeout is reached.
> 
> thanks,
> -Len
