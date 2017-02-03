From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/4] device property: constify property arrays values
Date: Thu, 2 Feb 2017 17:06:07 -0800
Message-ID: <20170203010607.GB12651@dtor-ws>
References: <1485991803.22276.14.camel@perches.com>
 <1605853.brEpCT4tOG@aspire.rjw.lan>
 <20170202163918.GA21924@dtor-ws>
 <1486054110.2133.366.camel@linux.intel.com>
 <C3BEC996-015E-4536-AE2F-DB0819631789@gmail.com>
 <1486057978.2133.369.camel@linux.intel.com>
 <20170202183831.GA32759@dtor-ws>
 <CAJZ5v0jB_8LXPR7Uj0j5gyTo+Bdk9Sud+9jreA4VT9+QsB5ieA@mail.gmail.com>
 <20170203001648.GA12651@dtor-ws>
 <CAJZ5v0jzqfSniR8gzM6yO8Gx2-Av4ia0PYAGodmXqVsoNFvbZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34612 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbdBCBGL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2017 20:06:11 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jzqfSniR8gzM6yO8Gx2-Av4ia0PYAGodmXqVsoNFvbZg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joe Perches <joe@perches.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Wolfram Sang <wsa@the-dreams.de>

On Fri, Feb 03, 2017 at 01:37:25AM +0100, Rafael J. Wysocki wrote:
> On Fri, Feb 3, 2017 at 1:16 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Fri, Feb 03, 2017 at 12:16:29AM +0100, Rafael J. Wysocki wrote:
> >> On Thu, Feb 2, 2017 at 7:38 PM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Thu, Feb 02, 2017 at 07:52:58PM +0200, Andy Shevchenko wrote:
> >> >> On Thu, 2017-02-02 at 09:07 -0800, Dmitry Torokhov wrote:
> >> >> > On February 2, 2017 8:48:30 AM PST, Andy Shevchenko <andriy.shevchenko
> >> >> > @linux.intel.com> wrote:
> >> >> > > On Thu, 2017-02-02 at 08:39 -0800, Dmitry Torokhov wrote:
> >> >> > > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> >> > > >
> >> >> > > > Data that is fed into property arrays should not be modified, so
> >> >> > >
> >> >> > > let's
> >> >> > > > mark
> >> >> > > > relevant pointers as const. This will allow us making source
> >> >> > > > arrays
> >> >> > >
> >> >> > > as
> >> >> > > > const/__initconst.
> >> >> > > >
> >> >> > > > Also fix memory leaks on errors in property_entry_copy().
> >> >> > >
> >> >> > > While the code looks okay, I'm not sure what memory leaks you are
> >> >> > > referring to. The idea as far as I remember was to run *free()
> >> >> > > function
> >> >> > > if *copy() fails.
> >> >> >
> >> >> > That could have been OK for internal function, but will not work for
> >> >> > public API, as it goes against normal pattern.
> >>
> >> But it is an internal function, isn't it?
> >>
> >> Also its only caller does the right thing AFAICS.
> >
> > No, actually property_entries_dup() does not do the right thing anymore
> > :(.
> 
> Well, it looks like this is because of patch [1/4], so IMO the changes
> to clean up on errors in property_entry_copy() should be made in that
> patch as well.
> 
> Right now we seem to have potential memory leaks introduced in patch
> [1/4] and then fixed up in patch [3/4] in the same series which
> doesn't feel quite right to be honest.

Totally agree, I'm reshuffling and will repost the series in a few.

-- 
Dmitry
