From: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: CONFIG_NO_HZ + CONFIG_CPU_IDLE freeze the system (Was Re: [PATCH]
	acpi : remove power from acpi_processor_cx structure)
Date: Fri, 07 Sep 2012 10:22:59 -0700
Message-ID: <504A2D73.3010702@linaro.org>
References: <1343164349-28550-1-git-send-email-daniel.lezcano@linaro.org>
	<201209062204.11288.rjw@sisk.pl> <50490920.9070204@linaro.org>
	<201209062318.42874.rjw@sisk.pl> <504A02BD.4000805@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <504A02BD.4000805-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, xen-devel-GuqFBffKawuULHF6PoxzQEEOCMrvLtNR@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frederic Weisbecker <fweisbec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 09/07/2012 07:20 AM, Daniel Lezcano wrote:
> On 09/06/2012 11:18 PM, Rafael J. Wysocki wrote:
>> On Thursday, September 06, 2012, Daniel Lezcano wrote:
>>> On 09/06/2012 10:04 PM, Rafael J. Wysocki wrote:
>>>> On Thursday, September 06, 2012, Daniel Lezcano wrote:
>>>>> On 09/06/2012 09:54 AM, Daniel Lezcano wrote:
>>>>> I fall into this issue because NETCONSOLE is set, disabling it allowed
>>>>> me to go further.
>>>>>
>>>>> Unfortunately I am facing to some random freeze on the system which
>>>>> seems to be related to CONFIG_NO_HZ=y and CONFIG_CPU_IDLE=y.
>>>>>
>>>>> Disabling one of them, make the freezes to disappear.
>>>>>
>>>>> Is it a known issue ?
>>>> Well, there are systems having problems with this configuration, but they
>>>> should be exceptional.  What system is that?
>>> It is a laptop T61p with a Core 2 Duo T9500. Nothing exceptional I
>>> believe. Maybe someone got the same issue ?
>> Is it a regression for you?
> Yes, I think so. The issue appears between v3.5 and v3.6-rc1.
>
> It is not easy to reproduce but after taking some time to dig, it seems
> to appear with this commit:
>
> 1e75fa8be9fb61e1af46b5b3b176347a4c958ca1 is the first bad commit
> commit 1e75fa8be9fb61e1af46b5b3b176347a4c958ca1
> Author: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date:   Fri Jul 13 01:21:53 2012 -0400
>
>      time: Condense timekeeper.xtime into xtime_sec
>
>      The timekeeper struct has a xtime_nsec, which keeps the
>      sub-nanosecond remainder.  This ends up being somewhat
>      duplicative of the timekeeper.xtime.tv_nsec value, and we
>      have to do extra work to keep them apart, copying the full
>      nsec portion out and back in over and over.
>
>      This patch simplifies some of the logic by taking the timekeeper
>      xtime value and splitting it into timekeeper.xtime_sec and
>      reuses the timekeeper.xtime_nsec for the sub-second portion
>      (stored in higher res shifted nanoseconds).
>
>      This simplifies some of the accumulation logic. And will
>      allow for more accurate timekeeping once the vsyscall code
>      is updated to use the shifted nanosecond remainder.
>
>      Signed-off-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>      Reviewed-by: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>      Cc: Peter Zijlstra <a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org>
>      Cc: Richard Cochran <richardcochran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>      Cc: Prarit Bhargava <prarit-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>      Link:
> http://lkml.kernel.org/r/1342156917-25092-5-git-send-email-john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>      Signed-off-by: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>
> :040000 040000 4d6541ac1f6075d7adee1eef494b31a0cbda0934
> dc5708bc738af695f092bf822809b13a1da104b6 M	kernel
>
> How to reproduce: with a laptop T61p, with a Core 2 Duo. I boot the
> kernel in busybox and wait some minutes before writing something in the
> console. At this moment, nothing appears to the console but the
> characters are echo'ed several seconds later (could be 1, 5, or 10 secs
> or more).
>
> That happens when CONFIG_CPU_IDLE and CONFIG_NO_HZ are set. Disabling
> one of them, the issue does not appear.

Thanks for bisecting this down and the heads up!

Right off I can't see what might be causing this.  Bunch of questions:

Is this a 32 or 64 bit kernel?

By your description above, it sounds like the system is still 
functioning, but there's just a high latency for key-input. Is that right?

Are other things on the system happening slowly?

Does generating interrupts by hitting/holding down the ctrl key make the 
system respond faster?

Is there any dmesg output near when it occurs?

If you don't wait that minute after boot before typing anything, does it 
still trigger later? (or is it tied to early boot?)

On a whim, does the patch below avoid the problem?

thanks
-john

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 34e5eac..2fa0e52 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1179,6 +1179,7 @@ static void update_wall_time(void)
  	timekeeping_adjust(tk, offset);
  
  
+#if 0
  	/*
  	* Store only full nanoseconds into xtime_nsec after rounding
  	* it up and add the remainder to the error difference.
@@ -1192,6 +1193,7 @@ static void update_wall_time(void)
  	tk->xtime_nsec -= remainder;
  	tk->xtime_nsec += 1ULL << tk->shift;
  	tk->ntp_error += remainder << tk->ntp_error_shift;
+#endif
  
  	/*
  	 * Finally, make sure that after the rounding
