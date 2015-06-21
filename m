From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/15] libnvdimm: support read-only btt backing devices
Date: Sun, 21 Jun 2015 15:54:06 +0200
Message-ID: <20150621135406.GA9572@lst.de>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com> <20150617235602.12943.24958.stgit@dwillia2-desk3.amr.corp.intel.com> <20150621101346.GF5915@lst.de> <CAPcyv4jjTU8MA1zWnbRsyxcnxC+EJK9pJdLBkYeGtgHXeDkKVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38940 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753433AbbFUNyJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Jun 2015 09:54:09 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4jjTU8MA1zWnbRsyxcnxC+EJK9pJdLBkYeGtgHXeDkKVQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Boaz Harrosh <boaz@plexistor.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>

On Sun, Jun 21, 2015 at 06:21:50AM -0700, Dan Williams wrote:
> This question has come up before.  Making btt an internal property of
> a device makes some things cleaner and others more messy.  We lose the
> ability to place a btt instance on top of a partition, rather than a
> whole disk.

I thought the addition of nfit labels avoids the need for a partition
table now?

> If we ever need to access the raw device we no longer
> have a direct block device to reference.  Linux has been doing stacked
> configurations to change the personality of block devices since
> forever (md, dm, bcache...), why invent something new to handle the
> btt-personality of ->rw_bytes() devices?

Because the underlying abstraction really isn't a block device
anymore, it's a byte addressable device.  This is more similar to
for example how the mtd subsystem is structured.

> BTT precludes DAX, if you want both modes on one pmem disk placing BTT
> on a partition of the disk for fs metadata and DAX-capable data on the
> rest is our proposed solution.  We chose this architecture after a
> conversation with Dave Chinner about XFS's need to have atomic sector
> guarantees for its metadata and wanting to simultaneously enable
> XFS-DAX.

I can't see why a v5 XFS filesystem with CRCs on all metadata would need
sector atomic updates any more.  But even in a case where it would it
seem like whatever label you use for partioning should sit above the
block layer.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
