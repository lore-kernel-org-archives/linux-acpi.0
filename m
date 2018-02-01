From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/6] ACPI / bus: Do not traverse through non-existed
 device table
Date: Thu, 01 Feb 2018 22:45:21 +0200
Message-ID: <1517517921.7000.1447.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-2-andriy.shevchenko@linux.intel.com>
         <68fea449-6478-3d6d-addf-79925ca62931@codeaurora.org>
         <1517517646.7000.1446.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63731 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751634AbeBAUpY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 15:45:24 -0500
In-Reply-To: <1517517646.7000.1446.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Thu, 2018-02-01 at 22:40 +0200, Andy Shevchenko wrote:
> On Thu, 2018-02-01 at 15:32 -0500, Sinan Kaya wrote:
> > On 2/1/2018 3:20 PM, Andy Shevchenko wrote:
> > > When __acpi_match_device() is called it would be possible to have
> > > ACPI ID table a MULL pointer. To avoid potential dereference,
> > 
> > NULL
> 
> Thanks, will fix later.
> 
> > Why not bail out here immediately if ids is null?
> 
> Because of the code which wasn't in context of this patch.
> 
> See also patch 1 in the series.
> 
> It's about how acpi_driver_match_device() uses it.

Btw, it makes device_get_match_data() to work properly on PRP0001 kind
of devices.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
