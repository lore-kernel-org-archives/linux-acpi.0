From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/4] ACPI / CPPC: Optimize PCC Read Write operations
Date: Tue, 16 Feb 2016 20:39:27 +0100
Message-ID: <13141226.tTSRZNDOBm@vostro.rjw.lan>
References: <1455134762-31400-1-git-send-email-pprakash@codeaurora.org> <CAJZ5v0hjg2XzKkrmKLXskUQeXkf_WRK2xrWzqfyjq71d7y0ypQ@mail.gmail.com> <CAJ5Y-eZMWDrZfPJW07fgcMQ0n3K6Vybik3ArKzM2vJqEW147Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41440 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755622AbcBPTiG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2016 14:38:06 -0500
In-Reply-To: <CAJ5Y-eZMWDrZfPJW07fgcMQ0n3K6Vybik3ArKzM2vJqEW147Uw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alexey Klimov <alexey.klimov@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, linux acpi <linux-acpi@vger.kernel.org>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Timur Tabi <timur@codeaurora.org>

On Tuesday, February 16, 2016 02:33:00 PM Ashwin Chaugule wrote:
> Hi Rafael,
> 
> On 16 February 2016 at 14:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Feb 16, 2016 at 7:47 PM, Ashwin Chaugule
> > <ashwin.chaugule@linaro.org> wrote:
> >> Hi Alexey,
> >>
> >> On 15 February 2016 at 11:37, Alexey Klimov <alexey.klimov@arm.com> wrote:
> >>> Hi Prashanth and Ashwin,
> >>>
> >>> On Wed, Feb 10, 2016 at 01:05:59PM -0700, Prashanth Prakash wrote:
> >>>> From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >>>>
> >>>> Previously the send_pcc_cmd() code checked if the
> >>>> PCC operation had completed before returning from
> >>>> the function. This check was performed regardless
> >>>> of the PCC op type (i.e. Read/Write). Knowing
> >>>> the type of cmd can be used to optimize the check
> >>>> and avoid needless waiting. e.g. with Write ops,
> >>>> the actual Writing is done before calling send_pcc_cmd().
> >>>> And the subsequent Writes will check if the channel is
> >>>> free at the entry of send_pcc_cmd() anyway.
> >>>>
> >>>> However, for Read cmds, we need to wait for the cmd
> >>>> completion bit to be flipped, since the actual Read
> >>>> ops follow after returning from the send_pcc_cmd(). So,
> >>>> only do the looping check at the end for Read ops.
> >>>>
> >>>> Also, instead of using udelay() calls, use ktime as a
> >>>> means to check for deadlines. The current deadline
> >>>> in which the Remote should flip the cmd completion bit
> >>>> is defined as N * Nominal latency. Where N is arbitrary
> >>>> and large enough to work on slow emulators and Nominal
> >>>> latency comes from the ACPI table (PCCT). This helps
> >>>> in working around the CONFIG_HZ effects on udelay()
> >>>> and also avoids needing different ACPI tables for Silicon
> >>>> and Emulation platforms.
> >>>>
> >>>> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> >>>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> >>>> ---
> >>>>  drivers/acpi/cppc_acpi.c | 99 ++++++++++++++++++++++++++++++++++--------------
> >>>>  1 file changed, 71 insertions(+), 28 deletions(-)
> >>
> >> [..]
> >>
> >>>> -     u32 cmd_latency = pcct_ss->latency;
> >>>>
> >>>> -     /* Min time OS should wait before sending next command. */
> >>>> -     udelay(pcc_cmd_delay);
> >>>
> >>> Ouch.
> >>> This delay is Minimum Request Turnaround Time and specification is strict about this:
> >>> The minimum amount of time that OSPM must wait after the
> >>> completion of a command before issuing the next command, in microseconds.
> >>>
> >>> And you're going to completely remove delay that described as "must wait" regardless if it's
> >>> write or read command. In my view completion of a command is when CMD complete bit is set to 1.
> >>> This field in table is not optional.
> >>
> >> The spec has a whole bunch of delays which are highly questionable.
> >
> > Why does your opinion matter here if I may ask?
> >
> 
> We asked the folks who added those delays to the spec before making
> this change. So this is not unfounded.

That's fine, but then the authors of the firmware your code has to deal
with may not have that conversation and may expect certain type of behavior
from it (as indicated by the spec).

> > If everybody follows this line of reasoning, there's no point in
> > having any specifications in the first place.
> >
> > If you don't like the spec, please submit requests to modify it.  Or
> > follow it otherwise.
> 
> But I agree that for the sake of spec correctness we should include
> this delay and let firmware choose what value to put in it and deal
> with the latencies for each request.
> 
> >
> >> e.g. the Min Request Turnaround time and the Max periodic access rate.
> >> Both seem quite useless since their original intention was to avoid
> >> the OS from flooding the BMC. But one can argue that the firmware can
> >> throttle the OS requests via the Command Completion bit anyway.
> >
> > Yes, they can.  What does that have to do with the other fields?
> 
> If the intention was only to control the OS request rate, then why
> isnt Command Completion sufficient for that purpose? The firmware can
> flip the command complete bit only when it is ready to receive the
> next request.
> 
> >
> >> I also didnt like the usage of udelays and prefer the ktime math, but that
> >> seems overkill given the questionable value of these fields.
> >>
> >>>
> >>> Even worse, what if platform report latency = 0 (or very close to zero) and turnaround time as very large number?
> >>>
> >>
> >> Such a firmware would need serious rework. Besides, if for whatever
> >> reason they choose to have it, the command complete bit can be used to
> >> throttle the OS requests.
> >
> > Yes, it can.  Is that a good enough argument for not respecting the
> > spec on the OS side?  I don't think so.
> 
> In principle I agree, but with CPPC, these fields seemed redundant,
> hence the patch. But I'm not strongly opposed either way, so we'll add
> the latency field back and leave it up to the platform and vendors.

Sounds good.

Thanks,
Rafael

