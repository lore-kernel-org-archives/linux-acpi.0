From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: fix types when decoding ACPI
	resources [resend]
Date: Thu, 04 Aug 2005 08:46:35 +0800
Message-ID: <1123116395.2929.1.camel@linux-hp.sh.intel.com>
References: <200508020955.54844.bjorn.helgaas@hp.com>
	 <1123030861.2937.4.camel@linux-hp.sh.intel.com>
	 <200508030920.13450.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508030920.13450.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 2005-08-03 at 09:20 -0600, Bjorn Helgaas wrote:
> On Tuesday 02 August 2005 7:01 pm, Shaohua Li wrote:
> > On Tue, 2005-08-02 at 09:55 -0600, Bjorn Helgaas wrote:
> > > Any objections to the patch below?  I posted it last Wednesday,
> > > but haven't heard anything.  Once we have this fix, 8250_pnp
> > > should have sufficient functionality that we can get rid of
> > > 8250_acpi.
> > > 
> > > Use types that match the ACPI resource structures.  Previously
> > > the u64 value from an RSTYPE_ADDRESS64 was passed as an int,
> > > which corrupts the value.
> > > 
> > > This is one of the things that prevents 8250_pnp from working
> > > on HP ia64 boxes.  After 8250_pnp works, we will be able to
> > > remove 8250_acpi.c.
> > We might always use 'unsigned long'.
> 
> Do you have a reason for preferring 'unsigned long' over the
> exact types used in the ACPI resource structures?  I thought
> it was useful to use the exact types, because then whatever
> conversion needs to happen is all in one place.
> 
> In the existing code, there's implicit conversion when you
> call "pnpacpi_parse_allocated_memresource(..., int mem, int len)"
> and pass u64 values as "mem" and "len".  You have to look both
> at the call site and the called code.  And gcc doesn't even
> complain about this truncation.
> 
> But I guess it doesn't matter much either way.
Either is ok to me.

> 
> > Did you have plan to remove other 
> > legacy acpi drivers?
> 
> No, I didn't -- which ones are you thinking about?  Looking at
> the callers of acpi_bus_register_driver(), I see:
> 
> 	arch/ia64/hp/common/sba_iommu.c
> 		Probably can't be converted because it needs the
> 		ACPI handle to extract a vendor-specific data
> 		item from _CRS.
> 
> 	drivers/char/hpet.c
> 		This probably should be converted to PNP.  I'll
> 		look into doing this.
Great! After then we could push the ACPIPNP hotplug staff.

Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
