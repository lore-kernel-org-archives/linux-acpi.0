From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Wed, 29 Nov 2017 15:41:11 +0200
Message-ID: <1511962871.25007.485.camel@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
         <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
         <20171113115554.GY18997@lahna.fi.intel.com>
         <1510578648.25007.166.camel@linux.intel.com>
         <CACRpkdY64u0T+BW_ACzZEr7cB+W1aixsn4ZB50EsBUJZttpMaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:14668 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751980AbdK2NlO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Nov 2017 08:41:14 -0500
In-Reply-To: <CACRpkdY64u0T+BW_ACzZEr7cB+W1aixsn4ZB50EsBUJZttpMaw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, 2017-11-29 at 13:35 +0100, Linus Walleij wrote:
> On Mon, Nov 13, 2017 at 2:10 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, 2017-11-13 at 13:55 +0200, Mika Westerberg wrote:

> > > I think you should include user of this quirk in the patch series
> > > as
> > > well. Otherwise it is pretty pointless to add random quirks
> > > without
> > > real issues they are supposed to solve ;-)
> > 
> > Something like below?
> 
> I bet this patch is already somewhere in my mailbox else just send
> it separately. All these patches are applied.

I'm going to send them (there are two affected users) next week. It
would be nice if you can prepare immutable branch in case the subsystems
would like to merge patches via their respective trees.

Thanks for applying!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
