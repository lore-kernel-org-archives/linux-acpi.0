From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [2/4] ACPI / battery: reorder headers alphabetically
Date: Mon, 15 Jan 2018 01:10:10 +0100
Message-ID: <20180115001010.GA5084@thinkpad>
References: <20180113115331.GA13662@thinkpad>
 <1515930919.7000.984.camel@linux.intel.com>
 <CAJZ5v0j_ZY+DvOD9c+ZOMFVefQvE3kY=Ztyq0DRqSU6TNVbnjw@mail.gmail.com>
 <20180114235033.GA10002@thinkpad>
 <CAJZ5v0hKQfRDsg_R_ZEEJrRnf8uFi5cUZ_brSME2R086zkhm7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:45619 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeAOAKR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Jan 2018 19:10:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id i186so21682514wmi.4
        for <linux-acpi@vger.kernel.org>; Sun, 14 Jan 2018 16:10:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hKQfRDsg_R_ZEEJrRnf8uFi5cUZ_brSME2R086zkhm7g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Mon, Jan 15, 2018 at 01:06:47AM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 15, 2018 at 12:50 AM, Ognjen Galić <smclt30p@gmail.com> wrote:
> > On Mon, Jan 15, 2018 at 12:40:13AM +0100, Rafael J. Wysocki wrote:
> >> On Sun, Jan 14, 2018 at 12:55 PM, Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >> > On Sat, 2018-01-13 at 12:53 +0100, Ognjen Galić wrote:
> >> >> > -#include <linux/kernel.h>
> >> >> > -#include <linux/module.h>
> >> >> > -#include <linux/types.h>
> >> >> > -#include <linux/jiffies.h>
> >> >> > #include <linux/async.h>
> >> >> > -#include <linux/dmi.h>
> >> >> > #include <linux/delay.h>
> >> >> > +#include <linux/dmi.h>
> >> >> > +#include <linux/jiffies.h>
> >> >> > +#include <linux/kernel.h>
> >> >> > +#include <linux/module.h>
> >> >> > #include <linux/slab.h>
> >> >> > #include <linux/suspend.h>
> >> >> > -#include <asm/unaligned.h>
> >> >> > +#include <linux/types.h>
> >> >>
> >> >> These changes completely break my patch:
> >> >> https://patchwork.kernel.org/patch/10142157/
> >> >>
> >> >> Can we please postpone this patch until I hear back from Rafael
> >> >> about my series, as my series does some of the things this patch
> >> >> series does (like defining pr_fmt to shorten log prints) and this
> >> >> is a much smaller changeset and would require small changes on
> >> >> conflicts compared to my series?
> >> >
> >> > Definitely on both series we need to hear from Rafael.
> >>
> >> Right, I still need to convince myself that the Ognjen's series
> >> actually works in all cases which I'm not quite sure about ATM.
> >
> > What edge cases are you concerned about?
> 
> Initialization ordering, basically.
> 
> It appears to work only under specific assumptions that are not
> guaranteed to be satisfied universally, but I need to walk though it
> again to check that.

What are you concerned about? Race conditions in the hooking portions?
