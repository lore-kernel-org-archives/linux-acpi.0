From: Ross Zwisler <zwisler@gmail.com>
Subject: Re: [PATCH 3/6] x86, pmem: add PMEM API for persistent memory
Date: Fri, 29 May 2015 06:11:03 -0600
Message-ID: <1432901463.4282.25.camel@gmail.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com>
		<1432852553-24865-4-git-send-email-ross.zwisler@linux.intel.com>
		<5567A2C4.3040407@zytor.com>
	 <CAPcyv4jCaLzikA5wG1HjRW0UXZ0csj2JfP_Bx78CNUmUXvWZ4Q@mail.gmail.com>
	 <5567E8B5.3080801@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:32935 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbbE2MLG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2015 08:11:06 -0400
In-Reply-To: <5567E8B5.3080801@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, 2015-05-28 at 21:19 -0700, H. Peter Anvin wrote:
> On 05/28/2015 05:02 PM, Dan Williams wrote:
> > 
> > Hmm, yes, but I believe Ross (on vacation now) was following the
> > precedent set by commit cd8ddf1a2800 "x86: clflush_page_range needs
> > mfence" whereby the api handles all necessary fencing internally.
> > Shall we introduce something like __unordered_clflush_cache_range()
> > for arch_persistent_flush() to use with the understanding it will 
> > be
> > following up with the wmb() in arch_persistent_sync()?
> > 
> 
> Are we ever going to have arch_persistent_sync() without
> arch_persistent_flush()?
> 
> However, thinking about it, it would be more efficient to do all 
> flushes
> first and then have a single barrier.

Yep, we have arch_persistent_sync() without arch_persistent_flush() in
both our PMEM and ND_BLK write paths.  These use arch_persistent_copy() to get NT stores, so they don't need to manually flush/write-back 
before doing a persistent_sync().
