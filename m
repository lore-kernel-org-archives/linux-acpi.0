From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: New ACPI warnings with v3.16.0-rc1
Date: Thu, 19 Jun 2014 01:09:25 +0200
Message-ID: <8028563.JQMq23p6sJ@vostro.rjw.lan>
References: <20140618235004.25295650@saldaea>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60406 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752157AbaFRWvu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Jun 2014 18:51:50 -0400
In-Reply-To: <20140618235004.25295650@saldaea>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julian Wollrath <julian.wollrath@stud.uni-goettingen.de>
Cc: linux-acpi@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, Zhang Rui <rui.zhang@intel.com>

On Wednesday, June 18, 2014 11:50:04 PM Julian Wollrath wrote:
> Hi,

Hi,

> with v3.16.0-rc1 I get the following warnings, which I did not occur
> with v3.15.1:
> [   14.558365] ACPI Warning: SystemIO range 0x0000000000000428-0x000000000000042f conflicts with OpRegion 0x0000000000000400-0x000000000000047f (\_SB_.PCI0.LPC_.PMIO) (20140424/utaddress-258)
> [   14.558377] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
> [   14.558386] ACPI Warning: SystemIO range 0x0000000000000540-0x000000000000054f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
> [   14.558392] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
> [   14.558395] ACPI Warning: SystemIO range 0x0000000000000530-0x000000000000053f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
> [   14.558401] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver 
> [   14.558403] ACPI Warning: SystemIO range 0x0000000000000500-0x000000000000052f conflicts with OpRegion 0x0000000000000500-0x000000000000057f (\_SB_.PCI0.LPC_.LPIO) (20140424/utaddress-258)
> [   14.558409] ACPI: If an ACPI driver is available for this device,
> you should use it instead of the native driver
> 
> How can one find out, what the native driver is, and if there is an
> ACPI driver?

These are resource conflicts and I'm not sure why there were not there before.
Perhaps we introduced a new driver trying to reserve system I/O ranges
claimed by the ACPI core already.

I agree that the second part of the message is not very useful, though.

Rui and Lv (CCed) should be able to help you diagnose this problem further.

Rafael

