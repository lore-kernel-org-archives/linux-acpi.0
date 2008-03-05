From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/3, v8] PCI, ACPI: Physical PCI slot objects
Date: Tue, 4 Mar 2008 20:47:10 -0800
Message-ID: <20080305044710.GD22501@suse.de>
References: <20080305004252.GJ3694@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34522 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755107AbYCEEnF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Mar 2008 23:43:05 -0500
Content-Disposition: inline
In-Reply-To: <20080305004252.GJ3694@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, Gary Hade <garyhade@us.ibm.com>, kaneshige.kenji@jp.fujitsu.com, warthog19@eaglescrag.net, kristen.c.accardi@intel.com

On Tue, Mar 04, 2008 at 05:42:52PM -0700, Alex Chiang wrote:
> Hi Greg, all,
> 
> This is v8 of my "introduce pci_slot" series, to be considered for
> inclusion in linux-next to get more test exposure and shake out
> the bugs.

Can you work with Kenji to get his approval on this before I add this to
the tree?  It sounds like there are still some outstanding issues
getting this to work properly on his hardware.  It needs to work without
relying on a module not being loaded, as the distros are never going to
go for that kind of solution.

thanks,

greg k-h
