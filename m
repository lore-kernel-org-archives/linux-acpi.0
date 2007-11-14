From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 0/5, v2] Physical PCI slot objects
Date: Wed, 14 Nov 2007 12:36:05 -0700
Message-ID: <20071114193605.GA25002@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:21319 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbXKNTgH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 14:36:07 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, achiang@hp.com, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

* Alex Chiang <achiang@hp.com>:
> 
> Actually, I just reworked my patch this morning, and believe that
> I have a much cleaner implementation now that should fix a lot of
> the errors you saw.

Patch 1/5 - reworked to fix stupid compile bug
Patch 2/5 - incorporate Eike, Linas, and Willy's comments
Patch 3/5 - no change
Patch 4/5 - was acpi-pci-slot-driver patch, now modifies
	    pci_add_hotplug(). I changed the ordering on this so
	    the tree doesn't break at this point in the series
Patch 5/5 - now is acpi-pci-slot-driver patch, cleaned up
	    implementation so our slot detection is a little
	    better

Thanks.

/ac

