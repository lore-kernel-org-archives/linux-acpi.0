From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/3] ACPI processor _HID cleanups
Date: Wed, 27 May 2009 21:14:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905272114390.25587@localhost.localdomain>
References: <20090427223244.16549.99553.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:27175 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbZE1BOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 21:14:42 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKB007USY4K4050@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 27 May 2009 20:14:44 -0500 (CDT)
In-reply-to: <20090427223244.16549.99553.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

applied

thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 27 Apr 2009, Bjorn Helgaas wrote:

> ---
> 
> Bjorn Helgaas (3):
>       ACPI: processor: move device _HID into driver
>       ACPI: processor: check for synthetic _HID, default to "Device" declaration
>       ACPI: use LNXCPU, not ACPI_CPU, for Linux-specific processor _HID
> 
> 
>  drivers/acpi/processor_core.c |   32 ++++++++++++++++----------------
>  include/acpi/acpi_drivers.h   |    3 +--
>  2 files changed, 17 insertions(+), 18 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
