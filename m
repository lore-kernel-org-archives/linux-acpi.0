From: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Subject: Re: [PATCH 6/8] libata hotplug to align with dock driver
Date: Mon, 09 Jun 2008 16:15:17 -0300
Message-ID: <1213038917.22010.1257552459@webmail.messagingengine.com>
References: <1212729788.25188.29.camel@sli10-desk.sh.intel.com>
 <20080609013719.GA30665@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50100 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755637AbYFITPS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 15:15:18 -0400
Content-Disposition: inline
In-Reply-To: <20080609013719.GA30665@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Mon, 9 Jun 2008 02:37:19 +0100, "Matthew Garrett" <mjg59@srcf.ucam.org> said:
> On Fri, Jun 06, 2008 at 01:23:08PM +0800, Shaohua Li wrote:
> 
> >  	case ACPI_NOTIFY_EJECT_REQUEST:
> >  		ata_ehi_push_desc(ehi, "ACPI event");
> > -
> > -		if (!is_dock_event)
> > -			break;
> > -
> > -		/* undock event - immediate unplug */
> >  		ata_acpi_detach_device(ap, dev);
> 
> Ok, just to check that I've understood the other patches - this will 
> only be called if the device has actually been removed, and not if you 
> merely get an EJECT_REQUEST, right? An EJECT_REQUEST from a bay device 
> should always just signal userspace, and never actually cause the device 
> to be deleted. I don't really like the way that you're remapping event 

That's my doubt as well.   We can't have unconditional ejects of either
docks or bays on hardware that allows you to refuse to eject if something
is wrong, that choice belongs to USERSPACE, so the ejects must not be
unconditional.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

