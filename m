From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI memory hotplug driver
Date: 17 Feb 2005 02:45:00 -0500
Message-ID: <1108626299.2096.491.camel@d845pe>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB008D17348@fmsmsx406.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB008D17348-oCDej+MBycNZtRGVdHMbwrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

applied to acpi-test.

thanks,
-Len

On Mon, 2005-01-17 at 17:07, Tolentino, Matthew E wrote:
> This is a reposting of the ACPI memory hotplug driver posted by 
> Naveen a couple of months back.  This has been maintained in the 
> memory hotplug tree since then and unless there's additional 
> feedback resultant to this post, we're resubmitting it for 
> upstream inclusion.  Patch is against 2.6.11-rc1.
> 
> I also elaborated a bit in the Kconfig help section based on 
> Grant's post on the container driver over the weekend...  ;-)
> 
> matt
> 
> Below description also included at the top of the attached patch:
> 
> The ACPI based memory hot plug driver patch supports physical hotplug
> operations on memory. This driver fields notifications for memory add
> and remove operations from firmware and notifies the VM of the affected
> memory ranges. Accordingly, this driver also maintains and updates the
> states of all the memory ranges. This driver is useful on hardware which
> helps firmware generating ACPI events for every physical hotplug
> operation of memory boards on the system during runtime.
> 
> Signed-off-by: Matt Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Naveen B S <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
