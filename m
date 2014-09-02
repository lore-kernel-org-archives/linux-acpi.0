From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/4] ACPI / LPSS: drop clkdev_name member from
 lpss_device_desc
Date: Tue, 02 Sep 2014 13:42:55 +0300
Message-ID: <1409654575.30155.72.camel@linux.intel.com>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
	 <1409644510-26397-3-git-send-email-heikki.krogerus@linux.intel.com>
	 <1409647396.30155.69.camel@linux.intel.com>
	 <20140902103446.GA30021@xps8300>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25436 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469AbaIBKm7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 06:42:59 -0400
In-Reply-To: <20140902103446.GA30021@xps8300>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Tue, 2014-09-02 at 13:34 +0300, Heikki Krogerus wrote:
> On Tue, Sep 02, 2014 at 11:43:16AM +0300, Andy Shevchenko wrote:
> > On Tue, 2014-09-02 at 10:55 +0300, Heikki Krogerus wrote:
> > > It was used to provide the correct con_id for the dma
> > > driver, but it's not needed. Even if the driver requests a
> > > clock with the con_id, it still gets the correct clock. The
> > 
> > Maybe with -> without?
> 
> No. What I'm trying say is that even though the dma engine driver
> requests the clock like this:
> 
>         dw->clk = devm_clk_get(chip->dev, "hclk")
> 
> i.e. _with_ the con_id "hclk", it will still get the correct
> reference because..
> > > device name is enough to match a single clock.

Fair enough.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

