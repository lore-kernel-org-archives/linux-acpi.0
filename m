From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: New ACPI warnings with v3.16.0-rc1
Date: Thu, 19 Jun 2014 06:58:09 +0800
Message-ID: <1403132289.30783.30.camel@rzhang1-toshiba>
References: <20140618235004.25295650@saldaea>
	 <8028563.JQMq23p6sJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:57251 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbaFRW6T (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jun 2014 18:58:19 -0400
In-Reply-To: <8028563.JQMq23p6sJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Julian Wollrath <julian.wollrath@stud.uni-goettingen.de>, linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>

On Thu, 2014-06-19 at 01:09 +0200, Rafael J. Wysocki wrote:
> On Wednesday, June 18, 2014 11:50:04 PM Julian Wollrath wrote:
> > Hi,
> 
> Hi,
> 
> > with v3.16.0-rc1 I get the following warnings, which I did not occur
> > with v3.15.1:
> > [   14.558365] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x0000000000000400-0x000000000000047f (\_SB_.PCI0.LPC_.PMIO) (20140424/utaddress-258)
> > [   14.558377] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
> > [   14.558386] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
> > [   14.558392] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
> > [   14.558395] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
> > [   14.558401] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
> > [   14.558403] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
> > [   14.558409] ACPI: If an ACPI driver is available for this device,
> > you should use it instead of the native driver
> > 
> > How can one find out, what the native driver is, and if there is an
> > ACPI driver?

please attach the acpidump output.

thanks,
rui
> 
> These are resource conflicts and I'm not sure why there were not there before.
> Perhaps we introduced a new driver trying to reserve system I/O ranges
> claimed by the ACPI core already.
> 
> I agree that the second part of the message is not very useful, though.
> 
> Rui and Lv (CCed) should be able to help you diagnose this problem further.
> 
> Rafael
> 


