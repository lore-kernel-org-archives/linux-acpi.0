From: Russ Anderson <rja-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
 Reference Count warnings
Date: Wed, 1 Aug 2018 15:38:27 -0500
Message-ID: <20180801203827.ozkvldizkpsatmg5@hpe.com>
References: <20180730195545.795802877@stormcage.americas.sgi.com>
 <20180730195548.580717146@stormcage.americas.sgi.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B94DED8F@ORSMSX108.amr.corp.intel.com>
Reply-To: Russ Anderson <rja-ZPxbGqLxI0U@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B94DED8F-P5GAC/sN6hk8Ug9VwtkbtrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dimitri Sivanich <dimitri.sivanich-ZPxbGqLxI0U@public.gmane.org>, Russ Anderson <russ.anderson-ZPxbGqLxI0U@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Mike Travis <mike.travis-ZPxbGqLxI0U@public.gmane.org>, "Wysocki,
 Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>, "Schmauss,
 Erik" <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Aug 01, 2018 at 07:49:14PM +0000, Moore, Robert wrote:
> Are there any actual memory leaks, or this a consequence of the number of sockets?

It is a consequence of the number of sockets.
It is not an actual memory leak.

Thanks.

> > -----Original Message-----
> > From: Mike Travis [mailto:mike.travis-ZPxbGqLxI0U@public.gmane.org]
> > Sent: Monday, July 30, 2018 12:56 PM
> > To: Moore, Robert <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Schmauss, Erik
> > <erik.schmauss-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Wysocki, Rafael J
> > <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Cc: Russ Anderson <russ.anderson-ZPxbGqLxI0U@public.gmane.org>; Dimitri Sivanich
> > <dimitri.sivanich-ZPxbGqLxI0U@public.gmane.org>; Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>;
> > Williams, Dan J <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Verma, Vishal L
> > <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Jiang, Dave <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; linux-
> > acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org; linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org;
> > linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: [PATCH 1/1] x86, pmem, acpi: Remove excessive ACPI Large
> > Reference Count warnings
> > 
> > With the Intel BIOS support for 8 processor sockets with a full
> > complement of NVDIMMS potentially installable, and there are empty
> > sockets without NVDIMMS, there is an extremely large amount of the
> > following warnings:
> > 
> > ACPI Warning: Large Reference Count (0x1001) in object ffff99453fc71750,
> > 	Type=0x0A
> > 
> > On a 4 socket system with 4 NVDIMMs there were over 6000 of these
> > warning messages and it has been seem on systems from 4 to 32 sockets.
> > 
> > Through some guidance from the BIOS developers and testing, it appears
> > that simply bumping up the threshold for warnings from 0x1000 to 0x2000
> > eliminates these messages.  Changing them to be ACPI DEBUG messages, or
> > even removing them are other options, but it would then defeat the
> > purpose of the warnings as the problem would effectively be hidden.
> > 
> > Reviewed-by: Dimitri Sivanich <dimitri.sivanich-ZPxbGqLxI0U@public.gmane.org>
> > Tested-by: Russ Anderson <russ.anderson-ZPxbGqLxI0U@public.gmane.org>
> > Signed-off-by: Mike Travis <mike.travis-ZPxbGqLxI0U@public.gmane.org>
> > ---
> >  include/acpi/acconfig.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-4.12.orig/include/acpi/acconfig.h
> > +++ linux-4.12/include/acpi/acconfig.h
> > @@ -123,7 +123,7 @@
> > 
> >  /* Maximum object reference count (detects object deletion issues) */
> > 
> > -#define ACPI_MAX_REFERENCE_COUNT        0x1000
> > +#define ACPI_MAX_REFERENCE_COUNT        0x2000
> > 
> >  /* Default page size for use in mapping memory for operation regions */
> > 
> > 
> > --
> 

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja-ZPxbGqLxI0U@public.gmane.org
