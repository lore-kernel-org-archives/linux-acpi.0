From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
Date: Sun, 4 Jun 2006 23:28:34 -0700
Message-ID: <986ed62e0606042328u60bb05ccode9f47b10f5cb2b1@mail.gmail.com>
References: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
	 <20060604225140.cf87519f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.201]:30263 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932428AbWFEG2f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Jun 2006 02:28:35 -0400
Received: by wx-out-0102.google.com with SMTP id h28so670628wxd
        for <linux-acpi@vger.kernel.org>; Sun, 04 Jun 2006 23:28:34 -0700 (PDT)
In-Reply-To: <20060604225140.cf87519f.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On 6/4/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sun, 4 Jun 2006 22:23:24 -0700
> "Barry K. Nathan" <barryn@pobox.com> wrote:
>
> Please don't send word-wrapped emails.

Hmm... I didn't realize it was getting wrapped. I'll try to avoid that
next time. (If my next attempt to avoid the word-wrapping fails, then
I may not have enough free time to move to a sane mailer again for 2-3
weeks.)

[snip]
> The interesting thing is that we've done sleepy things like down() just
> prior to this.  Do you have CONFIG_PREEMPT and CONFIG_DEBUG_SPINLOCK_SLEEP
> enabled?  If not, please turn them on, see what happens.

PREEMPT is enabled. DEBUG_SPINLOCK_SLEEP isn't. I'll enable it now.
-- 
-Barry K. Nathan <barryn@pobox.com>
