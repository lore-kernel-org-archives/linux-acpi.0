From: TJ <linux@tjworld.net>
Subject: Re: [patch] PCI: Add DMI matching to i450NX fix-up for Dell
	PowerEdge 6300
Date: Fri, 11 Apr 2008 00:00:52 +0100
Message-ID: <1207868452.7578.40.camel@hephaestion.lan.tjworld.net>
References: <1207825695.7578.16.camel@hephaestion.lan.tjworld.net>
	 <20080410165802.GU11962@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tjworld.net ([67.18.187.6]:34694 "EHLO tjworld.net"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755966AbYDJXIi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Apr 2008 19:08:38 -0400
In-Reply-To: <20080410165802.GU11962@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Matthew, thanks for looking at this. It always helps to have someone who
knows the code inside-out deal with things. I built and tested with your
patch and it works correctly and is certainly better than my DMI
approach.

I'll attach your patch to the original bug report and re-subscribe the
ACPI guys since the fix is in the ACPI code now.

Maybe you can submit it so it gets into the mainline sooner rather than
later?

Many thanks

TJ.

On Thu, 2008-04-10 at 10:58 -0600, Matthew Wilcox wrote:
> On Thu, Apr 10, 2008 at 12:08:15PM +0100, TJ wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=10396
> > 
> > The fix-up checks the PCI config for the subsidiary buses and if it
> > finds them scans them. This adds them to the root_pci_bus list. Later in
> > the boot process the ACPI/PCI code reads the ACPI DSDT table, finds the
> > PCI bus entries (PNP0A03) and tries to scan them. It fails when scanning
> > the 2nd and 3rd buses with:
> > 
> > [ 0.910906] ACPI: PCI Root Bridge [PX0B] (0000:02)
> > [ 0.912085] ACPI: Bus 0000:02 not present in PCI namespace
> > [ 0.917111] ACPI: PCI Root Bridge [PX1A] (0000:03)
> > [ 0.920085] ACPI: Bus 0000:03 not present in PCI namespace
> > 
> > Unfortunately, the report is misleading since the reason is that the bus
> > is found to be already registered and therefore ignored. The situation
> > can be worked around by booting with "pci=noacpi".
> 
> I agree with your analysis of the problem.
> 
> > The solution is to make the pci_fixup_i450nx() code selective based on
> > the DMI of the system. I've introduced a patch that does this. Initially
> > the only DMI it will match is Dell PowerEdge 6300 but if other systems
> > are found to be affected the output of "dmidecode" should be captured
> > and reported. Additional DMI_MATCH entries can then be added to the
> > patch.
> 
> I disagree with your solution -- it's a bit clumsy and only solves this
> one system.  How about this solution?
> 
> ----
> 
> The PCI root bus that ACPI wants to scan may have already been discovered
> by another means.  In the case of Bugzilla 10396, it was found by
> pci_fixup_i450nx(), but there are many other ways to find root busses.
> 
> The problem is that pci_scan_bus() will return NULL both for busses
> which don't exist and for busses which were already scanned.  We could
> decide to make pci_scan_bus() return an ERR_PTR() to allow callers to
> distinguish the two situations, but it is simpler for ACPI to check
> whether the bus already exists.
> 
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c3fed31..954e314 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -302,6 +302,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
>  	 * thus the root bridge's pci_dev does not exist).
>  	 */
>  	root->bus = pci_acpi_scan_root(device, root->id.segment, root->id.bus);
> +	if (!root->bus)
> +		root->bus = pci_find_bus(root->id.segment, root->id.bus);
>  	if (!root->bus) {
>  		printk(KERN_ERR PREFIX
>  			    "Bus %04x:%02x not present in PCI namespace\n",
> 

