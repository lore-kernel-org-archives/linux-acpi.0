From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 2/5] Construct one fakephp slot per pci slot
Date: Wed, 14 Nov 2007 13:12:47 -0700
Message-ID: <20071114201246.GZ17785@parisc-linux.org>
References: <20071114193605.GA25002@ldl.fc.hp.com> <20071114193729.GC25002@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:57413 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbXKNUMu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 15:12:50 -0500
Content-Disposition: inline
In-Reply-To: <20071114193729.GC25002@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Gary Hade <garyhade@us.ibm.com>, Greg KH <greg@kroah.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel

On Wed, Nov 14, 2007 at 12:37:29PM -0700, Alex Chiang wrote:
> Register one slot per slot, rather than one slot per function.
> Change the name of the slot to fake%d instead of the pci address.

> +#define SLOT_NAME_SIZE KOBJ_NAME_LEN

Defined, then never used ... how about s/KOBJ_NAME_LEN/8/, then use
SLOT_NAME_SIZE throughout?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
