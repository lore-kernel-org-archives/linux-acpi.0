From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPICA: don't cond_resched() when irq_disabled or
	in_atomic
Date: Thu, 10 Dec 2009 11:09:08 +0100
Message-ID: <20091210100907.GA2446@ucw.cz>
References: <1259900760-6424-1-git-send-email-dfeng@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933596AbZLJKer@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1259900760-6424-1-git-send-email-dfeng@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaotian Feng <dfeng@redhat.com>
Cc: lenb@kernel.org, ming.m.lin@intel.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri 2009-12-04 12:26:00, Xiaotian Feng wrote:
> commit 8bd108d adds preemption point after each opcode parse, then
> a sleeping function called from invalid context bug was founded
> during suspend/resume stage. this was fixed in commit abe1dfa by
> don't cond_resched when irq_disabled. But recent commit 138d156 changes
> the behaviour to don't cond_resched when in_atomic. This makes the
> sleeping function called from invalid context bug happen again, which
> is reported in http://lkml.org/lkml/2009/12/1/371.
> 
> The fix is to cond_sched() only when preemptible, which means not in
> irq_disabled or in_atomic.
> 
> @@ -152,7 +152,7 @@ static inline void *acpi_os_acquire_object(acpi_cache_t * cache)
>  #include <linux/hardirq.h>
>  #define ACPI_PREEMPTION_POINT() \
>  	do { \
> -		if (!in_atomic_preempt_off()) \
> +		if (preemptible()) \
>  			cond_resched(); \
>  	} while (0)

Note that this is ugly as hell. It means we have two acpi
interpretters in kernel, one for preemptible, one for non-preemptible,
with very different behaviour.

It would be slightly nicer to pass the "preemptible" info explicitely,
as function parameters.

It would be even better not to need that difference.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
