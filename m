From: Aishwarya Pant <aishpant-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi: nfit: document sysfs interface
Date: Fri, 23 Feb 2018 18:30:53 +0530
Message-ID: <20180223130053.GA17196@mordor.localdomain>
References: <20180219180754.GA31007@mordor.localdomain>
 <CAPcyv4iQzEeZO-LYPvKQJHzrb3mrgENWZdnH2LzDV49tyfNM2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4iQzEeZO-LYPvKQJHzrb3mrgENWZdnH2LzDV49tyfNM2Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 21, 2018 at 03:46:06PM -0800, Dan Williams wrote:

<snip>

> 
> So, this looks great and is something I've had on my backlog for a
> while. That said this is a bit incomplete. These attributes are
> relative to the the "nd" bus which is the libnvdimm sub-system sysfs
> interface. This document describes that sysfs layout [3]. Ideally that
> content would be converted into Documentation/ABI format and merged
> with what you have done here into an overall
> Documentation/ABI/testing/sysfs-bus-nvdimm file.
> 
> I realize that's quite a bit more work, so I'm fine if we start with
> the nfit attributes and save that follow on work for a separate patch
> in the future.

Thanks for the review!

I'll keep the libnvdim interface in my backlog for now. I just sent a revision
of the nfit patch with the suggested changes.

Aishwarya

> 
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/Documentation/nvdimm/nvdimm.txt?h=libnvdimm-for-next
