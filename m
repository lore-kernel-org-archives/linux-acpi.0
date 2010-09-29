From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 16/16] ACPI: add DMI entry to work around another insane
 Toshiba BIOS
Date: Wed, 29 Sep 2010 13:53:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009291343160.3855@localhost.localdomain>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
 <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
 <20100929154830.GA24577@srcf.ucam.org>
 <alpine.LFD.2.00.1009291320180.6673@localhost.localdomain>
 <20100929173245.GA26718@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:56475 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab0I2RxX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 13:53:23 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9I00JU3SCGV3Z1@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 29 Sep 2010 12:53:07 -0500 (CDT)
In-reply-to: <20100929173245.GA26718@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

> > It looks like only Toshiba Satellite have this flaw.
> 
> If the Leading Other OS is liberal in what it accepts, we're leaving 
> ourselves open to reduced compatibility if someone else ends up making 
> the same mistake. The hit looks to be around 300K or less.

We've been "open" to this issue ever since we started using
ACPI tables "in-place" many years ago.  Only Toshiba Satellite
has failed.  Also, now we check for table corruption.

I think there need to be limits on the extent that we make
Linux stupid in the name of Windows bug compatibility.
If we find that many vendors and models run into this,
we can always re-consider.

thanks,
Len Brown, Intel Open Source Technology Center



