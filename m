From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/1] ACPI / LPSS: enable hard LLP for DMA
Date: Thu, 24 Nov 2016 02:30:07 +0100
Message-ID: <1591537.110YMfCrBz@vostro.rjw.lan>
References: <20161117143006.130266-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:61063 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935508AbcKXBWV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Nov 2016 20:22:21 -0500
In-Reply-To: <20161117143006.130266-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com

On Thursday, November 17, 2016 04:30:06 PM Andy Shevchenko wrote:
> Right now the DMA support of hard LLP (*) is fused. Enable it via specific
> message sent to SoC at run time.
> 
> (*) Hard LLP stands for the multi-block transfer feature of DMA controller
> supported by hardware.
> 
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Rafael

