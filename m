From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Date: Tue, 5 Feb 2019 15:52:27 +0100
Message-ID: <20190205145227.GG17950@kroah.com>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 05, 2019 at 01:33:27PM +0100, Rafael J. Wysocki wrote:
> > +/**
> > + * struct node_access_nodes - Access class device to hold user visible
> > + *                           relationships to other nodes.
> > + * @dev:       Device for this memory access class
> > + * @list_node: List element in the node's access list
> > + * @access:    The access class rank
> > + */
> > +struct node_access_nodes {
> > +       struct device           dev;
> 
> I'm not sure if the entire struct device is needed here.
> 
> It looks like what you need is the kobject part of it only and you can
> use a kobject directly here:
> 
> struct kobject        kobj;
> 
> Then, you can register that under the node's kobject using
> kobject_init_and_add() and you can create attr groups under a kobject
> using sysfs_create_groups(), which is exactly what device_add_groups()
> does.
> 
> That would allow you to avoid allocating extra memory to hold the
> entire device structure and the extra empty "power" subdirectory added
> by device registration would not be there.

When you use a "raw" kobject then userspace tools do not see the devices
and attributes in libraries like udev.  So unless userspace does not
care about this at all, you should use a 'struct device' where ever
possible.  The memory "savings" usually just isn't worth it unless you
have a _lot_ of objects being created here.

Who is going to use all of this new information?

thanks,

greg k-h
