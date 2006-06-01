From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: ACPI locking
Date: Thu, 1 Jun 2006 15:04:04 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4601FA5@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46978 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750758AbWFAWEH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 18:04:07 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

I would say that we should fix the issues at hand before we even think
about fussing with the ACPI CA interfaces -- as this always seems to
break things as well.

It is ok to change the ACPICA interfaces, but other operating systems
should get a vote in this also. There is also the documentation and
other testing overhead to consider also.

As I've said, the goal has been to minimize the number of OSL/ACPICA
interfaces in order to have the smallest number of interfaces to provide
the required functionality. Just because an OS provides a dozen
different ways to allocate memory doesn't mean that we need that many
OSL interfaces. Indeed, the future plan for all hosts is to remove the
OSL and replace it with native OS calls anyway.

That said, I would say that the locking and multithreading issues can
get complex enough, we should get it working 1000% correct before we
think about optimizing interfaces.

Bob


> -----Original Message-----
> From: Brown, Len
> Sent: Thursday, June 01, 2006 2:51 PM
> To: Moore, Robert
> Cc: 'linux-acpi@vger.kernel.org'
> Subject: RE: ACPI locking
> 
> 
> >It has been a while since we have looked at the ACPICA locking
> >stuff, and I suppose now is as good a time as any. I am also
> >concerned with the Linux-only implementation and deployment of
> >the OsWaitEventsComplete interface, in terms of how the
> >locking interacts with it. (I am also concerned with why only
> >Linux has requested this interface.)
> 
> I don't know why other OSs don't need
> acpi_os_wait_events_complete().  Maybe they don't do any
> deferred processing.  But in any case, that is a different issue
> than the (simpler) one at hand.
> 
> >The historical note on the OSL semaphore interfaces is that we
> >felt that if a "mutex" object was available in the host OS, it
> >could be used for the case where the OsCreateSemaphore() call
> >specified a MaxUnits parameter of one (a binary semaphore) -
> >rather than having an entirely separate "mutex" OSL interface.
> >The OSL spinlock interfaces were added later and are currently
> >only used in a limited way. Of course, when the day comes that
> >the ACPICA code is fully integrated into the host OS, the OSL
> >interfaces will probably be replaced by native OS calls, so we
> >always thought of the OSL interface as a somewhat interim
> >oil-slick, therefore we wanted to minimize the number of
> >different interfaces to it.
> 
> Linux just recently added dedicated
> mutex entry points to optimize the case where semaphores
> were used a mutexes.
> 
> We can take advantate of the acpi_os_create_semaphore()
> trick without changing the ACPICA interface, but the problem
> is that the actual lock/unlock entry points are now different
> for mutexes and semaphores and would have to be handled
> at run-time.
> 
> So if ACPICA wants a mutex, it would be best if it asked
> for one directly and used mutex entry/exit points too.
> On an OS where mutexes and semaphores are the same,
> the OSL can (continue to) map them to the same
> create/lock/unlock routines.
> 
> More interesting is if ACPICA actually only needs a spin-lock.
> 
> The key semantic from the Linux side is that spin-locks can
> be called at interrupt context and can not be held for sleeping.
> On the other hand, mutexes and semaphores can NOT be invoked
> from interrupt context precicely because they DO support sleeping.
> 
> It would be nice if the ACPICA/OS interface can encode those
> choices and the OS can choose the appropriate types of locks
> to use.
> 
> >3) The list of global mutexes should be looked at. I suspect
> >that a couple of them are obsolete and not used or could be
> >merged with another. As far as spinlock vs. mutex, we
> >certainly may be able to replace some mutexes with spinlocks,
> >but certainly not all. The best example of where a mutex is
> >required would be the Interpreter mutex, another example would
> >be the Namespace mutex where we need to lock the namespace
> >while possibly extensive allocations take place during a
> >dynamic table load. Where we could possibly use a spinlock is
> >to replace the ACPI hardware mutex.
> 
> Agreed.  hardware mutex looks perfect for a spin-lock,
> and the others which involve memory allocation look like
> they want a mutex.  Unclear that anything needs an
> actual counting semaphore.  Looks like there are a couple
> that allocate a semaphore as locked by playing with the
> intial value, maybe these are really just mutexes too?
> 
> >5.1) We may be able to delete the units parameter for
> >OsWaitSemaphore, it's just there to match Signal.  We use the
> >units parameter with signal during global lock operations.
> >
> >5.2) As far as the semaphore timeout code in the Linux OSL
> >implementation, it is my understanding that this
> >polled-timeout code was written because (at least at the
> >time), Linux did not have a convenient interface to allow a
> >semaphore wait for a specific amount of time. It is clearly
> >very bad and should go away ASAP.
> 
> Yeah, the polling scheme looks like an invitation to starvation.
> 
> I think the solution is probably something like...
> 
> Set up a timeout() on the maximum duration and invoke
> mutex_lock_interruptable().  If the timeout expires,
> the handler sends a signal to break the locked task out of
> mutex_lock_interruptable().  If the task gets the lock,
> then cancel the timeout.
> 
> I'd imagine that there must be someplace else in the kernel that
> wants a mutex with a timeout, but a quick look and I don't see
> this scheme elsewhere, so maybe there is a simpler way?
> 
> > Also, now that Linux has
> >mutex interfaces in addition to semaphore interfaces, it would
> >be best to migrate the use of binary semaphores to mutexes in
> >the Linux OSL.
> 
> The init is easy.  The question is if you want to look up in
> a list on every lock/unlock the type of lock you have.
> I think the answer is no, and that the code should ask
> for the appropriate init/lock/unlock for the 3 types of
> locks that are available:
> 
> 1. spin lock that can be at interrupt context, but can sleep with it
> 2. mutex that can sleep, but illegal at interupt context
> 3. counting semaphore that can sleep, but illegal at interrupt context
> 
> >Hopefully, the new mutex interfaces in Linux
> >allow a simple timeout, that may remove the need for a timeout
> >on a semaphore wait entirely.
> 
> I don't think the timeout on semaphore wait is the biggest problem
here.
> The biggest problem is the lack of clarity between locks that can
> be called at interrupt level and locks that can sleep.  I think that
> distinction needs to be in the ACPICA/OS interface.
> 
> The semaphore with timeout appears to be only needed to execute ASL
> Acquire().
> While it has to work and it would be nice if it were efficient and
> starvation and delay resistant, in practice it probably executes far
less
> frequently than the other simple locks in the code which should
> be implemented in the most efficient way possible.
> 
> cheers,
> -Len
