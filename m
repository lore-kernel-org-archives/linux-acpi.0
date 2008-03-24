From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 9/16] PCI slot: Remove unused slot member from pci_dev
	(Not for mainline!)
Date: Mon, 24 Mar 2008 14:29:24 -0600
Message-ID: <20080324202924.GC11575@ldl.fc.hp.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E33693.7080102@jp.fujitsu.com> <20080321193009.GI424@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:42896 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbYCXU3Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Mar 2008 16:29:25 -0400
Content-Disposition: inline
In-Reply-To: <20080321193009.GI424@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Hi willy,

* Matthew Wilcox <matthew@wil.cx>:
> On Fri, Mar 21, 2008 at 01:16:19PM +0900, Kenji Kaneshige wrote:
> > The 'slot' member in struct pci_dev is not used. Remove this unused
> > member.
> 
> It *ought* to be used.  If it isn't yet, I guess that part of my patch
> has been dropped, and it should be re-added.
 
I checked through your original patch set:

	http://www.parisc-linux.org/~willy/pci-slot-2b/

And although I see a bunch of uses of pci_bus->slot, I don't see
any uses of pci_dev->slot.

Wanna enlighten me? :)

/ac

