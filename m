From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] PNPACPI: don't complain about vendor-defined resources
Date: Sat, 12 Mar 2005 09:54:09 -0700
Message-ID: <1110646449.24086.6.camel@eeyore>
References: <1108160048.31877.75.camel@eeyore>
	 <1110344980.9332.0.camel@d845pe>
	 <1110586059.12485.225.camel@localhost.localdomain>
	 <1110587005.4822.95.camel@eeyore>
	 <1110587127.12485.236.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110587127.12485.236.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-11 at 19:25 -0500, Adam Belay wrote:
> On Fri, 2005-03-11 at 17:23 -0700, Bjorn Helgaas wrote:
> > On Fri, 2005-03-11 at 19:07 -0500, Adam Belay wrote:
> > > Just out of curiosity, are we seeing many vendor-defined resources from
> > > ACPI?
> > 
> > HP boxes have some.  Our host-to-AGP bridge, IOMMU, etc have them to
> > tell you where the device's MMIO CSR space is.
> 
> Hmm, interesting.  I'm asking because I was considering how necessary it
> would be to pass this information down to actual drivers.

See hp_acpi_csr_space(), used by the sba_iommu and hp-agp drivers.

Which reminds me, I think the idea of using a UUID to label these
vendor-defined resources made it into ACPI 3.0 (section 6.4.3.2).
My plan was to move the infrastructure behind this (everything in
arch/ia64/kernel/acpi-ext.c except the hp_ccsr_descriptor and
hp_acpi_csr_space()) out of arch/ia64 and into drivers/acpi.
Something else for my to-do list, I guess ;-)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
