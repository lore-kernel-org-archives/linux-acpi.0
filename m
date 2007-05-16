From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.22 - part 2
Date: Wed, 16 May 2007 08:49:58 -0700
Message-ID: <2c0942db0705160849x50817a50h7fe413bae0093082@mail.gmail.com>
References: <200705100411.32349.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762333AbXEPPuT@vger.kernel.org>
In-Reply-To: <200705100411.32349.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 5/10/07, Len Brown <lenb@kernel.org> wrote:
> please pull from:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
[...]
> I'm not totally satisfied that we've reverse engineered
> all the bizarre Notify cases that BIOS send us, but this
> should work on the machines we've seen to date...
[...]
> commit 88db5e1489f23876a226f5393fd978ddc09dc5f9
> Author: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
> Date:   Wed May 9 23:31:03 2007 -0400
>
>     ACPI: created a dedicated workqueue for notify() execution
>
>     HP nx6125/nx6325/... machines have a _GPE handler with an infinite
>     loop sending Notify() events to different ACPI subsystems.
>
>     Notify handler in ACPI driver is a C-routine, which may call ACPI
>     interpreter again to get access to some ACPI variables
>     (acpi_evaluate_xxx).
>     On these HP machines such an evaluation changes state of some variable
>     and lets the loop above break.
>
>     In the current ACPI implementation Notify requests are being deferred
>     to the same kacpid workqueue on which the above GPE handler with
>     infinite loop is executing. Thus we have a deadlock -- loop will
>     continue to spin, sending notify events, and at the same time
>     preventing these notify events from being run on a workqueue. All
>     notify events are deferred, thus we see increase in memory consumption
>     noticed by author of the thread. Also as GPE handling is bloked,
>     machines overheat. Eventually by external poll of the same
>     acpi_evaluate, kacpid is released and all the queued notify events are
>     free to run, thus 100% cpu utilization by kacpid for several seconds
>     or more.
>
>     To prevent all these horrors it's needed to not put notify events to
>     kacpid workqueue by either executing them immediately or putting them
>     on some other thread. It's dangerous to execute notify events in
>     place, as it will put several ACPI interpreter stacks on top of each
>     other (at least 4 in case of nx6125), thus causing kernel  stack
>     overflow.
>
>     First attempt to create a new thread was done by Peter Wainwright
>     He created a bunch of threads, which were stealing work from a kacpid
>     workqueue.
>     This patch appeared in 2.6.15 kernel shipped with Ubuntu 6.06 LTS.
>
>     Second attempt was done by me, I created a new thread for each Notify
>     event. This worked OK on HP nx machines, but broke Linus' Compaq
>     n620c, by producing threads with a speed what they stopped the machine
>     completely. Thus this patch was reverted from 18-rc2 as I remember.
>     I re-made the patch to create second workqueue just for notify events,
>     thus hopping it will not break Linus' machine. Patch was tested on the
>     same HP nx machines in #5534 and #7122, but I did not received reply
>     from Linus on a test patch sent to him.
>     Patch went to 19-rc and was rejected with much fanfare again.
>     There was 4th patch, which inserted schedule_timeout(1) into deferred
>     execution of kacpid, if we had any notify requests pending, but Linus
>     decided that it was too complex (involved either changes to workqueue
>     to see if it's empty or atomic inc/dec).
>     Now you see last variant which adds yield() to every GPE execution.
>
>     http://bugzilla.kernel.org/show_bug.cgi?id=5534
>     http://bugzilla.kernel.org/show_bug.cgi?id=8385
>
>     Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>

I've just tried booting up 2.6.22-rc1-+a-day-or-two and my nx6125 has
lost fan control again. It doesn't sound like that's an expected
result of this patch series, but it seems unlikely that it's due to
anything but the ACPI merge.

Shall I bisect, or do you have enough to go on, given the long history
of grief that this laptop has caused you?
