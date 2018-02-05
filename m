From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 4/6] ACPI / bus: Rename acpi_get_match_data() to
 acpi_device_get_match_data()
Date: Mon, 05 Feb 2018 18:12:02 +0200
Message-ID: <1517847122.22495.35.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <20180201202012.36524-4-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0hssSqBDE8emBqKFQn9gXK1dBJwB4L0y=M5===YUXjTbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:53738 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752972AbeBEQMG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 11:12:06 -0500
In-Reply-To: <CAJZ5v0hssSqBDE8emBqKFQn9gXK1dBJwB4L0y=M5===YUXjTbQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Sun, 2018-02-04 at 08:23 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2018 at 9:20 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Do the renaming to be consistent with its sibling, i.e.
> > of_device_get_match_data().
> > 
> > No functional change.
> > 
> > Fixes: 80212a162329 ("ACPI / bus: Introduce acpi_get_match_data()
> > function")
> > Fixes: 146b4dbb0eef ("ACPI: properties: Implement get_match_data()
> > callback")
> 
> Why are you adding the Fixes: tags to a patch that doesn't make any
> functional changes?
> 
> What are they useful for?

Because next patch depends on this one and fixes API. 
So, here the Fixes tags to be sure that next will apply cleanly.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
