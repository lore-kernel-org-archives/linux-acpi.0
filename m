From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 10/10] thinkpad_acpi: fingers off backlight if video.ko is
 serving this functionality
Date: Sat, 08 Nov 2008 00:45:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811080045350.9051@localhost.localdomain>
References: <1217605083-31003-1-git-send-email-trenn@suse.de>
 <1217605083-31003-11-git-send-email-trenn@suse.de>
 <20080801175033.GE14352@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:39592 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbYKHFqC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Nov 2008 00:46:02 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KA000E552ON2902@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 07 Nov 2008 23:46:00 -0600 (CST)
In-reply-to: <20080801175033.GE14352@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, rui.zhang@intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org



On Fri, 1 Aug 2008, Henrique de Moraes Holschuh wrote:

> On Fri, 01 Aug 2008, Thomas Renninger wrote:
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > ---
> >  drivers/misc/thinkpad_acpi.c |   31 ++++++++++++++++++++-----------
> >  1 files changed, 20 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
> > index d3eb790..a71ecd2 100644
> > --- a/drivers/misc/thinkpad_acpi.c
> > +++ b/drivers/misc/thinkpad_acpi.c
> > @@ -4922,17 +4922,26 @@ static int __init brightness_init(struct ibm_init_struct *iibm)
> >  	 */
> >  	b = tpacpi_check_std_acpi_brightness_support();
> >  	if (b > 0) {
> > -		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO) {
> > -			printk(TPACPI_NOTICE
> > -			       "Lenovo BIOS switched to ACPI backlight "
> > -			       "control mode\n");
> > -		}
> > -		if (brightness_enable > 1) {
> > -			printk(TPACPI_NOTICE
> > -			       "standard ACPI backlight interface "
> > -			       "available, not loading native one...\n");
> > -			return 1;
> > -		}
> > +
> > +		if (acpi_video_backlight_support()) {
> > +			if (brightness_enable > 1) {
> > +				printk(TPACPI_NOTICE
> > +				       "Standard ACPI backlight interface "
> > +				       "available, not loading native one.\n");
> > +				return 1;
> > +			} else if (brightness_enable == 1) {
> > +				printk(TPACPI_NOTICE
> > +				       "Backlight control force, even standard "
> > +				       "ACPI backlight interface available\n");
> > +			}
> 
> EPARSE.  "Backlight control force, even standard ACPI backlight interface
> available" is no good.  Maybe you want to change that to "Backlight control
> force enabled, even if standard ACPI backlight interface is available" ?

updated.

> > +		} else {
> > +			if (brightness_enable > 1) {
> > +				printk(TPACPI_NOTICE
> > +				       "Standard ACPI backlight interface not "
> > +				       "available, thinkpad_acpi driver "
> > +				       "will take over control\n");
> 
> "thinkpad-acpi native brightness control enabled", perhaps?

updated.

> > +			}
> > + 		}
> >  	}
> >  
> >  	if (!brightness_enable) {
> 
> Provided that you clarify the printk I marked with EPARSE:
> Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

thanks,
-Len

