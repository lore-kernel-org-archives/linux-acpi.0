From: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 6/6] device property: Constify device_get_match_data()
Date: Thu, 1 Feb 2018 23:23:36 +0200
Message-ID: <20180201212315.igjdqah4qi2yx7mr@kekkonen.localdomain>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
 <20180201202012.36524-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18220 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbeBAVXj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 1 Feb 2018 16:23:39 -0500
Content-Disposition: inline
In-Reply-To: <20180201202012.36524-6-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Sinan Kaya <okaya@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>

Hi Andy,

On Thu, Feb 01, 2018 at 10:20:12PM +0200, Andy Shevchenko wrote:
> Constify device_get_match_data() as OF and ACPI variants return
> constant value.
> 
> Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data() function")
> Fixes: b283f157611f ("device property: Introduce a common API to fetch device match data")
> Fixes: 146b4dbb0eef ("ACPI: properties: Implement get_match_data() callback")
> Cc: Sinan Kaya <okaya@codeaurora.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com> (fwnode changes)

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
