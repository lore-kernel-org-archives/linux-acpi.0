From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] pinctrl: baytrail: Add back Baytrail-T ACPI ID
Date: Fri, 16 May 2014 15:03:37 +0300
Message-ID: <20140516120337.GE2067@lahna.fi.intel.com>
References: <1400167727-20233-1-git-send-email-mika.westerberg@linux.intel.com>
 <1593450.1tg6AZy8cc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:20026 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757194AbaEPMDm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 May 2014 08:03:42 -0400
Content-Disposition: inline
In-Reply-To: <1593450.1tg6AZy8cc@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jin Yao <yao.jin@intel.com>, Aubrey Li <aubrey.li@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, May 16, 2014 at 02:10:47PM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 15, 2014 06:28:46 PM Mika Westerberg wrote:
> > From: Jin Yao <yao.jin@intel.com>
> > 
> > Now that the x86 dynamic IRQ allocation problem has been resolved with
> > commmit 62a08ae2a576 (genirq: x86: Ensure that dynamic irq allocation does
> > not conflict), we can add back Baytrail-T ACPI ID to the pinctrl driver.
> > 
> > This makes the driver to work on Asus T100 where it is needed for several
> > things like ACPI GPIO events and SD card detection.
> > 
> > References: https://bugzilla.kernel.org/show_bug.cgi?id=68291
> > Signed-off-by: Jin Yao <yao.jin@intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks!

> And I think this is pinctrl material really.

Indeed, only one change touches drivers/acpi/ but wanted to keep you in
the loop. I'm hoping that Linus W. takes these.
