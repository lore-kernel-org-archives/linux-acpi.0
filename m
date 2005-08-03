From: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>
Subject: Re: Re: [PATCH] PNPACPI: fix types when decoding ACPI resources
 [resend]
Date: Wed, 03 Aug 2005 23:16:43 +0200
Message-ID: <42F1343B.70707@free.fr>
References: <200508020955.54844.bjorn.helgaas@hp.com> <1123030861.2937.4.camel@linux-hp.sh.intel.com> <200508030920.13450.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Bjorn Helgaas wrote:
 > On Tuesday 02 August 2005 7:01 pm, Shaohua Li wrote:
 >

 >
 >>Did you have plan to remove other
 >>legacy acpi drivers?
 >
 >
 > No, I didn't -- which ones are you thinking about?  Looking at
 > the callers of acpi_bus_register_driver(), I see:
looking for METHOD_NAME__CRS is more acurate.
 >
 > 	arch/ia64/hp/common/sba_iommu.c
 > 		Probably can't be converted because it needs the
 > 		ACPI handle to extract a vendor-specific data
 > 		item from _CRS.
 >
 > 	drivers/char/hpet.c
 > 		This probably should be converted to PNP.  I'll
 > 		look into doing this.
IIRC, I am not sure that the pnp layer was able to pass the 64 bits 
memory adress for hpet correctly. But it would be nice if it works.

There are drivers/acpi/motherboard.c that done some stuff already handle 
by pnp/system.c.

There was an extention of a floppy driver in order to use acpi in -mm, 
but it seems to have been dropped.

 >
 > Then of course, there are a bunch of things in drivers/acpi/
 > (battery, button, fan, ec, etc).  I expect the reason they are
 > in drivers/acpi/ is because they need ACPI-specific functionality,
 > so they probably couldn't be converted to PNP.
yes.


Matthieu

PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
will be removed to register again the pnp device in acpi layer. Do you 
plan to add more check and for example add only device that have a CRS 
in pnp layer ?

PPS : is there any plan to integrate 
http://marc.theaimsgroup.com/?l=linux-kernel&m=111827568001255&w=2 that 
seem to fix some init problem ?


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
