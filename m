From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI locking
Date: Thu, 1 Jun 2006 18:33:07 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB69D2493@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3630 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750825AbWFAWda convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 18:33:30 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org


>We added the spinlock support for the GPE data structures for this
>reason, that the GPE data needed to be locked at interrupt level.
>
>If it's correct to do this with the hardware lock, then we should do
>this as well

Agreed, that is the problem at hand.

And this suggests that the other locks in ACPICA should be examined
to confirm that they really need a lock that can sleep,
or see if a simple spin-lock is appropriate for any of them too.

> -- then cleanup the Linux OSL semaphore implementation,
>starting with the check for interrupt level.

I think the cleanup here may involve not using the OSL
semaphore implementation for anything other than supporting
AML Acquire(), as the other locks in ACPICA should
not need any wrapper to invoke a simple mutex.  I think this
is consistent with the quest to reduce the need for osl.c.

-Len
