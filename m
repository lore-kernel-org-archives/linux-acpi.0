From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] /sys/firmware/acpi/memory/ for showing info of ACPI
 memory object
Date: Fri, 17 Sep 2004 01:46:11 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040917014611.000055db.tokunaga.keiich@jp.fujitsu.com>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007B6FA60@fmsmsx406.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB007B6FA60-oCDej+MBycNZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry, I sent the email in the middle of writing...

On Thu, 16 Sep 2004 07:07:07 -0700, Tolentino, Matthew E wrote:
> >I have changed the patch to create directories and files in
> >/sys/firmware/acpi/memory/ from Dave's comments.  The files are
> >to export the following stuffs of each ACPI memory object for the
> >first version.
> 
> Hmm.  I thought Dave's suggestion was to create an arch-agnostic
> viewpoint of physical memory and dump it into 
> /sys/devices/system/memory in order to gain consistency between
> arches...  

Yes, that is also his suggestion.  I think we have agreed that there
are arch-specific and agnostic directories.  The agnostic one would
consist of some files that the specific one provides.  Actually, the
patch is to create just the arch-specific directory.  Then I would
turn into the agnostic stuffs.

> ># ls /sys/firmware/acpi/memory/MEM1/
> >address_length
> >address_translation_offset
> >granularity
> >max_address_fixed
> >max_address_range
> >min_address_fixed
> >min_address_range
> >producer_consumer
> >resource_type
> 
> For my understanding, what exactly are all of these attributes for?

The directory name 'MEM1', min_address_range and max_address_range
are used to know the physical address range of the ACPI memory object.
Then, we can determine what memsection belongs to the ACPI memory
object by using the address range.

ACPI container hotplug is assuming to use the method to know
corresponding memsections (To be exact, a user mode script
'container.agent' uses it).  When ACPI container hotplug is invoked,
it knows ACPI object names of devices contained in a container.  So
when the container hotplug invokes the 'container.agent', it just can
tell ACPI object names.  The 'container.agent' is responsible for
onlining/offlining, so it needs to translate the ACPI object names
to memsections.  But, I am not sure about the other files...

Thanks,
Keiichiro Tokunaga


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
