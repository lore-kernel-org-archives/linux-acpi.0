From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 8/9] dmaengine: dw: return immediately from IRQ when
 DMA isn't in use
Date: Tue, 8 Dec 2015 22:55:10 +0530
Message-ID: <20151208172510.GU1854@localhost>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1449265765-9393-9-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6223 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbbLHRWH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2015 12:22:07 -0500
Content-Disposition: inline
In-Reply-To: <1449265765-9393-9-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Dec 04, 2015 at 11:49:24PM +0200, Andy Shevchenko wrote:
> There is no need to bother the hardware when all channels are idle. We have not
> to get any interrupts.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
