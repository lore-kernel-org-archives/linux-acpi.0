From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH 0/4, v3] Physical PCI slot objects
Date: Tue, 27 Nov 2007 11:11:36 -0800
Message-ID: <20071127111136.77cb61fc@appleyard>
References: <20071117182954.GA25003@ldl.fc.hp.com>
	<20071119233225.GA6931@us.ibm.com>
	<20071126222253.GA31708@ldl.fc.hp.com>
	<20071127030454.GC23277@us.ibm.com>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3539 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbXK0TN2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Nov 2007 14:13:28 -0500
In-Reply-To: <20071127030454.GC23277@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Alex Chiang <achiang@hp.com>, Gary Hade <garyhade@us.ibm.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Mon, 26 Nov 2007 19:04:54 -0800
Gary Hade <garyhade@us.ibm.com> wrote:

> > Is this patchset appropriate for the -mm tree yet?  
> 
> I would defer to our illustrious maintainers on this one. :)
> 
> > Or do you think it still needs more work?  
> 
> I am now much more comfortable with your changes with respect
> to acpiphp on the systems I worry about but others may have
> concerns with respect to the other hotplug drivers, or even
> acpiphp, on other systems.

I'm ok with adding it to my quilt tree (and into -mm) after Gary gets
back to us later this week.
