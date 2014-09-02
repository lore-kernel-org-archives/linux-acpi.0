From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 2/4] ACPI / LPSS: drop clkdev_name member from
 lpss_device_desc
Date: Tue, 2 Sep 2014 13:34:46 +0300
Message-ID: <20140902103446.GA30021@xps8300>
References: <1409644510-26397-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1409644510-26397-3-git-send-email-heikki.krogerus@linux.intel.com>
 <1409647396.30155.69.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17978 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964AbaIBKe7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 2 Sep 2014 06:34:59 -0400
Content-Disposition: inline
In-Reply-To: <1409647396.30155.69.camel@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org

On Tue, Sep 02, 2014 at 11:43:16AM +0300, Andy Shevchenko wrote:
> On Tue, 2014-09-02 at 10:55 +0300, Heikki Krogerus wrote:
> > It was used to provide the correct con_id for the dma
> > driver, but it's not needed. Even if the driver requests a
> > clock with the con_id, it still gets the correct clock. The
> 
> Maybe with -> without?

No. What I'm trying say is that even though the dma engine driver
requests the clock like this:

        dw->clk = devm_clk_get(chip->dev, "hclk")

i.e. _with_ the con_id "hclk", it will still get the correct
reference because..

> > device name is enough to match a single clock.


Cheers,

-- 
heikki
