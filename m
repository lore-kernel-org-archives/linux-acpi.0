From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 1/3] mfd: Add support for Cherry Trail Dollar Cove TI PMIC
Date: Thu, 07 Sep 2017 12:59:55 +0200
Message-ID: <3782614.ATGWrI3h3H@aspire.rjw.lan>
References: <20170904144340.27693-1-tiwai@suse.de> <2362452.XVjrAATvXK@aspire.rjw.lan> <20170907110726.GG2477@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64342 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754606AbdIGLIr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2017 07:08:47 -0400
In-Reply-To: <20170907110726.GG2477@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Darren Hart <dvhart@infradead.org>, Johannes Stezenbach <js@sig21.net>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, September 7, 2017 1:07:26 PM CEST Mika Westerberg wrote:
> On Thu, Sep 07, 2017 at 12:52:53PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, September 7, 2017 9:39:03 AM CEST Lee Jones wrote:
> > > On Thu, 07 Sep 2017, Rafael J. Wysocki wrote:
> > > 
> > > > On Wednesday, September 6, 2017 12:52:09 PM CEST Lee Jones wrote:
> > > > > > > In any case, I wouldn't mind it if you took the [3/3] from this series, because
> > > > > > > if there are any conflicts with it, they will be trivial to resolve.  And I
> > > > > > > don't need an immutable branch with it or anything like that.
> > > > > > 
> > > > > > No problem.
> > > > > 
> > > > > Although you don't appear to have reviewed it?
> > > > 
> > > > I have reviewed it, although I haven't sent a tag.
> > > > 
> > > > Generally speaking, for drivers/acpi/pmic/ Reviewed-bys from Mika and Andy are
> > > > sufficient (they likely are more familiar with the code in there than I am),
> > > 
> > > I don't see them in MAINTAINERS.  I thought it was Len and yourself.
> > 
> > I do need help with code review at least in some areas, though.
> > 
> > Some of this information is missing from MAINTAINERS, but I guess that can be
> > addressed in this particular case.
> > 
> > Mika, Andy, would it be OK to add you as reviewers for drivers/acpi/pmic/
> > to MAINTAINERS?
> 
> Sure, fine by me. Andy is on vacation currently so can't speak for him.
> I suppose he does not have anything against it, though :)

OK, thanks!

