From: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 1/6] libnvdimm: nd_region flush callback support
Date: Fri, 12 Apr 2019 10:32:30 +0200
Message-ID: <20190412083230.GA29850@quack2.suse.cz>
References: <20190410040826.24371-1-pagupta@redhat.com>
 <20190410040826.24371-2-pagupta@redhat.com>
 <CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christoph Hellwig <hch@infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu 11-04-19 07:51:48, Dan Williams wrote:
> On Tue, Apr 9, 2019 at 9:09 PM Pankaj Gupta <pagupta@redhat.com> wrote:
> > +       } else {
> > +               if (nd_region->flush(nd_region))
> > +                       rc = -EIO;
> 
> Given the common case wants to be fast and synchronous I think we
> should try to avoid retpoline overhead by default. So something like
> this:
> 
> if (nd_region->flush == generic_nvdimm_flush)
>     rc = generic_nvdimm_flush(...);

I'd either add a comment about avoiding retpoline overhead here or just
make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
get confused by the code.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
