From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/7] doc/vm: New documentation for memory performance
Date: Mon, 10 Dec 2018 08:12:23 -0800
Message-ID: <CAPcyv4jtf8guXutLKnHt9UbyS0-sEZ5pVJfse49xe3gCCkW8dQ@mail.gmail.com>
References: <20181114224921.12123-2-keith.busch@intel.com> <20181114224921.12123-4-keith.busch@intel.com>
 <20181115125909.000067aa@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115125909.000067aa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jonathan.cameron@huawei.com
Cc: Keith Busch <keith.busch@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Greg KH <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 15, 2018 at 4:59 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Wed, 14 Nov 2018 15:49:16 -0700
> Keith Busch <keith.busch@intel.com> wrote:
[..]
> > +The kernel does not provide performance attributes for non-local memory
> > +initiators. The performance characteristics the kernel provides for
> > +the local initiators are exported are as follows::
> > +
> > +     # tree /sys/devices/system/node/nodeY/initiator_access
> > +     /sys/devices/system/node/nodeY/initiator_access
> > +     |-- read_bandwidth
> > +     |-- read_latency
> > +     |-- write_bandwidth
> > +     `-- write_latency
> > +
> > +The bandwidth attributes are provided in MiB/second.
> > +
> > +The latency attributes are provided in nanoseconds.
> > +
> > +See also: https://www.uefi.org/sites/default/files/resources/ACPI_6_2.pdf
>
> My worry here is we are explicitly making an interface that is only ever
> providing "local" node information, where local node is not the best
> defined thing in the world for complex topologies.
>
> I have no problem with that making a sensible starting point for providing
> information userspace knows what to do with, just with an interface that
> in of itself doesn't make that clear.
>
> Perhaps something as simple as
> /sys/devices/system/nodeY/local_initiatorX
> /sys/devices/system/nodeX/local_targetY
>
> That leaves us the option of coming along later and having a full listing
> when a userspace requirement has become clear.  Another option would
> be an exhaustive list of all initiator / memory pairs that exist, with
> an additional sysfs file giving a list of those that are nearest
> to avoid every userspace program having to do the search.

I worry that "local" is an HMAT specific concept when all it is in
actuality is a place for platform firmware to list the "best" or
"primary" access initiators. How about "initiator_classX" with some
documentation that the 0th class captures this primary initiator set.
That leaves the interface a straightforward way to add more classes in
the future, but with no strict association to the class number.
