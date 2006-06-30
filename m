From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH -mm 5/6] cpu_relax(): use in ACPI lock
Date: Fri, 30 Jun 2006 15:28:29 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6E16C60@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50588 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S964924AbWF3T23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2006 15:28:29 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

>> I may be interpreting this incorrectly, but are you 
>> busy-waiting on the ACPI Global Lock to become free?

No.

>Loop may be correctly waiting for the owner/pending bit to be 
>set, just checking, I don't remember all the bit values.

Yes.

__acpi_acquire_global_lock is basically a lock-try
and set the pending bit on failure.

bit 0 is the PENDING bit
bit 1 is the OWNED bit

so the loop is doing this:

	old = lock_value
try_again:
	new = OWNED
	if (old & OWNED)
		new |= PENDING
	cmpxchg(lock_value, old, new)
	if (old != new) goto try_again;

	return(!(new & PENDING)) /* ACQUIRED or not */


so we loop only if somebody else changed the lock_value
to be different from old at the same time this code did.

if the lock were held, we simply set the pending bit
and return that we failed to acquire the lock.

-Len
