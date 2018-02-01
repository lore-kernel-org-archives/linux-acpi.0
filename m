From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/4] ACPI / bus: Remove checks in
 acpi_get_match_data()
Date: Thu, 01 Feb 2018 14:24:53 +0200
Message-ID: <1517487893.7000.1372.camel@linux.intel.com>
References: <20180131212959.68766-1-andriy.shevchenko@linux.intel.com>
         <b52b3995-ec9c-660d-6c2f-afebf3864b90@codeaurora.org>
         <CAJZ5v0i_wZCmPcMSqGWNpxAStkw0UVhrDNUdaEiDY90=uEjGcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54619 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbeBAMY4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 07:24:56 -0500
In-Reply-To: <CAJZ5v0i_wZCmPcMSqGWNpxAStkw0UVhrDNUdaEiDY90=uEjGcw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Sinan Kaya <okaya@codeaurora.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-01 at 08:27 +0100, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2018 at 11:17 PM, Sinan Kaya <okaya@codeaurora.org>
> wrote:
> > On 1/31/2018 4:29 PM, Andy Shevchenko wrote:
> > > As well as its sibling of_device_get_match_data() has no such
> > > checks,
> > > no need to do it in acpi_get_match_data().
> > > 
> > > First of all, we are not supposed to call fwnode API like this
> > > without
> > > driver attached.
> > > 
> > > Second, if pure OF driver calls this function, it's weird to have
> > > ACPI
> > > companion without ACPI ID in this case.
> > 
> > We talked about this during review.
> > 
> > of_match_device() does all the checking for the OF part. ACPI
> > doesn't have
> > any checks.
> 
> Yeah, this patch is just plain incorrect AFAICS.

I don't see how check dev->driver is implemented on OF side then


of_device_get_match_data() which is called by
of_fwnode_device_get_match_data() has dereferenced dev->driver w/o any
check.

I can't agree that the patch is plain incorrect, if I didn't miss
anything.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
