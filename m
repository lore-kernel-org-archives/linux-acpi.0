From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Fw: Re: 2.6.12-rc2-mm2
Date: 08 Apr 2005 23:20:34 -0400
Message-ID: <1113016833.2418.14.camel@d845pe>
References: <20050408092947.41175d63.akpm@osdl.org>
	 <425707A2.2050208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <425707A2.2050208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Michael Thonke <iogl64nx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-04-08 at 18:37, Michael Thonke wrote:
> Hi Andrew and Bjorn,
> 
> but whats so different that causes some PCI-E cards to get not
> regonized
> or working at all?
> I mean 2.6.11.x works and 2.6.12-rc2 works,while 2.6.12-rc1 was like
> mm-behavior with
> 
> ACPI: Can't get handler for
> 

Not possible, the code that prints that (nop) string
is not present in Linus' tree -- it exists only in the mm patch.

Indeed, the glue.c code that prints this message has been in
mm tree, and you can remove just that patch by getting it here:
http://linux-acpi.bkbits.net:8080/to-akpm/cset@423bb5a2CcvybiQpT6qaZpTIzPtzCQ

If 2.6.12-rc1 was broken like the mm tree, then it could
have had noting to do with this.

-Len



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
