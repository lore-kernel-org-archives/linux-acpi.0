From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch for 2.6.35 1/1] acpi: fix bogus preemption logic
Date: Mon, 2 Aug 2010 12:53:57 -0700
Message-ID: <20100802125357.433f5845.akpm@linux-foundation.org>
References: <201007202216.o6KMGpHD020818@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38339 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753250Ab0HBTyM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Aug 2010 15:54:12 -0400
In-Reply-To: <201007202216.o6KMGpHD020818@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org, tglx@linutronix.de, francois.valenduc@tvcablenet.be, ming.m.lin@intel.com

On Tue, 20 Jul 2010 15:16:51 -0700
akpm@linux-foundation.org wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The ACPI_PREEMPTION_POINT() logic was introduced in commit 8bd108d
> (ACPICA: add preemption point after each opcode parse).  The follow up
> commits abe1dfab6, 138d15692, c084ca70 tried to fix the preemption logic
> back and forth, but nobody noticed that the usage of
> in_atomic_preempt_off() in that context is wrong.
> 
> The check which guards the call of cond_resched() is:
> 
>     if (!in_atomic_preempt_off() && !irqs_disabled())
> 
> in_atomic_preempt_off() is not intended for general use as the comment
> above the macro definition clearly says:
> 
>  * Check whether we were atomic before we did preempt_disable():
>  * (used by the scheduler, *after* releasing the kernel lock)
> 
> On a CONFIG_PREEMPT=n kernel the usage of in_atomic_preempt_off() works by
> accident, but with CONFIG_PREEMPT=y it's just broken.
> 
> The whole purpose of the ACPI_PREEMPTION_POINT() is to reduce the latency
> on a CONFIG_PREEMPT=n kernel, so make ACPI_PREEMPTION_POINT() depend on
> CONFIG_PREEMPT=n and remove the in_atomic_preempt_off() check.
> 
> Addresses https://bugzilla.kernel.org/show_bug.cgi?id=16210
> 

Why was this simply ignored?

I shall now add a cc:stable to my copy of the patch.  Please don't
merge the old version which is missing that cc.

