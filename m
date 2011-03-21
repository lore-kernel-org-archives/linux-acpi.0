From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: acer-wmi: rfkill and bluetooth enabling doesn't work as in
 2.6.37
Date: Mon, 21 Mar 2011 12:43:16 +0100
Message-ID: <1300707796.4052.7.camel@jlt3.sipsolutions.net>
References: <4D79E5230200002300029ADA@novprvlin0050.provo.novell.com>
	 <201103160732.15488.oldium.pro@seznam.cz>
	 <4D8116940200002300029EB1@novprvlin0050.provo.novell.com>
	 <201103202109.53484.oldium.pro@seznam.cz>
	 <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:51626 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551Ab1CULnY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Mar 2011 07:43:24 -0400
In-Reply-To: <4D87D082020000230002A29F@novprvlin0050.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: oldium.pro@seznam.cz, davem@davemloft.net, marcel@holtmann.org, Al Cho <ACho@novell.com>, Gary Lin <GLin@novell.com>, mjg59@srcf.ucam.org, linux-acpi@vger.kernel.org, linux-bluetooth@vger.kernel.org, platform-driver-x86@vger.kernel.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

[Add Alan, since you're discussing his patch why did you leave him out?]

On Mon, 2011-03-21 at 05:26 -0600, Joey Lee wrote:

> > > -#ifdef CONFIG_RFKILL_INPUT
> > > -               bool soft_blocked = !!(rfkill->state & RFKILL_BLOCK_SW);
> > > -
> > > -               if (!atomic_read(&rfkill_input_disabled))
> > > -                       __rfkill_switch_all(rfkill->type, soft_blocked);
> > > -#endif
> > > -       }
> > > +       } //else {
> > > +//#ifdef CONFIG_RFKILL_INPUT
> > > +//             bool soft_blocked = !!(rfkill->state & RFKILL_BLOCK_SW);
> > > +//
> > > +//             if (!atomic_read(&rfkill_input_disabled))
> > > +//                     __rfkill_switch_all(rfkill->type, soft_blocked);
> > > +//#endif
> > > +//     }
> > > 
> > >         rfkill_send_events(rfkill, RFKILL_OP_ADD);
> > 
> > Both work. I've tested first CONFIG_RFKILL_INPUT disabled. Second I've tried to 
> > enable CONFIG_RFKILL_INPUT, but remove the mentioned block of code. The result 
> > is working bluetooth HW switch.
> > 
> 
> Yes, that because the following patch introduce
> driver with persistent state will affect the global state only if rfkill-input
> is enabled:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b3fa1329eaf2a7b97124dacf5b663fd51346ac19

> It maybe workaround another rfkill-input issue, but causes it replicate acer-wmi's 
> bluetooth killswitch initial state (or any driver that used rfkill_init_sw_state) 
> to any new bluetooth killswitch.
> 
> It's not make sense.

I think the reason is that rfkill-input only has a global concept of
per-device states. The alternative would be to force a newly registered
rfkill device to the state that was set by rfkill-input.

Is it possible that acer-wmi reports both a hotkey event _and_ an rfkill
event?

> > Disabling CONFIG_RFKILL_INPUT works - see above. I had a look at Kconfig in 
> > net/rfkill and there is a line "default y if !EXPERT" which means (I think) 
> > that it would be enabled by default for anybody not enabling expert options. 
> > So other non-expert users would have the same troubles as I have.
> 
> I agreed your point, and I don't think rfkill-input need enable for all
> non-Expert user because it sometimes have conflict with EC or userland
> behavior.

I don't think this makes sense. Until distros routinely ship an rfkill
daemon, we absolutely need rfkill-input.

> The root cause is what I said in the above, it's hard to fix in kernel
> module because user only can choice enable/disable rfkill-input in
> Kconfig and even cann't choice it when system boot.
> 
> I thought we need:
>  - set rfkill-input to EXPERT, remove !EXPERT
>  - add a kernel option to rfkill for user can choice enable it or not
> when system boot.
>  - Add comment in Documentation/rfkill.txt for remind user can use
> urfkill daemon (or any other userland daemon) to replace rfkill-input.
> 
> Of course need rfkill experts' more professional comments for this
> topic.
> I will try to generate a patches to implement the above 3 things then
> send out to rfkill experts for review.

I disagree -- let's discuss more first.

What really happens on Acer machines when the user presses a button?
Does it generate more than one event?

johannes

