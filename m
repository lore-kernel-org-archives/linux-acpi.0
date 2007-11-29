From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH 0/4, v3] Physical PCI slot objects
Date: Wed, 28 Nov 2007 16:02:38 -0800
Message-ID: <20071128160238.3c8685e5@orpington>
References: <20071117182954.GA25003@ldl.fc.hp.com>
	<20071119233225.GA6931@us.ibm.com>
	<20071126222253.GA31708@ldl.fc.hp.com>
	<20071127030454.GC23277@us.ibm.com>
	<20071127111136.77cb61fc@appleyard>
	<20071128213147.GA6199@us.ibm.com>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39250 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372AbXK2AIV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Nov 2007 19:08:21 -0500
In-Reply-To: <20071128213147.GA6199@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Gary Hade <garyhade@us.ibm.com>, Alex Chiang <achiang@hp.com>, Matthew Wilcox <matthew@wil.cx>, gregkh@suse.de, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Wed, 28 Nov 2007 13:31:47 -0800
Gary Hade <garyhade@us.ibm.com> wrote:

> FYI, the node contains 2 hotpluggable PCIe slots and 5
> non-hotpluggable PCIe slots but 'pci_slot' only exposed
> the 2 hotpluggable slots.  This does not appear to be due
> to a 'pci_slot' driver problem since I looked at the DSDT
> and SSDT and found that there are currently no _SUN methods
> for the non-hotpluggable slots.

Thanks for testing Gary.  I would think this situation would be the
common case, since I doubt most firmware writers would bother to
implement _SUN for non-hotpluggable slots -- at least on other DSDT
I've seen this has been the case as well.  
