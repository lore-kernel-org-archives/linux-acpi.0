From: Holger Macht <hmacht@suse.de>
Subject: Re: [PATCH 0/8] docking realted fixes
Date: Thu, 22 May 2008 14:14:17 +0200
Message-ID: <20080522121416.GA3558@homac.Speedport_W_700V>
References: <1211437981.25221.32.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34457 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760966AbYEVML5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 08:11:57 -0400
Content-Disposition: inline
In-Reply-To: <1211437981.25221.32.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, mjg59 <mjg59@srcf.ucam.org>

On Thu 22. May - 14:33:01, Shaohua Li wrote:
> docking station releted fixes
> patch 1, 2: fix
> patch 3, 4, 5: merge bay driver into dock driver. dock driver can handle
> battery and bay.
> patch 6, 7: make libata work with dock driver
> patch 8: cleanup
> 
> I tested in a T43 with bay and battery hotplug, please review.

Have you seen this patch? Are those changes incorporated?
  http://marc.info/?l=linux-acpi&m=121129188316720&w=2

What are the advantages against just letting libata-acpi doing the _EJ0?

I gave your patch set a short test and have encountered the following
issues:

 1. No uevent on a ACPI_NOTIFY_EJECT_REQUEST giving no chance to userspace
    to clean up filesystems etc.

 2. When a bay device is removed, the device (e.g. /dev/sr0) stays visible
    for userspace, even after accessing it and getting a rescan and
     'klogd: ata5.00: disabled'

Regards,
	Holger
