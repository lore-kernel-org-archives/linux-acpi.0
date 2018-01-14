From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [2/4] ACPI / battery: reorder headers alphabetically
Date: Sun, 14 Jan 2018 13:55:19 +0200
Message-ID: <1515930919.7000.984.camel@linux.intel.com>
References: <20180113115331.GA13662@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:56897 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751381AbeANLzW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 14 Jan 2018 06:55:22 -0500
In-Reply-To: <20180113115331.GA13662@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ognjen =?UTF-8?Q?Gali=C4=87?= <smclt30p@gmail.com>, Dmitry Rozhkov <dmitry.rozhkov@linux.intel.com>, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org

On Sat, 2018-01-13 at 12:53 +0100, Ognjen Galić wrote:
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > -#include <linux/types.h>
> > -#include <linux/jiffies.h>
> > #include <linux/async.h>
> > -#include <linux/dmi.h>
> > #include <linux/delay.h>
> > +#include <linux/dmi.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > #include <linux/slab.h>
> > #include <linux/suspend.h>
> > -#include <asm/unaligned.h>
> > +#include <linux/types.h>
> 
> These changes completely break my patch:
> https://patchwork.kernel.org/patch/10142157/
> 
> Can we please postpone this patch until I hear back from Rafael
> about my series, as my series does some of the things this patch
> series does (like defining pr_fmt to shorten log prints) and this 
> is a much smaller changeset and would require small changes on 
> conflicts compared to my series?

Definitely on both series we need to hear from Rafael.

The usual approach, how I understand the process, the first pushed is
first served, and a quite normal situation that the one, which had been
send later, comes to repository first. But see above, we definitely rely
on maintainer's decision here.

P.S. AFAIU both series are rebased on top of linux-pm, correct? (At
least I'm sure about this one)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
