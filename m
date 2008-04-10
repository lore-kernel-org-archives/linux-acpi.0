From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch] PCI: Add DMI matching to i450NX fix-up for Dell PowerEdge 6300
Date: Thu, 10 Apr 2008 10:58:03 -0600
Message-ID: <20080410165802.GU11962@parisc-linux.org>
References: <1207825695.7578.16.camel@hephaestion.lan.tjworld.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:39197 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914AbYDJQ6V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Apr 2008 12:58:21 -0400
Content-Disposition: inline
In-Reply-To: <1207825695.7578.16.camel@hephaestion.lan.tjworld.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: TJ <linux@tjworld.net>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

On Thu, Apr 10, 2008 at 12:08:15PM +0100, TJ wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=10396
> 
> The fix-up checks the PCI config for the subsidiary buses and if it
> finds them scans them. This adds them to the root_pci_bus list. Later in
> the boot process the ACPI/PCI code reads the ACPI DSDT table, finds the
> PCI bus entries (PNP0A03) and tries to scan them. It fails when scanning
> the 2nd and 3rd buses with:
> 
> [ 0.910906] ACPI: PCI Root Bridge [PX0B] (0000:02)
> [ 0.912085] ACPI: Bus 0000:02 not present in PCI namespace
> [ 0.917111] ACPI: PCI Root Bridge [PX1A] (0000:03)
> [ 0.920085] ACPI: Bus 0000:03 not present in PCI namespace
> 
> Unfortunately, the report is misleading since the reason is that the bus
> is found to be already registered and therefore ignored. The situation
> can be worked around by booting with "pci=noacpi".

I agree with your analysis of the problem.

> The solution is to make the pci_fixup_i450nx() code selective based on
> the DMI of the system. I've introduced a patch that does this. Initially
> the only DMI it will match is Dell PowerEdge 6300 but if other systems
> are found to be affected the output of "dmidecode" should be captured
> and reported. Additional DMI_MATCH entries can then be added to the
> patch.

I disagree with your solution -- it's a bit clumsy and only solves this
one system.  How about this solution?

----

The PCI root bus that ACPI wants to scan may have already been discovered
by another means.  In the case of Bugzilla 10396, it was found by
pci_fixup_i450nx(), but there are many other ways to find root busses.

The problem is that pci_scan_bus() will return NULL both for busses
which don't exist and for busses which were already scanned.  We could
decide to make pci_scan_bus() return an ERR_PTR() to allow callers to
distinguish the two situations, but it is simpler for ACPI to check
whether the bus already exists.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index c3fed31..954e314 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -302,6 +302,8 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 	 * thus the root bridge's pci_dev does not exist).
 	 */
 	root->bus = pci_acpi_scan_root(device, root->id.segment, root->id.bus);
+	if (!root->bus)
+		root->bus = pci_find_bus(root->id.segment, root->id.bus);
 	if (!root->bus) {
 		printk(KERN_ERR PREFIX
 			    "Bus %04x:%02x not present in PCI namespace\n",

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
