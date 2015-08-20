From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2] nd_blk: add support for "read flush" DSM flag
Date: Thu, 20 Aug 2015 10:08:06 -0600
Message-ID: <1440086886.30197.1.camel@linux.intel.com>
References: <1440024484-26152-1-git-send-email-ross.zwisler@linux.intel.com>
	 <20150820102147.GB19328@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150820102147.GB19328@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Christoph Hellwig <hch@lst.de>, Christoph Jaeger <cj@linux.com>, Dan Streetman <ddstreet@ieee.org>, Dan Williams <dan.j.williams@intel.com>, Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>, Len Brown <lenb@kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Stephen Rothwell <sfr@canb.auug.org.au>, Thierry Reding <treding@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Toshi Kani <toshi.kani@hp.com>, Vishal Verma <vishal.l.verma@intel.com>, Yalin Wang <Yalin.Wang@sonymobile.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@ml01.01.org" <linux-nvdimm@ml01.01.org>, x86@kern
List-Id: linux-acpi@vger.kernel.org

On Thu, 2015-08-20 at 11:21 +0100, Will Deacon wrote:
> On Wed, Aug 19, 2015 at 11:48:04PM +0100, Ross Zwisler wrote:
> > Add support for the "read flush" _DSM flag, as outlined in the DSM spec:
> > 
> > http://pmem.io/documents/NVDIMM_DSM_Interface_Example.pdf
> > 
> > This flag tells the ND BLK driver that it needs to flush the cache lines
> > associated with the aperture after the aperture is moved but before any
> > new data is read.  This ensures that any stale cache lines from the
> > previous contents of the aperture will be discarded from the processor
> > cache, and the new data will be read properly from the DIMM.  We know
> > that the cache lines are clean and will be discarded without any
> > writeback because either a) the previous aperture operation was a read,
> > and we never modified the contents of the aperture, or b) the previous
> > aperture operation was a write and we must have written back the dirtied
> > contents of the aperture to the DIMM before the I/O was completed.
> 
> Is this operation expected to be implemented as a destructive invalidation
> (i.e. discarding any dirty lines from the cache) or also a writeback of any
> dirtylines as part of the invalidation?
> 
> If its the former, we might want to give it a scarier name to ensure that
> it doesn't grow users outside of NVDIMM scenarios, since "flush" is used
> elsewhere for things like flush_dcache_page.

It is the latter - there will be a writeback of any dirty lines as part of the
invalidation.  The real thing I'm looking for is a forced invalidation
(including writeback, if needed), even on architectures that are cache
coherent.  This is useful when the device can change the data at that memory
location, but not as part of a normal DMA operation that would keep the cache
coherent.
