From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: [PATCH] platform: Print the resource range if device failed to
 claim
Date: Thu, 22 Dec 2016 11:18:50 +0200
Message-ID: <20161222091850.GH1460@lahna.fi.intel.com>
References: <1482312295-13373-1-git-send-email-yu.c.chen@intel.com>
 <3581108.InxQuoaF8Q@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:41653 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbcLVJSz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Dec 2016 04:18:55 -0500
Content-Disposition: inline
In-Reply-To: <3581108.InxQuoaF8Q@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Rui Zhang <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

On Thu, Dec 22, 2016 at 02:19:22AM +0100, Rafael J. Wysocki wrote:
> [CC Mika and linux-acpi]
> 
> On Wednesday, December 21, 2016 05:24:55 PM Chen Yu wrote:
> > Sometimes we have the following error message:
> >  platform MSFT0101:00: failed to claim resource 1
> >  acpi MSFT0101:00: platform device creation failed: -16
> > But there is not enough information to figure out which resource range
> > failed to claim.
> > 
> > Thus print the resource range at first-place thus /proc/iomem or
> > ioports should tell us who already claimed this resource, then
> > the driver bug or incorrect resource assignment which is running
> > into this conflict can be diagnosed:
> >  platform MSFT0101:00: failed to claim resource 1: [mem 0xfed40000-0xfed40fff]
> >  acpi MSFT0101:00: platform device creation failed: -16
> > 
> > Suggested-by: Len Brown <lenb@kernel.org>
> > Reported-by: Wendy Wang <wendy.wang@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/base/platform.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index c4af003..22a6430 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -396,7 +396,7 @@ int platform_device_add(struct platform_device *pdev)
> >  		}
> >  
> >  		if (p && insert_resource(p, r)) {
> > -			dev_err(&pdev->dev, "failed to claim resource %d\n", i);
> > +			dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
> 
> Do we still need the resource number?

It may still be useful. For example some BIOSes fill MMIO resources
based on variables in memory in which case the resource in DSDT is
filled with zeroes when disassembled. With the number you can find out
the right MMIO resource.

Either way, this is a good change. I had it on my list as well but never
got a chance to write a patch.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
