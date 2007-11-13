From: Rick Jones <rick.jones2@hp.com>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 14:51:13 -0800
Message-ID: <473A2A61.7030303@hp.com>
References: <20071113000853.GA13341@ldl.fc.hp.com>	<20071113170129.GA20185@kroah.com>	<20071113202154.GA22812@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel13.hp.com ([156.153.255.238]:43250 "EHLO palrel13.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761610AbXKMWvR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Nov 2007 17:51:17 -0500
In-Reply-To: <20071113202632.GA3227@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alex Chiang <achiang@hp.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org, Richard Jones <rick.jones2@hp.com>

Greg KH wrote:
> Doesn't /sys/firmware/acpi give you raw access to the correct tables
> already?
> 
> And isn't there some other tool that dumps the raw ACPI tables?  I
> thought the acpi developers used it all the time when debugging things
> with users.

I'm neither an acpi developer (well I don't think that I am :) nor an
end-user, but here are the two things for which I was going to use the
information being presented by Alex's patch:

1) a not-yet, but on track to be released tool to be used by end-users
to diagnose I/O bottlenecks - the information in
/sys/bus/pci/slot/<foo>/address would be used to associated interfaces
and/or pci busses etc with something the end user would grok - the
number next to the slot.

2) I was also going to get the folks doing installers to make use of the
"end-user" slot ID. Even without going to the extreme of the
aforementioned 192 slot system, an 8 slot system with a bunch of
dual-port NICs in it (for example) is going to present this huge list of
otherwise identical entries. Even if the installers show the MAC for a
NIC (or I guess a WWN for an HBA or whatnot) that still doesn't tell one
without prior knowledge of what MACs were installed in which slot, which
slot is associated with a given ethN. Having the end-user slot ID
visible is then going to be a great help to that poor admin who is doing
the install.

rick jones
