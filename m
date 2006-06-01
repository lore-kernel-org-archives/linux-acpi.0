From: "Brown, Len" <len.brown@intel.com>
Subject: ACPI locking
Date: Thu, 1 Jun 2006 03:05:18 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB69D19D5@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8839 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750708AbWFAHFq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 03:05:46 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Bob,
I've updated
http://bugzilla.kernel.org/show_bug.cgi?id=6612
(the button state clear on S3 resume bug)
asserting that acpi_set_register() needs to be able
to be called at interrupt-time, and should be using
a spin-lock underneath, not a mutex or semaphore.

I've filed
http://bugzilla.kernel.org/show_bug.cgi?id=6634
to address that specific issue and the bigger problem
that ACPICA is using semaphores when it would be more
efficient to use mutexes on Linux, and perhaps
lower overhead still to use spin-locks.

A quick scan of the locking code looks like:

1. global lock to handle OS vs EC -- a special case.
	okay.

2. acpi_gbl_gpe_lock
	only current user of
	acpi_os_create_lock()/acpi_os_delete_lock()
	acpi_os_acquire_lock()/acpi_os_release_lock()

	On Linux, 
	this translates to spin_lock_irqsave()/spin_lock_irqrestore()

3. NUM_MUTEX
	This array of mutexes is implemented using semaphores
	on Linux, and definitely could be implemented in terms of
mutexes.

	The next question is really if any of them could be implemented
	in terms of spin locks, or if they really need sleep capability.

	ACPI_MTX_HARDWARE needs to be a spin-lock to fix 6612 above.
 
4. AML Acquire/Release operators
	acpi_ex_system_wait_semaphore() seems to be the only
	place we really need to call acpi_os_wait_semaphore()
	with its timeout capabilities.

5. acpi_os_wait_semaphore(handle, units, timeout)
	units is always 1 -- the param can be deleted?

	the workaround checking in_atomic() must go --
	after any callers that are using this from
	interrupt context have
	been converted to use spinlocks.

	could we get away with "acpi_os_wait_mutex()",
	or is the semaphore capability really necessary?

	It would be intersting if we had a test that
	could verify if the timeout code actually works.
	There must be a better way of sleeping on a semaphore
	with a timeout than a loop with down_trylock()
	and schedule_timeout_interruptable(1) until the
	timeout is reached.

thanks,
-Len
