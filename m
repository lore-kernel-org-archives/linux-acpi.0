From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1 1/4] ACPI / bus: Remove checks in acpi_get_match_data()
Date: Fri, 02 Feb 2018 12:32:18 +0100
Message-ID: <2550046.e5XUd9eR5Z@aspire.rjw.lan>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0i_wZCmPcMSqGWNpxAStkw0UVhrDNUdaEiDY90=uEjGcw@mail.gmail.com> <1517487893.7000.1372.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:51390 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeBBLdz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Feb 2018 06:33:55 -0500
In-Reply-To: <1517487893.7000.1372.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@codeaurora.org>, dmaengine <dmaengine@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thursday, February 1, 2018 1:24:53 PM CET Andy Shevchenko wrote:
> On Thu, 2018-02-01 at 08:27 +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 31, 2018 at 11:17 PM, Sinan Kaya <okaya@codeaurora.org>
> > wrote:
> > > On 1/31/2018 4:29 PM, Andy Shevchenko wrote:
> > > > As well as its sibling of_device_get_match_data() has no such
> > > > checks,
> > > > no need to do it in acpi_get_match_data().
> > > > 
> > > > First of all, we are not supposed to call fwnode API like this
> > > > without
> > > > driver attached.
> > > > 
> > > > Second, if pure OF driver calls this function, it's weird to have
> > > > ACPI
> > > > companion without ACPI ID in this case.
> > > 
> > > We talked about this during review.
> > > 
> > > of_match_device() does all the checking for the OF part. ACPI
> > > doesn't have
> > > any checks.
> > 
> > Yeah, this patch is just plain incorrect AFAICS.
> 
> I don't see how check dev->driver is implemented on OF side then
> 
> 
> of_device_get_match_data() which is called by
> of_fwnode_device_get_match_data() has dereferenced dev->driver w/o any
> check.
> 
> I can't agree that the patch is plain incorrect, if I didn't miss
> anything.

OK, you're right, sorry.

