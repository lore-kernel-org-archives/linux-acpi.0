From: "S K" <nospamnoham@gmail.com>
Subject: Usefulness of p4-clockmod -- was --Re: cpufreq doesn't seem to work in Intel Q9300
Date: Tue, 12 Aug 2008 21:53:37 -0700
Message-ID: <514e099a0808122153o6b99ac9bo50337009adb25a4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:10744 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbYHMExi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Aug 2008 00:53:38 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2270024wri.5
        for <linux-acpi@vger.kernel.org>; Tue, 12 Aug 2008 21:53:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Adrian Bunk <bunk@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Renaming this thread to suit the real discussion.

Please use this thread for further responses not related to getting
cpufreq working in Q9300.

Thanks,
SK

On Tue, Aug 12, 2008 at 12:59 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 12 Aug 2008 21:03:02 +0200
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
>
>> Hi Arjan,
>>
>> On Mon, Aug 11, 2008 at 04:58:16PM -0700, Arjan van de Ven wrote:
>> > > Hi,
>> > >
>> > > On Mon, Aug 11, 2008 at 07:11:28AM -0700, Arjan van de Ven wrote:
>> > > > 1) when the cpu is idle (as in "idle loop C states/hlt";
>> > > > p4_clockmod doesn't mean anything.. the clock is stopped not
>> > > > just skipped. 2) when the cpu is executing code (eg non-idle),
>> > > > it takes more power for a unit of time than it takes when it's
>> > > > idle
>> > >
>> > > This statement might be true, but might also be wrong:
>> > >   a) on systems where only C1 is exported, p4-clockmod most
>> > > often equals the state the CPU is in when in C1[*],
>> >
>> > that's.. not entirely true btw.
>>
>> well, the spec isn't really clear about this. It says (IA32 Intel
>> Architecture Software Developer's Manual, Volume 3, section 13.14.3)
>> that P6 family processors did this using STPCLK#. And STPCLK# was
>> also used by the chipset to force the CPU to enter C2, IIRC.
>
> not quite.. if it does for a certain cpu, then it's only for cpus that
> support C2.
>
>
>> Do P4s only do an C1-equivalent (or even less than that) now, as they
>> do the thermal throttling internally instead of externally using
>> STPCLK#?
>
> it's basically always less (or really best case equal) than c1 just due
> to the really short duration
>>
>
>> If it's C2-equivalent vs. C1, it's a win.
>
> it's not.
>
>>So throttling would be a
>> win from this perspective on a only C1-capable PIII, but not on a P4?
>> Is that what you're trying to hint at here?
>
> not even on PIII is it a win.. it's just too short a duration
> and your C2 theory.. not sure I believe it.
>
>
>>
>> To summarize:
>>
>> (1) p6 family processors use STPCLK# initiated by the chipset for
>> thermal throttling.
>> (2) STPCLK# is also used by the chipset to make the CPU enter C2.
>
> well.... sometimes. It's more complex generally.
>
>> (3) p4-clockmod uses the STPCLK#-equivalent in p4 CPUs.
>> (4) Therefore, it is as effective as STPCLK#, and as effective as C2.
>
> This is not correct. C2 is only effective if you stay in it "long
> enough". Otherwise you pay the transition cost twice.
>
>
>> (5) STPCLK#/C2 has higher energy savings than hlt/C1.
>
> incorrect
>
>
>
> --
> If you want to reach me at my work email, use arjan@linux.intel.com
> For development, discussion and tips for power savings,
> visit http://www.lesswatts.org
>
