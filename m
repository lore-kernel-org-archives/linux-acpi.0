From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PROBLEM: CPU fan shuts down on load of fan.ko in kernel 2.6.18 and later
Date: Mon, 15 Jan 2007 10:06:15 -0700
Message-ID: <200701151006.15790.bjorn.helgaas@hp.com>
References: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel9.hp.com ([156.153.255.214]:40459 "EHLO atlrel9.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbXAORGU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jan 2007 12:06:20 -0500
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC8298F74B@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Matthew Brett <matthew.brett@gmail.com>, Salatiel Filho <salatiel.filho@gmail.com>, linux-acpi@vger.kernel.org

On Monday 15 January 2007 06:33, Karasyov, Konstantin A wrote:
> The fan device FAN1 defines object FN01 as its power resource. _STA
> method of FN01 always return 0x01, i.e. resource is on

Ugh.  Matthew, have you checked to see whether there are any
BIOS updates available for your box?

> So the fan 
> driver is unable to turn the fan on, because it thinks that it is
> already in that state.

I suppose the fan driver could use force_power_state to work
around this BIOS bug.

> But, _ON and _OFF methods set \_TZ.THRM.FNON object to 1 and 0
> respectively, so, I think, it could be used as value returned by _STA
> method. Attached patch for DSDT should solve the fan issue.

But we can't expect users to apply DSDT patches.  So if there's
no BIOS update available, don't we have to figure out a way to
work around it?  Maybe we could notice when the BIOS reports the
device is "on" even when we've turned it off, decide that the
BIOS is lying, and always use force_power_state.

Bjorn
