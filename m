From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/5] Construct one fakephp slot per pci slot
Date: Tue, 13 Nov 2007 12:52:49 -0700
Message-ID: <20071113195249.GI17785@parisc-linux.org>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113001336.GC13341@ldl.fc.hp.com> <20071113194815.GC8421@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:37783 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756829AbXKMTww (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 14:52:52 -0500
Content-Disposition: inline
In-Reply-To: <20071113194815.GC8421@austin.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Alex Chiang <achiang@hp.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Nov 13, 2007 at 01:48:15PM -0600, Linas Vepstas wrote:
> On Mon, Nov 12, 2007 at 05:13:36PM -0700, Alex Chiang wrote:
> > +	slot->name = kmalloc(8, GFP_KERNEL);
> > +	sprintf(slot->name, "fake%d", count++);
> 
> Please use snprintf to avoid buffer overruns!

Or, since kmalloc can return a 32-byte object at smallest, just allocate
32 bytes and continue using sprintf.  fake%d would overflow after
999,999,999,999,999,999,999,999,999 pci devices, by which time we've
run the machine out of memory anyway.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
