From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ACPI / LPSS: enable hard LLP for DMA
Date: Tue, 8 Nov 2016 15:57:42 +0200
Message-ID: <20161108135742.GY1447@lahna.fi.intel.com>
References: <20161108134638.90267-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39668 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752995AbcKHN5v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Nov 2016 08:57:51 -0500
Content-Disposition: inline
In-Reply-To: <20161108134638.90267-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Tue, Nov 08, 2016 at 03:46:38PM +0200, Andy Shevchenko wrote:
> Right now the DMA support of hard LLP is fused. Enable it via specific message
> sent to SoC at run time.

It would help the reviewer if you explain what hard LLP actually means ;-)

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I tested this on Minnowboard MAX using SPI and DMA still works fine even
if using larger (>4k) blocks.

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
