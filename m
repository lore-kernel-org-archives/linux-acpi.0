From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 7/9] dmaengine: dw: platform: power on device on
 shutdown
Date: Tue, 8 Dec 2015 22:55:34 +0530
Message-ID: <20151208172534.GV1854@localhost>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1449265765-9393-8-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6133 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbbLHRW3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2015 12:22:29 -0500
Content-Disposition: inline
In-Reply-To: <1449265765-9393-8-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Dec 04, 2015 at 11:49:23PM +0200, Andy Shevchenko wrote:
> We have to call dw_dma_disable() to stop any ongoing transfer. On some
> platforms we can't do that since DMA device is powered off. Moreover we have no
> possibility at that point to check if the platform is affected or not. That's
> why we call pm_runtime_get_sync() / pm_runtime_put() unconditionally. On the
> other hand we can't use pm_runtime_suspended() because runtime PM framework is
> not fully used by the driver.
 
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
