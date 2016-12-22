From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] platform: Print the resource range if device failed to
 claim
Date: Thu, 22 Dec 2016 11:32:14 +0800
Message-ID: <20161222033214.GA8507@yu-desktop-1.sh.intel.com>
References: <1482312295-13373-1-git-send-email-yu.c.chen@intel.com>
 <3581108.InxQuoaF8Q@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:3609 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934840AbcLVDWs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Dec 2016 22:22:48 -0500
Content-Disposition: inline
In-Reply-To: <3581108.InxQuoaF8Q@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <lenb@kernel.org>, Rui Zhang <rui.zhang@intel.com>, Linux ACPI <linux-acpi@vger.kernel.org>

Hi,
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
> 
Seems we don't need the resource number anymore.
(As platform.c was written earlier than 2005, and the support of %pR was introduced
later in 2008.)
> >  			ret = -EBUSY;
> >  			goto failed;
> >  		}
> > 
> 
> Thanks,
> Rafael
> 

Thanks,
Yu
