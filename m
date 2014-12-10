From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1] ACPI / Fan: Use bus id for non PNP0C0B (Fan) device
Date: Wed, 10 Dec 2014 15:18:36 -0800
Message-ID: <1418253516.740.101.camel@spandruv-desktop.jf.intel.com>
References: <1418170540-8349-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1418170540-8349-2-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1513887.Yep6z7hHDZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31723 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758335AbaLJXTF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Dec 2014 18:19:05 -0500
In-Reply-To: <1513887.Yep6z7hHDZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On Wed, 2014-12-10 at 22:53 +0100, Rafael J. Wysocki wrote: 
> On Tuesday, December 09, 2014 04:15:40 PM Srinivas Pandruvada wrote:
> > The _ART (Active Cooling Relationship Table), specifies relationship
> > among heat generating sources to a target active cooling device like
> > fan. The _ART table refers to actual bus id name for specifying relationship.
> > Naming "Fan" is not enough as name in the _ART table can change on every
> > platform, to establish relationship for user space thermal controllers.
> > 
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> I can apply this or do you have any thermal material depending on it?
This patch can go independently as no thermal patches depends on this.
Thanks,
Srinivas 
> 
> > ---
> >  drivers/acpi/fan.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> > index caf9b76..7a36f02 100644
> > --- a/drivers/acpi/fan.c
> > +++ b/drivers/acpi/fan.c
> > @@ -325,6 +325,7 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >  	struct thermal_cooling_device *cdev;
> >  	struct acpi_fan *fan;
> >  	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> > +	char *name;
> >  
> >  	fan = devm_kzalloc(&pdev->dev, sizeof(*fan), GFP_KERNEL);
> >  	if (!fan) {
> > @@ -346,7 +347,12 @@ static int acpi_fan_probe(struct platform_device *pdev)
> >  		}
> >  	}
> >  
> > -	cdev = thermal_cooling_device_register("Fan", device,
> > +	if (!strncmp(pdev->name, "PNP0C0B", strlen("PNP0C0B")))
> > +		name = "Fan";
> > +	else
> > +		name = acpi_device_bid(device);
> > +
> > +	cdev = thermal_cooling_device_register(name, device,
> >  						&fan_cooling_ops);
> >  	if (IS_ERR(cdev)) {
> >  		result = PTR_ERR(cdev);
> > 
> 


