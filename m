From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 2/5] Construct one fakephp slot per pci slot
Date: Wed, 14 Nov 2007 13:55:55 -0700
Message-ID: <20071114205555.GH25002@ldl.fc.hp.com>
References: <20071114193605.GA25002@ldl.fc.hp.com> <20071114193729.GC25002@ldl.fc.hp.com> <20071114201246.GZ17785@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel12.hp.com ([156.153.255.237]:38092 "EHLO palrel12.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762075AbXKNUz6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 15:55:58 -0500
Content-Disposition: inline
In-Reply-To: <20071114201246.GZ17785@parisc-linux.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Gary Hade <garyhade@us.ibm.com>, Greg KH <greg@kroah.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

* Matthew Wilcox <matthew@wil.cx>:
> On Wed, Nov 14, 2007 at 12:37:29PM -0700, Alex Chiang wrote:
> > Register one slot per slot, rather than one slot per function.
> > Change the name of the slot to fake%d instead of the pci address.
> 
> > +#define SLOT_NAME_SIZE KOBJ_NAME_LEN
> 
> Defined, then never used ... how about s/KOBJ_NAME_LEN/8/, then use
> SLOT_NAME_SIZE throughout?

Whoops, good catch. I had a braino there.

Thanks.

/ac

