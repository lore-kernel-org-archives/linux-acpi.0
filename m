From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] mailbox: pcc: fix channel calculation in get_pcc_channel()
Date: Wed, 03 Feb 2016 02:22:41 +0100
Message-ID: <2389061.LRLPThh2pc@vostro.rjw.lan>
References: <CAJ5Y-eYdPM+hSZdH_Sz10K6iHb0cCB1E4Wh_A_sJn_yyLgLjZQ@mail.gmail.com> <CAJZ5v0h1yVsSYVz==VD3a2w8N-1yePn0XvN54c6BTwxMk7w1uw@mail.gmail.com> <CABb+yY0GkUpSo+T4_8m=PKVf0JSBFZdFvgZdRy_i_vEmPRnuGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:42275 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755128AbcBCBVj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2016 20:21:39 -0500
In-Reply-To: <CABb+yY0GkUpSo+T4_8m=PKVf0JSBFZdFvgZdRy_i_vEmPRnuGg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Alexey Klimov <alexey.klimov@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tuesday, February 02, 2016 04:42:52 PM Jassi Brar wrote:
> On Tue, Feb 2, 2016 at 2:21 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Feb 1, 2016 at 4:43 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >> On Mon, Feb 1, 2016 at 8:49 PM, Alexey Klimov <alexey.klimov@arm.com> wrote:
> >>> (adding Rafael and linux-acpi)
> >>>
> >>> On Fri, Jan 15, 2016 at 6:22 PM, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> >>>> + Jassi (Linaro addr)
> >>>>
> >>>> On 15 January 2016 at 13:20, Ashwin Chaugule <ashwin.chaugule@linaro.org> wrote:
> >
> > [cut]
> >
> >>>>> Can you please include this patch in your pull request to Linus?
> >>>
> >>> Hi Rafael,
> >>>
> >>> any chance you can take this fix via your tree?
> >>> I can resend patch if you want.
> >>> Looks like Jassi doesn't have time or doesn't care.
> >>>
> >> Ouch... sorry. Ashwin's reminder came after I had sent the pull
> >> request. And then it just got overlooked. If Rafael doesn't pick it as
> >> my punishment, I'll tomorow :)
> >
> > I can apply it, but can anyone please point me to the original patch?
> >
> > Or, maybe better, resend it with a CC to linux-acpi and all of the
> > tags collected so far?
> >
> or even simpler ... I queued it already
> https://git.linaro.org/landing-teams/working/fujitsu/integration.git/log/refs/heads/mailbox-devel
>  ?

That works for me too. :-)

