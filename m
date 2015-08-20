From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] nd_blk: add support for "read flush" DSM flag
Date: Thu, 20 Aug 2015 11:21:47 +0100
Message-ID: <20150820102147.GB19328@arm.com>
References: <1440024484-26152-1-git-send-email-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55553 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbbHTKVw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 20 Aug 2015 06:21:52 -0400
Content-Disposition: inline
In-Reply-To: <1440024484-26152-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>, Christoph Jaeger <cj@linux.com>, Dan Streetman <ddstreet@ieee.org>, Dan Williams <dan.j.williams@intel.com>, Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>, Len Brown <lenb@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, Thierry Reding <treding@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Toshi Kani <toshi.kani@hp.com>, Vishal Verma <vishal.l.verma@intel.com>, Yalin Wang <Yalin.Wang@sonymobile.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>, x86@kern

On Wed, Aug 19, 2015 at 11:48:04PM +0100, Ross Zwisler wrote:
> Add support for the "read flush" _DSM flag, as outlined in the DSM spec:
> 
> http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
> 
> This flag tells the ND BLK driver that it needs to flush the cache lines
> associated with the aperture after the aperture is moved but before any
> new data is read.  This ensures that any stale cache lines from the
> previous contents of the aperture will be discarded from the processor
> cache, and the new data will be read properly from the DIMM.  We know
> that the cache lines are clean and will be discarded without any
> writeback because either a) the previous aperture operation was a read,
> and we never modified the contents of the aperture, or b) the previous
> aperture operation was a write and we must have written back the dirtied
> contents of the aperture to the DIMM before the I/O was completed.

Is this operation expected to be implemented as a destructive invalidation
(i.e. discarding any dirty lines from the cache) or also a writeback of any
dirtylines as part of the invalidation?

If its the former, we might want to give it a scarier name to ensure that
it doesn't grow users outside of NVDIMM scenarios, since "flush" is used
elsewhere for things like flush_dcache_page.

Will
