From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: ACPI: EC: GPE storm detected, transactions will use polling
 mode
Date: Sat, 15 Nov 2008 11:45:20 -0800
Message-ID: <1226778320.3137.13.camel@LiNuX>
References: <1226722577.3104.4.camel@LiNuX> <491EBB2D.70106@tuffmail.co.uk>
	 <dd18b0c30811151039i4a5e295euc4aaa52382d47bb1@mail.gmail.com>
	 <200811152019.31744.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:13468 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbYKOTpY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Nov 2008 14:45:24 -0500
Received: by wa-out-1112.google.com with SMTP id v27so940542wah.21
        for <linux-acpi@vger.kernel.org>; Sat, 15 Nov 2008 11:45:24 -0800 (PST)
In-Reply-To: <200811152019.31744.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Alexey Starikovskiy <aystarik@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Sat, 2008-11-15 at 20:19 +0100, Rafael J. Wysocki wrote:
> On Saturday, 15 of November 2008, Justin Mattock wrote:
> > On Sat, Nov 15, 2008 at 4:06 AM, Alan Jenkins
> > <alan-jenkins@tuffmail.co.uk> wrote:
> > > Rafael J. Wysocki wrote:
> > >>
> > >> On Saturday, 15 of November 2008, Alan Jenkins wrote:
> > >>
> > >>>
> > >>> On Sat, Nov 15, 2008 at 9:23 AM, Alexey Starikovskiy <aystarik@gmail.com>
> > >>> wrote:
> > >>>
> > >>>>
> > >>>> Andrew Morton wrote:
> > >>>>
> > >>>>>
> > >>>>> (cc linux-acpi)
> > >>>>>
> > >>>>> On Fri, 14 Nov 2008 20:16:17 -0800 "Justin P. Mattock"
> > >>>>> <justinmattock@gmail.com> wrote:
> > >>>>>
> > >>>>>
> > >>>>>>
> > >>>>>> just pulled the latest git today and am now noticing
> > >>>>>> the lovely gpe storm being triggered.(dmesg below);
> > >>>>>>
> > >>>>>
> > >>>>> Are any other effects observeable?
> > >>>>>
> > >>>>> I assume that 2.6.27 didn't do this.
> > >>>>>
> > >>>>>
> > >>>>
> > >>>> It did. Justin even opened a bug -- #11724.
> > >>>>
> > >>>
> > >>> In case anyone else tries to follow that, it's actually #10724 :).
> > >>>
> > >>
> > >> Yes, the "transaction in interrupt context" patch fixed that IIRC and the
> > >> one
> > >> of the patches in the recet ACPI merge broke it again.
> > >>
> > >> Justin, can you see if reverting one or more of the following commits
> > >> helps:
> > >>
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8517934ef6aaa28d6e055b98df65b31cedbd1372
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=06cf7d3c7af902939cd1754abcafb2464060cba8
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0b7084ac67fb84f0cf2f8bc02d7e0dea8521dd2d
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a2f93aeadf97e870ff385030633a73e21146815d
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=dd15f8c42af09031e27da5b4d697ce925511f2e1
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f8248434e6a11d7cd314281be3b39bbcf82fc243
> > >>
> > >> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1cfe62c8010ac56e1bd3827e30386a87cc2f3594
> > >>
> > >> (please revert in this order)?
> > >>
> > >
> > > Be aware there's a real possibility this was only a cosmetic fix (and
> > > regression).
> > >
> > > I think the original GPE storm avoidance printed that message by default.
> > >  Then the "transaction in interrupt context" made the message into a
> > > pr_debug(), - i.e. disabled it by default.  And then my "make messages more
> > > useful when GPE storm is detected" re-enabled it.
> > >
> > > IIRC, this flip-flopping is contained within 2.6.28-rc.  I.e. I don't think
> > > it will show up as a (cosmetic) regression when jumping straight from 2.6.27
> > > to 2.6.28.  Though I suspect it will shows up between certain versions of
> > > -stable.
> > >
> > > Regards
> > > Alan
> > >
> > 
> > O.K. I think I was wrong about stating
> > this was not caused by the discharging and charging of the battery.
> > to retrace my steps
> > yesterday I pulled, then  recompiled, then
> > let the system idle for a few, then once I moved the computer to the
> > other room,(unplugged/plugged the A/C adapter)
> > the light turned orange on the A/C adapter then once
> > the battery became fully charged(green light on A/C adapter)
> > the gpe storm was triggered. Once I saw the gpe storm, I rebooted
> > (under the impression the battery was in a good state),
> > instantly the gpe storm was triggered. leading me
> > to beleive this was something else.
> > So after seeing that and sending a post I used the
> > acpi_osi=Darwin option sat had a beer and worried about it tomorrow.
> > Now when I woke up, and saw the commits from rafael(thanks for the help)
> > I decided to make sure this was reproducible, So removing the acpi_osi option,
> > then let the system idled. To my amazement the
> > gpe storm was not triggered at all.
> > (even unplugging and plugging the A/C multiple times had no effect)
> > After a while thinking what the hell is going on here, I decided to discharge
> > the battery to around 97% or 5 min. and then charge to see if this
> > triggers the gpe storm. Well sure enough it did.(attached is dmesg);
> > 
> > So for now should I go and individually revert the commits; charge,
> > and discharge
> > to locate the culprit, or is this something completely different?
> 
> Well, you have only one
> "ACPI: EC: GPE storm detected, transactions will use polling mode" message in
> the log, so the EC code seems to work as expected and you _really_ have an
> interrupt storm that is worked around.
> 
> Not sure what's causing it to happen, though.
> 
> Thanks,
> Rafael

yep, 
in the past the gpe storm was triggered
instantly without messing around with the battery.
Now that seems to be fixed. This on the other hand, has something
to do with the state of the battery. i.g. going from charging to
charged.(whatever happens with those events, or props). 
The positive side is when this occurs, the system works as if nothing is
wrong. the negative side is this could of been happening as far back as
last month or even further back in history.(never thought to test this
when applying the patches a while back);
In any case I'm going to let the system idle and see if the gpe
storm is triggered. if so I'll let you know.

-- 
Justin P. Mattock <justinmattock@gmail.com>

