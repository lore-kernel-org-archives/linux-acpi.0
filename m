From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] /sys/firmware/acpi/memory/ for showing info of ACPI memory
 object
Date: Fri, 17 Sep 2004 10:43:33 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040917104333.7036cc5b.tokunaga.keiich@jp.fujitsu.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007B6FA60@fmsmsx406.amr.corp.intel.com>
 <20040917014611.000055db.tokunaga.keiich@jp.fujitsu.com>
 <1095357311.5380.253.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1095357311.5380.253.camel@localhost>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Sep 2004 10:55:11 -0700 Dave Hansen wrote:
> On Thu, 2004-09-16 at 09:46, Keiichiro Tokunaga wrote:
> > Sorry, I sent the email in the middle of writing...
> > 
> > On Thu, 16 Sep 2004 07:07:07 -0700, Tolentino, Matthew E wrote:
> > > >I have changed the patch to create directories and files in
> > > >/sys/firmware/acpi/memory/ from Dave's comments.  The files are
> > > >to export the following stuffs of each ACPI memory object for the
> > > >first version.
> > > 
> > > Hmm.  I thought Dave's suggestion was to create an arch-agnostic
> > > viewpoint of physical memory and dump it into 
> > > /sys/devices/system/memory in order to gain consistency between
> > > arches...  
> > 
> > Yes, that is also his suggestion.  I think we have agreed that there
> > are arch-specific and agnostic directories.  The agnostic one would
> > consist of some files that the specific one provides.  Actually, the
> > patch is to create just the arch-specific directory.  Then I would
> > turn into the agnostic stuffs.
> 
> Could you explain what each of those fields means?

Those fields are all defined in ACPI spec 3.0.  I steal the definitions
from the spec Table 6-39 below ;)


  resource_type:
      This indicates which type of resource this descriptor describes.

  producer_consumer:
      1 - This device consumes this resource
      0 - This device produces and consumers this resource

  decode: (This is for bridge devices)

  min_address_fixed:
      1 - The specified minimum address is fixed
      0 - The specified minimum address is not fixed

  max_address_fixed:
      1 - The specified maximum address is fixed
      0 - The specified maximum address is not fixed

  granularity:
      A set bit in this mask means that this bit is decoded.  All bits less
      significant than the most significant set bit must be set.  That is,
      the value of the full Address Space Granularity field (all 32 bits)
      must be a number (2^n - 1)

  min_address_range: (This definition is from the former page, Table 6-36)
      A minimum base memory address of a device

  max_address_range: (This definition is from the former page, Table 6-36)
      A maximum base memory address of a device

  address_translation_offset: (This is for bridge devices)

  address_length: (This definition is from the former page, Table 6-36)
      A length of the memory range


I just tried to export the fields for the first version.  As I said to
Matt, at least min_address_range and max_address_range are
in real need so far.  So, fields that should be exported might need
to be reconsidered.

Thanks,
Keiichiro Tokunaga


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
