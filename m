From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 1/6] libnvdimm: nd_region flush callback support
Date: Thu, 18 Apr 2019 12:10:44 -0400
Message-ID: <x49lg07cn0b.fsf@segfault.boston.devel.redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
        <20190410040826.24371-2-pagupta@redhat.com>
        <CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
        <20190412083230.GA29850@quack2.suse.cz>
        <x494l73z7th.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
        (Dan Williams's message of "Thu, 18 Apr 2019 09:05:05 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Christoph Hellwig <hch@infradead.org>, Len
List-Id: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Fri, Apr 12, 2019 at 6:12 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Jan Kara <jack@suse.cz> writes:
>>
>> > On Thu 11-04-19 07:51:48, Dan Williams wrote:
>> >> On Tue, Apr 9, 2019 at 9:09 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>> >> > +       } else {
>> >> > +               if (nd_region->flush(nd_region))
>> >> > +                       rc = -EIO;
>> >>
>> >> Given the common case wants to be fast and synchronous I think we
>> >> should try to avoid retpoline overhead by default. So something like
>> >> this:
>> >>
>> >> if (nd_region->flush == generic_nvdimm_flush)
>> >>     rc = generic_nvdimm_flush(...);
>> >
>> > I'd either add a comment about avoiding retpoline overhead here or just
>> > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
>> > get confused by the code.
>>
>> Isn't this premature optimization?  I really don't like adding things
>> like this without some numbers to show it's worth it.
>
> I don't think it's premature given this optimization technique is
> already being deployed elsewhere, see:
>
> https://lwn.net/Articles/774347/

The technique is fine, but that doesn't mean it should be applied
everywhere.  Is *this* code path really going to benefit from the
optimization?

-Jeff
