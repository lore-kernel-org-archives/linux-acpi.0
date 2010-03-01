From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI device for ASUS EEEPC 1101HA not added
Date: Mon, 01 Mar 2010 12:49:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1003011247260.4281@localhost.localdomain>
References: <20100201032554.GZ28972@buzzloop.caiaq.de>
 <1265073562.10648.12.camel@rzhang1-desktop>
 <20100202020938.GH9007@buzzloop.caiaq.de>
 <8B81FACE836F9248894A7844CC0BA814250B6A0EAF@shzsmsx501.ccr.corp.intel.com>
 <20100202023142.GI9007@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:39211 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CARuF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2010 12:50:05 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KYM00GZB6V5SQQ6@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Mar 2010 11:49:54 -0600 (CST)
In-reply-to: <20100202023142.GI9007@buzzloop.caiaq.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "acpi4asus-user@lists.sourceforge.net" <acpi4asus-user@lists.sourceforge.net>

On Tue, 2 Feb 2010, Daniel Mack wrote:

> On Tue, Feb 02, 2010 at 10:17:17AM +0800, Zhang, Rui wrote:
> > > On Tue, Feb 02, 2010 at 09:19:22AM +0800, Zhang Rui wrote:
> > > > eeepc is handled in eeepci-laptop driver.
> > > >
> > > > ~/src/linux-2.6$ grep ASUS010 drivers/platform/*/*
> > > > drivers/platform/x86/eeepc-laptop.c:#define EEEPC_ACPI_HID
> > > 	"ASUS010"
> > > 
> > > Yes, that I know. The driver was just unable to match the device
> > > because
> > > it was not detected by the ACPI core. Works now with the patch Andrej
> > > sent. I would still like to make sure it's getting merged mainline
> > > sooner or later.
> > >
> > Oh, can you give a link to this patch please?
> 
> http://permalink.gmane.org/gmane.linux.acpi.acpi4asus.user/3781

boot the eeepc with acpi_osi="!Windows 2009"
until a WMI driver is written to handle this windows-specific BIOS.

thanks,
Len Brown, Intel Open Source Technology Center

