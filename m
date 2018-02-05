From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/6] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Mon, 05 Feb 2018 17:54:25 +0100
Message-ID: <2031557.saWJYrj679@aspire.rjw.lan>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0hw2h2qvHD=FyH1SU2CwcQj7xOOs7buAoc779EK1TeibQ@mail.gmail.com> <1517846662.22495.34.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:54122 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBEQ4F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Feb 2018 11:56:05 -0500
In-Reply-To: <1517846662.22495.34.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Monday, February 5, 2018 5:04:22 PM CET Andy Shevchenko wrote:
> On Sun, 2018-02-04 at 08:21 +0100, Rafael J. Wysocki wrote:
> > On Thu, Feb 1, 2018 at 9:46 PM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, 2018-02-01 at 22:20 +0200, Andy Shevchenko wrote:
> > > > As well as its sibling of_device_get_match_data() has no such
> > > > checks,
> > > > no need to do it in acpi_get_match_data().
> > > > 
> > > > First of all, we are not supposed to call fwnode API like this
> > > > without
> > > > driver attached.
> > > > 
> > > > Second, since __acpi_match_device() does check input parameter
> > > > there
> > > > is
> > > > no need to duplicate it outside.
> > > > 
> > > > Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data()
> > > > function")
> > > > Cc: Sinan Kaya <okaya@codeaurora.org>
> > > > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > Cc: Vinod Koul <vinod.koul@intel.com>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > 
> 
> > > rhaps I have to add that this conditional prevents
> > > device_get_match_data() to work on PRP0001 devices AFAIU.
> > 
> > Yes, please.
> 
> OK.
> 
> > I'm also not sure if the Fixes: tag is really applicable to this.
> 
> We can of course drop it, I put it here in a hope that this series would
> be material to v4.16-rc2 to fix an introduced API.

I can still take it for -rc1 even if ready, these tags aren't necessary for that.

