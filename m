From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/6] ACPI / bus: Remove checks in
 acpi_get_match_data()
Date: Mon, 05 Feb 2018 18:04:22 +0200
Message-ID: <1517846662.22495.34.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-3-andriy.shevchenko@linux.intel.com>
         <1517517998.7000.1448.camel@linux.intel.com>
         <CAJZ5v0hw2h2qvHD=FyH1SU2CwcQj7xOOs7buAoc779EK1TeibQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28096 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752925AbeBEQE0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 11:04:26 -0500
In-Reply-To: <CAJZ5v0hw2h2qvHD=FyH1SU2CwcQj7xOOs7buAoc779EK1TeibQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Sun, 2018-02-04 at 08:21 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2018 at 9:46 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, 2018-02-01 at 22:20 +0200, Andy Shevchenko wrote:
> > > As well as its sibling of_device_get_match_data() has no such
> > > checks,
> > > no need to do it in acpi_get_match_data().
> > > 
> > > First of all, we are not supposed to call fwnode API like this
> > > without
> > > driver attached.
> > > 
> > > Second, since __acpi_match_device() does check input parameter
> > > there
> > > is
> > > no need to duplicate it outside.
> > > 
> > > Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data()
> > > function")
> > > Cc: Sinan Kaya <okaya@codeaurora.org>
> > > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > Cc: Vinod Koul <vinod.koul@intel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 

> > rhaps I have to add that this conditional prevents
> > device_get_match_data() to work on PRP0001 devices AFAIU.
> 
> Yes, please.

OK.

> I'm also not sure if the Fixes: tag is really applicable to this.

We can of course drop it, I put it here in a hope that this series would
be material to v4.16-rc2 to fix an introduced API.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
