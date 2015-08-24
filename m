From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] nfit, nd_blk: BLK status register is only 32 bits
Date: Mon, 24 Aug 2015 11:40:42 -0600
Message-ID: <20150824174042.GA18754@linux.intel.com>
References: <1440109658-29164-1-git-send-email-ross.zwisler@linux.intel.com>
 <x49wpwkbox2.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:32241 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751179AbbHXRlY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2015 13:41:24 -0400
Content-Disposition: inline
In-Reply-To: <x49wpwkbox2.fsf@segfault.boston.devel.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, Aug 24, 2015 at 01:02:17PM -0400, Jeff Moyer wrote:
> Ross Zwisler <ross.zwisler@linux.intel.com> writes:
> 
> > Only read 32 bits for the BLK status register in read_blk_stat().
> >
> > The format and size of this register is defined in the
> > "NVDIMM Driver Writer's guide":
> >
> > http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
> >
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Reported-by: Nicholas Moulin <nicholas.w.moulin@linux.intel.com>
> 
> Looks fine,
> 
> Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
> 
> However, now that you've drawn attention to that code, I'll note that
> there is no checking of the pending or retry bits.  In fact,
> ACPI_NFIT_CONTROL_BUFFERED isn't even checked upon loading the tables.
> Is this on a todo list somewhere?

Yep, you're right, we do need to add support for each of these.  I'm planning
on doing it unless someone else gets to it first.
