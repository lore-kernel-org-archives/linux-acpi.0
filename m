From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI locking
Date: Thu, 1 Jun 2006 18:15:07 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB69D2473@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26629 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750728AbWFAWPM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 18:15:12 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Bob,
I agree that mutex vs semaphore is an optimization.

However (mutex or semaphore) vs spinlock is about correctness.

1. Linux needs to know if the lock being requested by ACPICA
   can be accessed at interrupt time.
2.  Linux needs to know if ACPICA might sleep when holding the lock.

I agree about making osl.c go away.
We've succeeded in doing this with the kmalloc()
interface, and I'm hopeful we can do so with the
locking interface also.  But to #define a request
in ACPICA to multiple types of native requests,
ACPICA must internally differentiate between the
different types of locks that it needs.

I'm talking about spinlock vs. mutex vs. semaphore here.
The global lock and the routine to handle ASL Acquire()
are special cases.

-Len
