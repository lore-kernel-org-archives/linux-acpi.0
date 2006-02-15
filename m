From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH] ACPI: fix vendor resource length computation
Date: Wed, 15 Feb 2006 11:05:07 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05B87489@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:48052 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751252AbWBOTFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Feb 2006 14:05:31 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andreas Schwab <schwab@suse.de>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-ia64@vger.kernel.org, Andrew Morton <akpm@osdl.org>, efocht@hpce.nec.com

> I'm working on the alignment issue also, should be a fix this week.

With Bjorn's tip on using console=uart,mmio,0x{address} I can now
get a complete trace from boot using acpi_dbg_level = 0xffffff ...
well in theory I can, I started the boot two days ago and have
2.2 million lines of output so far, and it is still going!  Now
I'm just curious as to whether this will actually complete, but
if it doesn't do so in the next few days I'll have to abort the
boot and get back to using that system for regression testing on
other patches.

Sadly, I think that using the "console=uart,..." flag may have
caused the kernel to skip the bit of acpi probing that caused the
unaligned traps, as I don't see any "unaligned" messages in the
output so far ... so this might be a completely futile exercise.

-Tony
