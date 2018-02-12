From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/4] ACPI / bus: Do not traverse through non-existed
 device table
Date: Mon, 12 Feb 2018 09:34:48 +0200
Message-ID: <20180212073448.GB27191@lahna.fi.intel.com>
References: <20180209153836.19302-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4051 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751171AbeBLHex (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Feb 2018 02:34:53 -0500
Content-Disposition: inline
In-Reply-To: <20180209153836.19302-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Fri, Feb 09, 2018 at 05:38:33PM +0200, Andy Shevchenko wrote:
> When __acpi_match_device() is called it would be possible to have
> ACPI ID table a NULL pointer. To avoid potential dereference,
> check for this before traverse.
> 
> While here, remove redundant 'else'.
> 
> Note, this patch implies a bit of refactoring acpi_of_match_device()
> to return pointer to OF ID when matched followed by refactoring
> __acpi_match_device() to return either ACPI or OF ID when matches.
> 
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
