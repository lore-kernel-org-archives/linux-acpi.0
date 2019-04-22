From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH v5 1/6] libnvdimm: nd_region flush callback support
Date: Mon, 22 Apr 2019 17:03:50 -0400
Message-ID: <x49ef5t7nwp.fsf@segfault.boston.devel.redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
        <20190410040826.24371-2-pagupta@redhat.com>
        <CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
        <20190412083230.GA29850@quack2.suse.cz>
        <x494l73z7th.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
        <20190418161833.GA22970@infradead.org>
        <CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
        <x497ebm82d4.fsf@segfault.boston.devel.redhat.com>
        <CAPcyv4gGmN2LLMPy6BzWpYhRyV7fFNVgh=xAWSAdnnAWu5APtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4gGmN2LLMPy6BzWpYhRyV7fFNVgh=xAWSAdnnAWu5APtg@mail.gmail.com>
        (Dan Williams's message of "Mon, 22 Apr 2019 12:44:21 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, KVM list <kvm@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, linux-ext4 <linux-ext4@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, Ross Zwisler <zwisler@kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Matthew Wilcox <willy@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len
List-Id: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, Apr 22, 2019 at 8:59 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Dan Williams <dan.j.williams@intel.com> writes:
>>
>> > On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch@infradead.org> wrote:
>> >>
>> >> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
>> >> > > > I'd either add a comment about avoiding retpoline overhead here or just
>> >> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that people don't
>> >> > > > get confused by the code.
>> >> > >
>> >> > > Isn't this premature optimization?  I really don't like adding things
>> >> > > like this without some numbers to show it's worth it.
>> >> >
>> >> > I don't think it's premature given this optimization technique is
>> >> > already being deployed elsewhere, see:
>> >> >
>> >> > https://lwn.net/Articles/774347/
>> >>
>> >> For one this one was backed by numbers, and second after feedback
>> >> from Linux we switched to the NULL pointer check instead.
>> >
>> > Ok I should have noticed the switch to NULL pointer check. However,
>> > the question still stands do we want everyone to run numbers to
>> > justify this optimization, or make it a new common kernel coding
>> > practice to do:
>> >
>> >     if (!object->op)
>> >         generic_op(object);
>> >     else
>> >         object->op(object);
>> >
>> > ...in hot paths?
>>
>> I don't think nvdimm_flush is a hot path.  Numbers of some
>> representative workload would prove one of us right.
>
> I'd rather say that the if "if (!op) do_generic()" pattern is more
> readable in the general case, saves grepping for who set the op in the
> common case. The fact that it has the potential to be faster is gravy
> at that point.

If the primary motivation is performance, then I'd expect performance
numbers to back it up.  If that isn't the primary motivation, then
choose whichever way you feel is appropriate.

Cheers,
Jeff
