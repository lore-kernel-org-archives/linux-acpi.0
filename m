From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 6/8] libata hotplug to align with dock driver
Date: Mon, 9 Jun 2008 02:37:19 +0100
Message-ID: <20080609013719.GA30665@srcf.ucam.org>
References: <1212729788.25188.29.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38380 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbYFIBhZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 8 Jun 2008 21:37:25 -0400
Content-Disposition: inline
In-Reply-To: <1212729788.25188.29.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>

On Fri, Jun 06, 2008 at 01:23:08PM +0800, Shaohua Li wrote:

>  	case ACPI_NOTIFY_EJECT_REQUEST:
>  		ata_ehi_push_desc(ehi, "ACPI event");
> -
> -		if (!is_dock_event)
> -			break;
> -
> -		/* undock event - immediate unplug */
>  		ata_acpi_detach_device(ap, dev);

Ok, just to check that I've understood the other patches - this will 
only be called if the device has actually been removed, and not if you 
merely get an EJECT_REQUEST, right? An EJECT_REQUEST from a bay device 
should always just signal userspace, and never actually cause the device 
to be deleted. I don't really like the way that you're remapping event 
types inside the dock driver - it'd be cleaner if the per-driver 
handlers received ADD_DEVICE or REMOVE_DEVICE or something.

Other than that, this looks basically fine. I'll try to test it in the 
next couple of days.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
