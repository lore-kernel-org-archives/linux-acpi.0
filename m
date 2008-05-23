From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 0/8] docking realted fixes
Date: Fri, 23 May 2008 09:25:57 +0800
Message-ID: <1211505957.2372.10.camel@sli10-desk.sh.intel.com>
References: <1211437981.25221.32.camel@sli10-desk.sh.intel.com>
	 <20080522121416.GA3558@homac.Speedport_W_700V>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:9245 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbYEWBVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 May 2008 21:21:18 -0400
In-Reply-To: <20080522121416.GA3558@homac.Speedport_W_700V>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Holger Macht <hmacht@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, mjg59 <mjg59@srcf.ucam.org>

On Thu, 2008-05-22 at 14:14 +0200, Holger Macht wrote:
> On Thu 22. May - 14:33:01, Shaohua Li wrote:
> > docking station releted fixes
> > patch 1, 2: fix
> > patch 3, 4, 5: merge bay driver into dock driver. dock driver can handle
> > battery and bay.
> > patch 6, 7: make libata work with dock driver
> > patch 8: cleanup
> > 
> > I tested in a T43 with bay and battery hotplug, please review.
> 
> Have you seen this patch? Are those changes incorporated?
>   http://marc.info/?l=linux-acpi&m=121129188316720&w=2
I thought my patch already handles this.

> What are the advantages against just letting libata-acpi doing the _EJ0?
The idea is letting dock driver handle bay/battery/dock station hotplug.
This simplified things.

> I gave your patch set a short test and have encountered the following
> issues:
> 
>  1. No uevent on a ACPI_NOTIFY_EJECT_REQUEST giving no chance to userspace
>     to clean up filesystems etc.
> 
>  2. When a bay device is removed, the device (e.g. /dev/sr0) stays visible
>     for userspace, even after accessing it and getting a rescan and
>      'klogd: ata5.00: disabled'
So the two are one issue, uevent isn't sent. I added a .uevent method
for libata, it should be called on ACPI_NOTIFY_EJECT_REQUEST. Also
dock_notify() has a check if the dock is a bay. If yes, it just sent a
uevent, not directly handle eject. Userspace should write 1 to dock's
'undock' sysfile to actually remove bay.

Thanks,
Shaohua

