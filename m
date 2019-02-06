From: Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCHv5 04/10] node: Link memory nodes to their compute nodes
Date: Wed, 6 Feb 2019 16:09:53 -0700
Message-ID: <20190206230953.GB30221@localhost.localdomain>
References: <20190124230724.10022-1-keith.busch@intel.com>
 <20190124230724.10022-5-keith.busch@intel.com>
 <CAJZ5v0jE_gRT5WgpQYwZQmx6N5G+axymbSySb2Nk8Q0OGeNt9A@mail.gmail.com>
 <20190205145227.GG17950@kroah.com>
 <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g4ouD+9YYPSkoN7CRLTXYymeCaVkYNzm6Q6gGdNgJbuQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, Feb 05, 2019 at 04:17:09PM +0100, Rafael J. Wysocki wrote:
> <gregkh@linuxfoundation.org> wrote:
> >
> > When you use a "raw" kobject then userspace tools do not see the devices
> > and attributes in libraries like udev.
> 
> And why would they need it in this particular case?
> 
> > So unless userspace does not care about this at all,
> 
> Which I think is the case here, isn't it?
> 
> > you should use a 'struct device' where ever
> > possible.  The memory "savings" usually just isn't worth it unless you
> > have a _lot_ of objects being created here.
> >
> > Who is going to use all of this new information?
> 
> Somebody who wants to know how the memory in the system is laid out AFAICS.

Yes, this is for user space to make informed decisions about where it
wants to allocate/relocate hot and cold data with respect to particular
compute domains. So user space should care about these attributes,
and they won't always be static when memory hotplug support for these
attributes is added.

Does that change anything, or still recommending kobject? I don't have a
strong opinion either way and have both options coded and ready to
submit new version once I know which direction is most acceptable.
