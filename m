From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 9/9] Revert "dmaengine: dw: platform: provide platform
 data for Intel"
Date: Tue, 8 Dec 2015 22:57:37 +0530
Message-ID: <20151208172737.GW1854@localhost>
References: <1449265765-9393-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1449265765-9393-10-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23186 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbbLHRYd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Dec 2015 12:24:33 -0500
Content-Disposition: inline
In-Reply-To: <1449265765-9393-10-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

On Fri, Dec 04, 2015 at 11:49:25PM +0200, Andy Shevchenko wrote:
> Since we have a work around to prevent a system hangup we don't need to provide
> a platform data explicitly anymore.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
