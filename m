From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [2/4] ACPI / battery: reorder headers alphabetically
Date: Mon, 15 Jan 2018 00:50:33 +0100
Message-ID: <20180114235033.GA10002@thinkpad>
References: <20180113115331.GA13662@thinkpad>
 <1515930919.7000.984.camel@linux.intel.com>
 <CAJZ5v0j_ZY+DvOD9c+ZOMFVefQvE3kY=Ztyq0DRqSU6TNVbnjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38050 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeANXul (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Jan 2018 18:50:41 -0500
Received: by mail-wr0-f194.google.com with SMTP id x1so5868331wrb.5
        for <linux-acpi@vger.kernel.org>; Sun, 14 Jan 2018 15:50:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j_ZY+DvOD9c+ZOMFVefQvE3kY=Ztyq0DRqSU6TNVbnjw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jan 15, 2018 at 12:40:13AM +0100, Rafael J. Wysocki wrote:
> On Sun, Jan 14, 2018 at 12:55 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, 2018-01-13 at 12:53 +0100, Ognjen Galić wrote:
> >> > -#include <linux/kernel.h>
> >> > -#include <linux/module.h>
> >> > -#include <linux/types.h>
> >> > -#include <linux/jiffies.h>
> >> > #include <linux/async.h>
> >> > -#include <linux/dmi.h>
> >> > #include <linux/delay.h>
> >> > +#include <linux/dmi.h>
> >> > +#include <linux/jiffies.h>
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > #include <linux/slab.h>
> >> > #include <linux/suspend.h>
> >> > -#include <asm/unaligned.h>
> >> > +#include <linux/types.h>
> >>
> >> These changes completely break my patch:
> >> https://patchwork.kernel.org/patch/10142157/
> >>
> >> Can we please postpone this patch until I hear back from Rafael
> >> about my series, as my series does some of the things this patch
> >> series does (like defining pr_fmt to shorten log prints) and this
> >> is a much smaller changeset and would require small changes on
> >> conflicts compared to my series?
> >
> > Definitely on both series we need to hear from Rafael.
> 
> Right, I still need to convince myself that the Ognjen's series
> actually works in all cases which I'm not quite sure about ATM.

What edge cases are you concerned about?

> 
> > The usual approach, how I understand the process, the first pushed is
> > first served,
> 
> Right, and the first pushed one need not be the first submitted one, of course.
> 
> > and a quite normal situation that the one, which had been
> > send later, comes to repository first. But see above, we definitely rely
> > on maintainer's decision here.
> >
> > P.S. AFAIU both series are rebased on top of linux-pm, correct? (At
> > least I'm sure about this one)

Incorrect, mine is rebased on Linus's tree.

> 
> I prefer stuff based on the Linus' tree, however, as that often makes
> it more straightforward to handle it for me.
> 
> Thanks,
> Rafael
