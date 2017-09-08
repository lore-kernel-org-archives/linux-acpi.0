From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ACPI / PMIC: Add code reviewers to MAINTAINERS
Date: Thu, 07 Sep 2017 18:19:37 -0700
Message-ID: <1504833577.7546.30.camel@perches.com>
References: <3133187.xxVeAdigRk@aspire.rjw.lan>
         <1504785106.7546.22.camel@perches.com>
         <CAJZ5v0ht3kRkD1dBKhTMZm0d_28zJb+GKoJgYJrLSX0XY7ai6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:42516 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750966AbdIHBTn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 21:19:43 -0400
In-Reply-To: <CAJZ5v0ht3kRkD1dBKhTMZm0d_28zJb+GKoJgYJrLSX0XY7ai6Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>

On Fri, 2017-09-08 at 01:21 +0200, Rafael J. Wysocki wrote:
> On Thu, Sep 7, 2017 at 1:51 PM, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2017-09-07 at 13:18 +0200, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Andy and Mika review code changes under drivers/acpi/pmic/ on
> > > a regular basis and I rely on their help with that, so add them
> > > as code reviwewers for that part of the kernel.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  MAINTAINERS |   12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > Index: linux-pm/MAINTAINERS
> > > ===================================================================
> > > --- linux-pm.orig/MAINTAINERS
> > > +++ linux-pm/MAINTAINERS
> > > @@ -352,6 +352,18 @@ L:       linux-acpi@vger.kernel.org
> > >  S:   Maintained
> > >  F:   drivers/acpi/arm64
> > > 
> > > +ACPI PMIC DRIVERS
> > > +M:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > +M:   Len Brown <lenb@kernel.org>
> > > +L:   linux-acpi@vger.kernel.org
> > > +R:   Andy Shevchenko <andy@infradead.org>
> > > +R:   Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > Please put reviewers before lists
> 
> OK
> 
> So the APEI entry should be reordered too I suppose?

That'd be nice one day if Linus decides not to
split the MAINTAINERS file up using
scripts/parse_maintainers.pl.

That puts everything in the appropriate sorted order.

