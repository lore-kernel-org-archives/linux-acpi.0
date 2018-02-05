From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/6] ACPI / bus: Return error code from
 __acpi_match_device() in one case
Date: Mon, 05 Feb 2018 17:56:19 +0200
Message-ID: <1517846179.22495.27.camel@linux.intel.com>
References: <20180201202012.36524-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0gL5d5Ypar2GJSLCFNWAPhy9RGbwhF9iAKuAWaeu_hxFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:52960 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753215AbeBEP4Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Feb 2018 10:56:24 -0500
In-Reply-To: <CAJZ5v0gL5d5Ypar2GJSLCFNWAPhy9RGbwhF9iAKuAWaeu_hxFg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

On Sun, 2018-02-04 at 08:16 +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 1, 2018 at 9:20 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > Instead of playing tricks with last invalid entry,
> > return simple -ENODATA error code casted to pointer.
> > 
> > It would be good for future in case caller passes NULL pointer for
> > ID table. Moreover, caller can check the code to be sure what
> > happened
> > inside callee.

> > -                       return id;
> > +                       return ERR_PTR(-ENODATA);
> 
> So why is returning id from here a problem?

I think you already noticed that in the following patch it becomes a
problem if user supply ids == NULL.

That's why I added a second paragraph to the commit message to explain.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
