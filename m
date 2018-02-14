From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4 1/4] ACPI / bus: Do not traverse through non-existed device table
Date: Wed, 14 Feb 2018 10:26:36 +0100
Message-ID: <1575201.KiM7emTNXZ@aspire.rjw.lan>
References: <20180209153836.19302-1-andriy.shevchenko@linux.intel.com> <20180212073448.GB27191@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:65180 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966446AbeBNJ20 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2018 04:28:26 -0500
In-Reply-To: <20180212073448.GB27191@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, linux-acpi@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Monday, February 12, 2018 8:34:48 AM CET Mika Westerberg wrote:
> On Fri, Feb 09, 2018 at 05:38:33PM +0200, Andy Shevchenko wrote:
> > When __acpi_match_device() is called it would be possible to have
> > ACPI ID table a NULL pointer. To avoid potential dereference,
> > check for this before traverse.
> > 
> > While here, remove redundant 'else'.
> > 
> > Note, this patch implies a bit of refactoring acpi_of_match_device()
> > to return pointer to OF ID when matched followed by refactoring
> > __acpi_match_device() to return either ACPI or OF ID when matches.
> > 
> > Cc: Sinan Kaya <okaya@codeaurora.org>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> For the whole series,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Series applied, thanks!

