From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Repost: asus strict model checking
Date: Wed, 02 Aug 2006 12:00:20 +0200
Message-ID: <1154512820.4302.444.camel@queen.suse.de>
References: <1154438122.4302.354.camel@queen.suse.de>
	 <44CF5DF6.9090603@linux.intel.com>
	 <1154446149.4302.386.camel@queen.suse.de>
	 <44CF7D26.5050208@linux.intel.com>
	 <1154452931.4302.407.camel@queen.suse.de>
	 <44CF92EB.4010801@linux.intel.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:10407 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750704AbWHBJ4y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2006 05:56:54 -0400
In-Reply-To: <44CF92EB.4010801@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, acpi4asus-user@lists.sourceforge.net

On Tue, 2006-08-01 at 21:44 +0400, Alexey Starikovskiy wrote:
> Thomas Renninger wrote:
> > On Tue, 2006-08-01 at 20:11 +0400, Alexey Starikovskiy wrote:
> >> Checks for Samsung P30/P35 are real hacks IMHO.
> > Why?
> Because this DSDT signature could appear on any machine, and has nothing to do
> with ASUS or Samsung.

The string seems to define how the ATKD ACPI device has to be used.
If this Device pops up on other machines than Asus it's fine.
AFAIK the mappings from the string returned by ATKD.INIT and how the
device has to be used then works fine.

It's probably much better than the way done on Thinkpads:
If we have ACPI func xy we assume to have an A21 or similar and use this
set of function/variables.

I consider this an ugly hack:
IBM_HANDLE(ec, root, "\\_SB.PCI0.ISA.EC0",	/* 240, 240x */
	   "\\_SB.PCI.ISA.EC",	/* 570 */
	   "\\_SB.PCI0.ISA0.EC0",	/* 600e/x, 770e, 770x */
	   "\\_SB.PCI0.ISA.EC",	/* A21e, A2xm/p, T20-22, X20-21 */
	   "\\_SB.PCI0.AD4S.EC0",	/* i1400, R30 */
	   "\\_SB.PCI0.ICH3.EC0",	/* R31 */
	   "\\_SB.PCI0.LPC.EC",	/* all others */

On Asus we should be happy ATKD.INIT is returning something useful and
one can guess (be sure?) which ACPI functions to use for what.
Checking for that string and making use of different ACPI
variable/method names seems to be intended and looks like the defined
way this should be used. As long as this is not officially specified (by
ACPI consortium and/or vendors) and such special Devices exist, it is
the best we can do.

   Thomas


