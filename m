From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 16/16] ACPI: add DMI entry to work around another insane
 Toshiba BIOS
Date: Wed, 29 Sep 2010 13:27:23 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1009291320180.6673@localhost.localdomain>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
 <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
 <20100929154830.GA24577@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:56546 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab0I2R1f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Sep 2010 13:27:35 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9I0077WR5R8O71@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 29 Sep 2010 12:27:28 -0500 (CDT)
In-reply-to: <20100929154830.GA24577@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

> On Tue, Sep 28, 2010 at 11:44:46PM -0400, Len Brown wrote:
> > From: Len Brown <len.brown@intel.com>
> > 
> > Toshiba Satellite C655D-S5048
> 
> Why are we not making this the default behaviour, perhaps with a boot or 
> config option to disable it if people really can't live with the memory 
> hit?

It looks like only Toshiba Satellite have this flaw.

It would not be fair to every Linux/ACPI system out there
to double ACPI table size because of bugs at Toshiba.

Perhaps we should wild-card and make this the default
for all Toshiba Satellite.  I expect we can do this
simply by leaving the model number off.  eg

- DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
+ DMI_MATCH(DMI_PRODUCT_NAME, "Satellite"),

The down-side, of course, is that Satellite's in the future
will continue to pay for the bugs of Satellite's past --
but I'd not lose any sleep over that.

thanks,
Len Brown, Intel Open Source Technology Center


