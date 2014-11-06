From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v1 4/4] dmaengine: dw: enable runtime PM
Date: Thu, 6 Nov 2014 13:14:48 +0530
Message-ID: <20141106074448.GX1870@intel.com>
References: <1415205288-3356-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1415205288-3356-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:55262 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbaKFHoS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Nov 2014 02:44:18 -0500
Content-Disposition: inline
In-Reply-To: <1415205288-3356-5-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.jf.intel.com>
Cc: Scott Ashcroft <scott.ashcroft@talk21.com>, Mika Westerberg <mika.westerberg@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Blin, Jerome" <jerome.blin@intel.com>, linux-acpi@vger.kernel.org

On Wed, Nov 05, 2014 at 06:34:48PM +0200, Andy Shevchenko wrote:
> On runtime PM aware platforms the DMA have to manage its own power state. This
> patch enables runtime PM support and applies necessary calls wherever it's
> needed.
Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod

