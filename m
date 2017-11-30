From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 6/6] gpiolib: acpi: Introduce NO_RESTRICTION quirk
Date: Thu, 30 Nov 2017 13:07:41 +0200
Message-ID: <1512040061.25007.531.camel@linux.intel.com>
References: <20171110134033.85461-1-andriy.shevchenko@linux.intel.com>
         <20171110134033.85461-6-andriy.shevchenko@linux.intel.com>
         <20171113115554.GY18997@lahna.fi.intel.com>
         <1510578648.25007.166.camel@linux.intel.com>
         <CACRpkdY64u0T+BW_ACzZEr7cB+W1aixsn4ZB50EsBUJZttpMaw@mail.gmail.com>
         <1511962871.25007.485.camel@linux.intel.com>
         <CACRpkdZ3rHjZZNwAL4KF_FtP6gQgATwk7F8-S8Y3VPZbJ2TdmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:44240 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbdK3LHo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Nov 2017 06:07:44 -0500
In-Reply-To: <CACRpkdZ3rHjZZNwAL4KF_FtP6gQgATwk7F8-S8Y3VPZbJ2TdmQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, 2017-11-30 at 10:57 +0100, Linus Walleij wrote:
> On Wed, Nov 29, 2017 at 2:41 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > It
> > would be nice if you can prepare immutable branch in case the
> > subsystems
> > would like to merge patches via their respective trees.
> 
> I have created a branch named "ib-gpio-acpi-quirks" in my tree
> with the six patches from you, then merged that to my devel
> branch.
> 
> You can point subsystem maintainers to that one.
> 

Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
