From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI: fix vendor resource length computation
Date: Thu, 16 Feb 2006 09:59:23 +0100
Message-ID: <43F43EEB.1080404@suse.de>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05B87489@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:47773 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750777AbWBPI7b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Feb 2006 03:59:31 -0500
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05B87489@scsmsx401.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andreas Schwab <schwab@suse.de>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>, efocht@hpce.nec.com

Luck, Tony wrote:
>> I'm working on the alignment issue also, should be a fix this week.
> 
> With Bjorn's tip on using console=uart,mmio,0x{address} I can now
> get a complete trace from boot using acpi_dbg_level = 0xffffff ...
> well in theory I can, I started the boot two days ago and have
> 2.2 million lines of output so far, and it is still going!  Now
> I'm just curious as to whether this will actually complete, but
> if it doesn't do so in the next few days I'll have to abort the
> boot and get back to using that system for regression testing on
> other patches.
> 
> Sadly, I think that using the "console=uart,..." flag may have
> caused the kernel to skip the bit of acpi probing that caused the
> unaligned traps, as I don't see any "unaligned" messages in the
> output so far ... so this might be a completely futile exercise.
> 
Better don't use the boot parameters. Try to identify at which point
the culprit might lie and then embed the code you like to
debug in the sources into:
acpi_dbg_level=0xXY (whatever debug level, avoid mutex and other
                        unnecessary stuff you don't need)
... bad code to debug

acpi_dbg_level=0xF

I expect the output will never end, there will pop up an acpi interrupt
or some polling is done by ACPI and you are trapped in endless output...

    Thomas
