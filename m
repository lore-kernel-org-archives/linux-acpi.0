From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH] ACPI based Memory Hotplug Driver Patch
Date: Thu, 9 Sep 2004 09:52:15 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200409090952.15392.bjorn.helgaas@hp.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <FEB6C4E97F6CAF41978FB2059D5454180F37E8-OkeUvhg1trkFyVwBAnZdSLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Nice work!

On Thursday 09 September 2004 4:54 am, S, Naveen B wrote:
> +acpi_memory_get_device_resources(struct acpi_memory_device *mem_device) 
> +{
> +	acpi_status status;
> +	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};	
> +	struct acpi_resource *resource = NULL;
> +	struct acpi_resource_address16 *address16 = NULL;
> +	struct acpi_resource_address32 *address32 = NULL;
> +	struct acpi_resource_address64 *address64 = NULL;

You can use acpi_resource_to_address64() to keep from having to write
the same code for address16, address32, and address64.

> +	status = acpi_get_current_resources(mem_device->handle, &buffer);
> +	if (ACPI_FAILURE(status))
> +		return_VALUE(-EINVAL);
> +
> +	resource = (struct acpi_resource *) buffer.pointer;
> +		
> +	switch (resource->id) {
> +	case ACPI_RSTYPE_ADDRESS16:

I'm not sure you should assume the range will be the only item in _CRS
(i.e., you may need to iterate over all items using acpi_walk_resources()).

> +static int 
> +acpi_memory_check_device(struct acpi_memory_device *mem_device)

Could you just use acpi_bus_get_status() instead of defining this?

> +static int 
> +acpi_memory_powerdown_device(struct acpi_memory_device *mem_device)
> +{
> + ...
> +	/* Evalute _STA to check if the device is disabled */
> +	status = acpi_evaluate_integer(mem_device->handle, "_STA", 
> +		NULL, &current_status);

acpi_bus_get_status() again?

> +static acpi_status is_memory_device(acpi_handle handle)

(Different indent style).  Seems like this should check _CID as well
as _HID?  Could it leverage acpi_match_ids() somehow?


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
