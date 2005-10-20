From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model - takes 2
Date: Thu, 20 Oct 2005 11:04:44 -0600
Message-ID: <200510201104.44164.bjorn.helgaas@hp.com>
References: <1129185454.9074.15.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1129185454.9074.15.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dominik Brodowski <linux-JhLEnvuH02M@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday 13 October 2005 12:37 am, Shaohua Li wrote:
> This is the updated patch for the topic. In this version, I completely
> convert devices in ACPI bus into Linux driver model. Now the device
> driver for ACPI bus device should be a 'struct acpi_phys_driver'. Old
> style driver (struct acpi_driver) now can't work for ACPI bus devices.

    - I don't like names that include "acpi_bus" because there
      really is no "bus".  If PCI, which really DOES have a bus,
      doesn't need it, ACPI surely doesn't.

    - Suspend/resume/probe/remove/shutdown are device-oriented
      interfaces and should be named with "device", not "bus".

    - We should not end up with two interfaces to register ACPI
      drivers.  ACPI is confusing enough as it is.  Having both
      acpi_phys_driver_register() and acpi_bus_register_driver()
      will be a disaster.  (Keeping both temporarily for during
      a transition is OK, but one should be explicitly deprecated.)

> +			length += scnprintf(scratch, buffer_size - length,
> +				"COMPTID=%s", cid_list->id[j].value);

This requires a sequence number (COMPTID%d) to support multiple
_CIDs, doesn't it?

> +static struct bus_type acpi_phys_bus_type = {
> +	.name = "acpi",
> +	.match = acpi_phys_bus_match,
> +	.hotplug = acpi_phys_bus_hotplug,

I think this should be just "acpi_hotplug".

> +	.suspend = acpi_phys_bus_suspend,
> +	.resume = acpi_phys_bus_resume,

And these should be "acpi_device_suspend" and "acpi_device_resume".

> +int acpi_phys_driver_register(struct acpi_phys_driver *drv)

The majority of driver registration interfaces use
"register_driver", not "driver_register".  So I think
this should be "acpi_register_driver", and you should
deprecate "acpi_bus_register_driver".  I still don't
see any fundamental reason for having two ways to
register ACPI drivers.

> +{
> +	int error;
> +	/*FIXME: add to a list */
> +	drv->phys_drv.name = drv->name;
> +	drv->phys_drv.bus = &acpi_phys_bus_type;
> +	drv->phys_drv.probe = acpi_phys_device_probe;
> +	drv->phys_drv.remove = acpi_phys_device_remove;
> +	drv->phys_drv.shutdown = acpi_phys_device_shutdown;

I think these should be "acpi_bus_type", "acpi_device_probe",
"acpi_device_remove", and "acpi_device_shutdown".


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
