From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [2/4] ACPI / battery: reorder headers alphabetically
Date: Mon, 29 Jan 2018 04:05:28 +0100
Message-ID: <CAJZ5v0goEsJjtbtBU5gdJ2mjKif-NqejmVsmjLWbDBRH1-J+Gg@mail.gmail.com>
References: <20180113115331.GA13662@thinkpad> <1515930919.7000.984.camel@linux.intel.com>
 <CAJZ5v0j_ZY+DvOD9c+ZOMFVefQvE3kY=Ztyq0DRqSU6TNVbnjw@mail.gmail.com>
 <20180114235033.GA10002@thinkpad> <CAJZ5v0hKQfRDsg_R_ZEEJrRnf8uFi5cUZ_brSME2R086zkhm7g@mail.gmail.com>
 <20180127072940.GA839@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35334 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbeA2DF3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Jan 2018 22:05:29 -0500
Received: by mail-oi0-f42.google.com with SMTP id b11so4033746oif.2
        for <linux-acpi@vger.kernel.org>; Sun, 28 Jan 2018 19:05:29 -0800 (PST)
In-Reply-To: <20180127072940.GA839@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Ognjen_Gali=C4=87?= <smclt30p@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, Jan 27, 2018 at 8:29 AM, Ognjen Gali=C4=87 <smclt30p@gmail.com> wro=
te:
> On Mon, Jan 15, 2018 at 01:06:47AM +0100, Rafael J. Wysocki wrote:
>> On Mon, Jan 15, 2018 at 12:50 AM, Ognjen Gali=C4=87 <smclt30p@gmail.com>=
 wrote:
>> > On Mon, Jan 15, 2018 at 12:40:13AM +0100, Rafael J. Wysocki wrote:
>> >> On Sun, Jan 14, 2018 at 12:55 PM, Andy Shevchenko
>> >> <andriy.shevchenko@linux.intel.com> wrote:
>> >> > On Sat, 2018-01-13 at 12:53 +0100, Ognjen Gali=C4=87 wrote:
>> >> >> > -#include <linux/kernel.h>
>> >> >> > -#include <linux/module.h>
>> >> >> > -#include <linux/types.h>
>> >> >> > -#include <linux/jiffies.h>
>> >> >> > #include <linux/async.h>
>> >> >> > -#include <linux/dmi.h>
>> >> >> > #include <linux/delay.h>
>> >> >> > +#include <linux/dmi.h>
>> >> >> > +#include <linux/jiffies.h>
>> >> >> > +#include <linux/kernel.h>
>> >> >> > +#include <linux/module.h>
>> >> >> > #include <linux/slab.h>
>> >> >> > #include <linux/suspend.h>
>> >> >> > -#include <asm/unaligned.h>
>> >> >> > +#include <linux/types.h>
>> >> >>
>> >> >> These changes completely break my patch:
>> >> >> https://patchwork.kernel.org/patch/10142157/
>> >> >>
>> >> >> Can we please postpone this patch until I hear back from Rafael
>> >> >> about my series, as my series does some of the things this patch
>> >> >> series does (like defining pr_fmt to shorten log prints) and this
>> >> >> is a much smaller changeset and would require small changes on
>> >> >> conflicts compared to my series?
>> >> >
>> >> > Definitely on both series we need to hear from Rafael.
>> >>
>> >> Right, I still need to convince myself that the Ognjen's series
>> >> actually works in all cases which I'm not quite sure about ATM.
>> >
>> > What edge cases are you concerned about?
>>
>> Initialization ordering, basically.
>>
>> It appears to work only under specific assumptions that are not
>> guaranteed to be satisfied universally, but I need to walk though it
>> again to check that.
>
> Well, any updates? It's been a while.

Right, sorry about that.

I've been traveling lately (actually I'm still on my way home), but
I'll do my best to get to your patches as soon as I'm back.
