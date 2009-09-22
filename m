From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 2/8] arch/x86/kernel/cpu/cpufreq/acpi-cpufreq.c: avoid cross-CPU interrupts by using smp_call_function_any()
Date: Tue, 22 Sep 2009 16:47:38 +0930
Message-ID: <200909221647.40106.rusty@rustcorp.com.au>
References: <200909181941.n8IJf5oR002397@imap1.linux-foundation.org> <20090918195953.GB7413@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47934 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751802AbZIVHRi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Sep 2009 03:17:38 -0400
In-Reply-To: <20090918195953.GB7413@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: akpm@linux-foundation.org, lenb@kernel.org, linux-acpi@vger.kernel.org, efault@gmx.de, jaswinder@kernel.org, len.brown@intel.com, mingo@elte.hu, tglx@linutronix.de, venkatesh.pallipadi@intel.com, yakui.zhao@intel.com, yanmin_zhang@linux.intel.com

On Sat, 19 Sep 2009 05:29:53 am Dave Jones wrote:
> I'm ok with this going in, but I still wonder if we could have done it
> all a lot easier, by making cpumask_any pick the current cpu if it was
> in the mask instead of introducing yet another variant to an already
> enormous api.

That was the initial proposal, but I'm uncomfortable with that, too.  "any"
really implies "doesn't matter"; if we overload it to have a preference, it
becomes really hard to tell which ones really care and which ones don't.

Then refactoring becomes harder (performance regression when you alter code).

So yeah, not ideal, but this seemed like the minimal API extension.

Cheers,
Rusty.
