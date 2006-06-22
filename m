From: "Brown, Len" <len.brown@intel.com>
Subject: RE: 2.6.17-mm1 - possible recursive locking detected
Date: Thu, 22 Jun 2006 03:51:51 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6CF0D03@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:48274 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932832AbWFVHwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2006 03:52:04 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: michal.k.k.piotrowski@gmail.com, mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

 
>> The key thing here is that our recent changes in
>> how the locks are _used_ is okay -- and I think it is.
>
>Well.  We don't know that.  We just know that this report of unokayness
>wasn't right.  With Ingo's Linux-only patch we're in a 
>position to verify
>that the locking is probably OK.

If this were really recursive, my machine would have deadlocked
instead of booting normally like it did, no?

-Len
