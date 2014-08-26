From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] acpi: fan.c: printk replacement
Date: Tue, 26 Aug 2014 13:59:02 -0700
Message-ID: <1409086742.20683.75.camel@joe-AO725>
References: <1408709001-3272-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <6969509.uGLFfCOQBb@vostro.rjw.lan> <20140826153039.GA2684@sudip-PC>
	 <8052272.VnRivAuOcQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:33134 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754826AbaHZU7I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2014 16:59:08 -0400
In-Reply-To: <8052272.VnRivAuOcQ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2014-08-26 at 23:02 +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 26, 2014 09:00:39 PM Sudip Mukherjee wrote:
> > On Tue, Aug 26, 2014 at 12:45:20AM +0200, Rafael J. Wysocki wrote:
> > > On Friday, August 22, 2014 05:33:21 PM Sudip Mukherjee wrote:
> > > > printk replaced with corresponding dev_err and dev_info
> > > > fixed one broken user-visible string
> > > > multiine comment edited for correct commenting style
> > > > asm/uaccess.h replaced with linux/uaccess.h
> > > > 
> > > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > > ---
> > > >  drivers/acpi/fan.c | 18 +++++++++---------
> > > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
> > > > index 8acf53e..7900d55 100644
> > > > --- a/drivers/acpi/fan.c
> > > > +++ b/drivers/acpi/fan.c
> > > > @@ -27,7 +27,7 @@
> > > >  #include <linux/module.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/types.h>
> > > > -#include <asm/uaccess.h>
> > > > +#include <linux/uaccess.h>
> > > >  #include <linux/thermal.h>
> > > >  #include <linux/acpi.h>
> > > >  
> > > > @@ -127,8 +127,9 @@ static const struct thermal_cooling_device_ops fan_cooling_ops = {
> > > >  };
> > > >  
> > > >  /* --------------------------------------------------------------------------
> > > > -                                 Driver Interface
> > > > -   -------------------------------------------------------------------------- */
> > > > + *                               Driver Interface
> > > > + * --------------------------------------------------------------------------
> > > > +*/
> > > >  
> > > >  static int acpi_fan_add(struct acpi_device *device)
> > > >  {
> > > > @@ -143,7 +144,7 @@ static int acpi_fan_add(struct acpi_device *device)
> > > >  
> > > >  	result = acpi_bus_update_power(device->handle, NULL);
> > > >  	if (result) {
> > > > -		printk(KERN_ERR PREFIX "Setting initial power state\n");
> > > > +		dev_err(&device->dev, PREFIX "Setting initial power state\n");
> > > 
> > > While at it, please define a proper pr_fmt() for this file and get rid of PREFIX
> > > too.
> > > 
> > > Otherwise I don't see a compelling reason to apply this.
> > > 
> > 
> > Hi,
> > Since in the patch I am not using any pr_* , so I am unable to understand why
> > you are asking for a proper pr_fmt().
> 
> Never mind, I was confused somehow, not exactly sure why.  Sorry about that.
> 
> > I can get rid of the PREFIX . Then should I use pr_* in the patch instead of dev_* ? 
> > My understanding was dev_* is more preffered than pr_*.
> > waiting for your suggestion on this.
> 
> Well, that really depends on the particular case.  It really is better to use
> dev_err() here, but then PREFIX with it is not really useful, so please just
> drop PREFIX from the new messages.

PREFIX is "ACPI: " so I think the idea is
to be able to grep for that.

