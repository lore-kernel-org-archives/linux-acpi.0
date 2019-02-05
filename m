From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Date: Tue, 5 Feb 2019 16:17:09 +0100
Message-ID: <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
References: <20190124230724.10022-1-keith.busch@intel.com> <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com> <20190205145227.GG17950@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205145227.GG17950@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Keith Busch <keith.busch@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 5, 2019 at 3:52 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 05, 2019 at 01:33:27PM +0100, Rafael J. Wysocki wrote:
> > > +/**
> > > + * struct node_access_nodes - Access class device to hold user visible
> > > + *                           relationships to other nodes.
> > > + * @dev:       Device for this memory access class
> > > + * @list_node: List element in the node's access list
> > > + * @access:    The access class rank
> > > + */
> > > +struct node_access_nodes {
> > > +       struct device           dev;
> >
> > I'm not sure if the entire struct device is needed here.
> >
> > It looks like what you need is the kobject part of it only and you can
> > use a kobject directly here:
> >
> > struct kobject        kobj;
> >
> > Then, you can register that under the node's kobject using
> > kobject_init_and_add() and you can create attr groups under a kobject
> > using sysfs_create_groups(), which is exactly what device_add_groups()
> > does.
> >
> > That would allow you to avoid allocating extra memory to hold the
> > entire device structure and the extra empty "power" subdirectory added
> > by device registration would not be there.
>
> When you use a "raw" kobject then userspace tools do not see the devices
> and attributes in libraries like udev.

And why would they need it in this particular case?

> So unless userspace does not care about this at all,

Which I think is the case here, isn't it?

> you should use a 'struct device' where ever
> possible.  The memory "savings" usually just isn't worth it unless you
> have a _lot_ of objects being created here.
>
> Who is going to use all of this new information?

Somebody who wants to know how the memory in the system is laid out AFAICS.
