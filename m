From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/6] x86, pmem: add PMEM API for persistent memory
Date: Thu, 28 May 2015 21:19:01 -0700
Message-ID: <5567E8B5.3080801@zytor.com>
References: <1432852553-24865-1-git-send-email-ross.zwisler@linux.intel.com>	<1432852553-24865-4-git-send-email-ross.zwisler@linux.intel.com>	<5567A2C4.3040407@zytor.com> <CAPcyv4jCaLzikA5wG1HjRW0UXZ0csj2JfP_Bx78CNUmUXvWZ4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:55915 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbbE2ET2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 29 May 2015 00:19:28 -0400
In-Reply-To: <CAPcyv4jCaLzikA5wG1HjRW0UXZ0csj2JfP_Bx78CNUmUXvWZ4Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>

On 05/28/2015 05:02 PM, Dan Williams wrote:
> 
> Hmm, yes, but I believe Ross (on vacation now) was following the
> precedent set by commit cd8ddf1a2800 "x86: clflush_page_range needs
> mfence" whereby the api handles all necessary fencing internally.
> Shall we introduce something like __unordered_clflush_cache_range()
> for arch_persistent_flush() to use with the understanding it will be
> following up with the wmb() in arch_persistent_sync()?
> 

Are we ever going to have arch_persistent_sync() without
arch_persistent_flush()?

However, thinking about it, it would be more efficient to do all flushes
first and then have a single barrier.

	-hpa

