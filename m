From: Pankaj Gupta <pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 1/6] libnvdimm: nd_region flush callback support
Date: Tue, 23 Apr 2019 00:07:03 -0400 (EDT)
Message-ID: <1744824090.22901808.1555992423081.JavaMail.zimbra@redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
 <x494l73z7th.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4jrNHqW3FuGkeo==ZoJr7LKahCv4_esnokfy7enek8=2Q@mail.gmail.com>
 <20190418161833.GA22970@infradead.org>
 <CAPcyv4jPOF_+R6U17J_+88+X8LC-LSPCugA6gbKxuphuuFB2gg@mail.gmail.com>
 <x497ebm82d4.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gGmN2LLMPy6BzWpYhRyV7fFNVgh=xAWSAdnnAWu5APtg@mail.gmail.com>
 <x49ef5t7nwp.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <x49ef5t7nwp.fsf-RRHT56Q3PSP4kTEheFKJxxDDeQx5vsVwAInAS/Ez/D0@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Jeff Moyer <jmoyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: cohuck-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jason Wang <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, david <david-FqsqvQoI3Ljby3iVrkZq2A@public.gmane.org>, Qemu Developers <qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Andreas Dilger <adilger.kernel-m1MBpc4rdrD3fQ9qLvQP4Q@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, David Hildenbrand <david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-ext4 <linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, kilobyte-b9QjgO8OEXPVItvQsEIGlw@public.gmane.org, Rik van Riel <riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org>, yuval shaia <yuval.shaia-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Stefan Hajnoczi <stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, lcapitulino-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Kevin Wolf <kwolf-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Nitesh
List-Id: linux-acpi@vger.kernel.org


> 
> Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> 
> > On Mon, Apr 22, 2019 at 8:59 AM Jeff Moyer <jmoyer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> >>
> >> Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> writes:
> >>
> >> > On Thu, Apr 18, 2019 at 9:18 AM Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
> >> > wrote:
> >> >>
> >> >> On Thu, Apr 18, 2019 at 09:05:05AM -0700, Dan Williams wrote:
> >> >> > > > I'd either add a comment about avoiding retpoline overhead here
> >> >> > > > or just
> >> >> > > > make ->flush == NULL mean generic_nvdimm_flush(). Just so that
> >> >> > > > people don't
> >> >> > > > get confused by the code.
> >> >> > >
> >> >> > > Isn't this premature optimization?  I really don't like adding
> >> >> > > things
> >> >> > > like this without some numbers to show it's worth it.
> >> >> >
> >> >> > I don't think it's premature given this optimization technique is
> >> >> > already being deployed elsewhere, see:
> >> >> >
> >> >> > https://lwn.net/Articles/774347/
> >> >>
> >> >> For one this one was backed by numbers, and second after feedback
> >> >> from Linux we switched to the NULL pointer check instead.
> >> >
> >> > Ok I should have noticed the switch to NULL pointer check. However,
> >> > the question still stands do we want everyone to run numbers to
> >> > justify this optimization, or make it a new common kernel coding
> >> > practice to do:
> >> >
> >> >     if (!object->op)
> >> >         generic_op(object);
> >> >     else
> >> >         object->op(object);
> >> >
> >> > ...in hot paths?
> >>
> >> I don't think nvdimm_flush is a hot path.  Numbers of some
> >> representative workload would prove one of us right.
> >
> > I'd rather say that the if "if (!op) do_generic()" pattern is more
> > readable in the general case, saves grepping for who set the op in the
> > common case. The fact that it has the potential to be faster is gravy
> > at that point.
> 
> If the primary motivation is performance, then I'd expect performance
> numbers to back it up.  If that isn't the primary motivation, then
> choose whichever way you feel is appropriate.

Agree. This change enhances the code readability. Will add this change in
v6 with other changes.

Thank you! 

Pankaj

> 
> Cheers,
> Jeff
> 
