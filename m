From: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] PNPACPI: don't complain about vendor-defined resources
Date: Fri, 11 Mar 2005 19:25:27 -0500
Message-ID: <1110587127.12485.236.camel@localhost.localdomain>
References: <1108160048.31877.75.camel@eeyore>
	 <1110344980.9332.0.camel@d845pe>
	 <1110586059.12485.225.camel@localhost.localdomain>
	 <1110587005.4822.95.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110587005.4822.95.camel@eeyore>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-03-11 at 17:23 -0700, Bjorn Helgaas wrote:
> On Fri, 2005-03-11 at 19:07 -0500, Adam Belay wrote:
> > On Wed, 2005-03-09 at 00:09 -0500, Len Brown wrote:
> > > Applied.
> > > 
> > > thanks,
> > > -Len
> > 
> > Just out of curiosity, are we seeing many vendor-defined resources from
> > ACPI?
> 
> HP boxes have some.  Our host-to-AGP bridge, IOMMU, etc have them to
> tell you where the device's MMIO CSR space is.

Hmm, interesting.  I'm asking because I was considering how necessary it
would be to pass this information down to actual drivers.

Thanks,
Adam




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
