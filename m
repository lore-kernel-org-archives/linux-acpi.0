From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/6] ACPI / bus: Remove checks in
 acpi_get_match_data()
Date: Tue, 06 Feb 2018 14:51:11 +0200
Message-ID: <1517921471.22495.45.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0hw2h2qvHD=FyH1SU2CwcQj7xOOs7buAoc779EK1TeibQ@mail.gmail.com>
         <1517846662.22495.34.camel@linux.intel.com>
         <2031557.saWJYrj679@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44281 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752388AbeBFMvP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Feb 2018 07:51:15 -0500
In-Reply-To: <2031557.saWJYrj679@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, dmaengine <dmaengine@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Mon, 2018-02-05 at 17:54 +0100, Rafael J. Wysocki wrote:
> On Monday, February 5, 2018 5:04:22 PM CET Andy Shevchenko wrote:
> > On Sun, 2018-02-04 at 08:21 +0100, Rafael J. Wysocki wrote:
> > > On Thu, Feb 1, 2018 at 9:46 PM, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > I'm also not sure if the Fixes: tag is really applicable to this.
> > 
> > We can of course drop it, I put it here in a hope that this series
> > would
> > be material to v4.16-rc2 to fix an introduced API.
> 
> I can still take it for -rc1 even if ready, these tags aren't
> necessary for that.

Noted. 
I'll remove tags and resend.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
