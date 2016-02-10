From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH V3 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Wed, 10 Feb 2016 15:57:45 -0600
Message-ID: <56BBB259.2030600@codeaurora.org>
References: <1455134762-31400-1-git-send-email-pprakash@codeaurora.org>
 <1455134762-31400-2-git-send-email-pprakash@codeaurora.org>
 <56BBA0CB.2000504@codeaurora.org>
 <CAJ5Y-eZ7u7WdC3BX7ok=cvck9pOREOJzzB4J0cKsQt2rgK8LHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49371 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbcBJV5s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2016 16:57:48 -0500
In-Reply-To: <CAJ5Y-eZ7u7WdC3BX7ok=cvck9pOREOJzzB4J0cKsQt2rgK8LHQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Prashanth Prakash <pprakash@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Alexey Klimov <alexey.klimov@arm.com>

Ashwin Chaugule wrote:
> ..Only to be re substituted by the macro all over again. So, there
> really is no value in replacing this with a macro.  Also,
> readx_relaxed_poll_timeout() has a usleep(), which will kill all the
> optimization here. Its also horribly wrong in this context.
>
> The alternative readx_poll_timeout_atomic() has a udelay() but it also
> adds way more conditionals than this code. So, there is no need to
> change things for the sake of cosmetic reasons.

This is not a cosmetic change.  Calling a built-in macro instead of 
re-inventing the wheel is not cosmetic.  That's like saying that people 
shouldn't bother using min() or max() because they can just calculate 
the minimum and maximum themselves.  The macros exist for a reason, and 
people should be using them when applicable.

Also, the number of conditionals is not really much of an issue, I think.

The while loop has two conditionals:

1) The while-expression !ktime_after(ktime_get(), next_deadline)
2) The if-statement readw_relaxed(&generic_comm_base->status) & 
PCC_CMD_COMPLETE

readl_relaxed_poll_timeout_atomic() has four:

1) if (cond) break;
2) if (timeout_us && ktime_compare(ktime_get(), timeout) > 0)
3) if (delay_us) udelay(delay_us);	
4) (cond) ? 0 : -ETIMEDOUT; \

The third one is compiled-out because delay_us is a constant.  The 
fourth test is to handle the race condition between timeout and success. 
  If we time out, but the register value changes at the last 
microsecond, then we report success anyway.

And since this is a macro instead of a function, the code is generally 
optimized better.  The compiler typically can optimize macros better 
than functions, so there's still a chance that the macro version will be 
more optimized than the function anyway.

Finally, there's the convention of using a built-in macro/function over 
hand-coding something, even if it's not quite as optimized.  I don't 
think check_pcc_chan() is that time-critical that a single additional 
conditional is really a problem.  This while-loop really does re-invent 
the wheel.

Anyway, I don't want to belabor this point.  The decision is Rafael's now.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
