From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4] ACPI: use handle, not device,
 in system notification path
Date: Wed, 27 May 2009 21:32:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905272132430.25587@localhost.localdomain>
References: <20090522174223.4304.7099.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56323 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbZE1Bcr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 21:32:47 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKB00K2QYYNVJJ6@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 27 May 2009 20:32:48 -0500 (CDT)
In-reply-to: <20090522174223.4304.7099.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

applied to acpi-test

thanks,
Len Brown, Intel Open Source Technology Center

On Fri, 22 May 2009, Bjorn Helgaas wrote:

> Currently, ACPI hotplug is mostly handled in drivers.  I'm working on moving
> that hotplug support out of drivers and into the Linux/ACPI core.
> 
> These patches change the Linux/ACPI notify handling to use the
> acpi_handle a bit longer before looking up an acpi_device.
> 
> System notifications often deal with device presence and status change.
> In these cases, we may not have an acpi_device.  For example, we may
> get a Device Check notification on an object that previously was not
> present.  Since the object was not present, we would not have had an
> acpi_device for it.
> 
> Note: The last patch in this series depends on this previous patch
> that is not upstream yet:
>     http://patchwork.kernel.org/patch/21076/
> 
> Comments welcome.
> 
> ---
> 
> Bjorn Helgaas (4):
>       ACPI: use handle, not device, in system notification path
>       ACPI: remove unused return values from Bus Check & Device Check handling
>       ACPI: remove unused "status_changed" return value from Check Device handling
>       ACPI: simplify notification debug messages
> 
> 
>  drivers/acpi/bus.c |   93 +++++++++++++---------------------------------------
>  1 files changed, 23 insertions(+), 70 deletions(-)
> 
> -- 
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
