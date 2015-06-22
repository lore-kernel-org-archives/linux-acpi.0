From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 02/15] libnvdimm: infrastructure for btt devices
Date: Mon, 22 Jun 2015 09:48:03 -0700
Message-ID: <CAPcyv4jAA0=aSUDazG5hS1FS0o+qg4SyMXicqF_0M0s7_cXBGw@mail.gmail.com>
References: <20150617235209.12943.24419.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150617235458.12943.23425.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150622163453.GA9187@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20150622163453.GA9187@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Boaz Harrosh <boaz@plexistor.com>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Neil Brown <neilb@suse.de>, Greg KH <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 22, 2015 at 9:34 AM, Christoph Hellwig <hch@lst.de> wrote:
> FYI, the mess calls into libnvdimm for each register pmem or blk device
> which then walks partitions to find your btt metadata is an absolutely
> no go and suggest that the layering is completely fucked up.

Only if you abandon BTT on partitions, which at this point it seems
you're boldly committed to doing.  It's unacceptable to drop BTT on
the floor so I'll take a look at making BTT per-disk only for 4.2.
--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
