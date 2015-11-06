From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Preserve task state in reentrant calls to ___wait_event
Date: Sat, 07 Nov 2015 00:06:46 +0100
Message-ID: <53589361.gQMCOa1UoV@vostro.rjw.lan>
References: <20151106204408.GA11609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151106204408.GA11609@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Bainbridge <chris.bainbridge@gmail.com>, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lv.zheng@intel.com, mingo@redhat.com, oleg@redhat.com, aystarik@gmail.com
List-Id: linux-acpi@vger.kernel.org

On Friday, November 06, 2015 08:44:08 PM Chris Bainbridge wrote:
> In the ACPI SBS initialisation, a reentrant call to wait_event_timeout()
> causes an intermittent boot stall of several minutes usually following
> the "Switching to clocksource tsc" message. This stall is caused by:
> 
>  1. drivers/acpi/sbshc.c wait_transaction_complete() calls
>     wait_event_timeout():
> 
>  	if (wait_event_timeout(hc->wait, smb_check_done(hc),
>  			       msecs_to_jiffies(timeout)))
> 
>  2. ___wait_event sets task state to uninterruptible
> 
>  3. ___wait_event calls the "condition" smb_check_done()
> 
>  4. smb_check_done (sbshc.c) calls through to ec_read() in
>     drivers/acpi/ec.c
> 
>  5. ec_guard() is reached which calls wait_event_timeout()
> 
>  	if (wait_event_timeout(ec->wait,
>  			       ec_transaction_completed(ec),
>  			       guard))
> 
>     ie. wait_event_timeout() is being called again inside evaluation of
>     the previous wait_event_timeout() condition

Hmm.

This doesn't look quite right to me.

>  5. The EC IRQ handler calls wake_up() and wakes up the sleeping task in
>     ec_guard()
> 
>  6. The task is now in state running even though the wait "condition" is
>     still being evaluated
>
>  7. The "condition" check returns false so ___wait_event calls
>     schedule_timeout()
> 
>  8. Since the task state is running, the scheduler immediately schedules
>     it again
> 
>  9. This loop repeats for around 250 seconds event though the original
>     wait_event_timeout was only 1000ms.
> 
>     This happens because each the call to schedule_timeout() usually
>     returns immediately, taking less than 1ms, so the jiffies timeout
>     counter is not decremented. The task is now stuck in a running
>     state, and so is highly likely to get rescheduled immediately, which
>     takes less than a jiffy.
> 
> The root problem is that wait_event_timeout() does not preserve the task
> state when called by tasks that are not running. We fix this by
> preserving and restoring the task state in ___wait_event().
> 
> Signed-off-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> ---
> I am assuming here that wait_event_timeout() is supposed to support reentrant
> calls. If not, perhaps it should BUG_ON when called with a non-running task
> state, and the SBS HC / ACPI EC code needs to be fixed to stop doing this.

OK, so I'm not sure about that too.  Peter?

I'd fix the SBS HC / ACPI EC code to stop doing this regardless.

> If reentrant calls are supposed to work, then this patch will preserve the task
> state (there may be a more appropriate way to support reentrant calls than this
> exact patch, suggestions/alternatives are welcome, but this does work).

Thanks,
Rafael
