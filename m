From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI / LPSS: enable hard LLP for DMA
Date: Thu, 17 Nov 2016 12:39:21 +0200
Message-ID: <1479379161.22212.2.camel@linux.intel.com>
References: <20161108134638.90267-1-andriy.shevchenko@linux.intel.com>
         <20161108135742.GY1447@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:45582 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422743AbcKQKjY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Nov 2016 05:39:24 -0500
In-Reply-To: <20161108135742.GY1447@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, 2016-11-08 at 15:57 +0200, Mika Westerberg wrote:
> On Tue, Nov 08, 2016 at 03:46:38PM +0200, Andy Shevchenko wrote:
> > Right now the DMA support of hard LLP is fused. Enable it via
> > specific message
> > sent to SoC at run time.
> 
> It would help the reviewer if you explain what hard LLP actually means
> ;-)

Rafael, shall I fix commit message and resend?

> 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I tested this on Minnowboard MAX using SPI and DMA still works fine
> even
> if using larger (>4k) blocks.
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
