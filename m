From: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: ACPI hot-plug notification help needed
Date: Wed, 3 Aug 2005 12:36:27 -0700
Message-ID: <20050803123627.A4443@unix-os.sc.intel.com>
References: <200507251735.23394.bjorn.helgaas@hp.com> <200508011620.02609.bjorn.helgaas@hp.com> <20050801170345.A16268@unix-os.sc.intel.com> <200508021641.26007.bjorn.helgaas@hp.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200508021641.26007.bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>; from bjorn.helgaas-VXdhtT5mjnY@public.gmane.org on Tue, Aug 02, 2005 at 04:41:25PM -0600
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
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 02, 2005 at 04:41:25PM -0600, Bjorn Helgaas wrote:
> Here's a patch (not ready for merging) that makes
> acpi_bus_notify() pass the handle, rather than the device,
> down to acpi_bus_check_device(), which then adds the device
> if it didn't previously exist.
> 
> Is this heading down the right track?
Let me restate the goal of this patch here to make sure
we are know what we are doing.

We are trying to get away with all drivers having to explicitly
install a hotplug notify handler for all of their devices described
in the namespace. With this changes, the ACPI core would then
be responsible for handling this hotplug event, responsible for
creating acpi_device's and calling respective drivers add() method.

Yes, your patch is certainly on the right track but need lot
more carefull though and desing so as not to break existing
features and functionality.

See more comments below.

> 
> +static int
>  acpi_bus_check_device (
> -	struct acpi_device	*device,
> +	acpi_handle		handle,
>  	int			*status_changed)
>  {
>  	acpi_status             status = 0;
> +	struct acpi_device	*device = NULL;
>  	struct acpi_device_status old_status;
> +	int			result;
>  
>  	ACPI_FUNCTION_TRACE("acpi_bus_check_device");
>  
> +	/*
> +	 * If no device exists for this namespace node, a DEVICE_CHECK
> +	 * notification means the device has appeared.
> +	 */
> +	if (acpi_bus_get_device(handle, &device)) {
As Kenji stated in a separate e-mail, you need to check _STA
before calling acpi_bus_add_device().
> +		result = acpi_bus_add_device(handle);
> +		if (status_changed && result == 0)
> +			*status_changed = 1;
> +		return_VALUE(result);
> +	}
> +
Once the devices are added by calling acpi_bus_add_device(),
I think you also need to call acpi_bus_start() to actuall start
the devices.

In case of a root bridge hotplug, after the root bridge
has been successfully added by calling acpi_bus_add_device(),
the root bridge driver (acpiphp.ko see acpiphp_glue.c) needs
to configure the bridge before we call acpi_bus_start(), so
need some intraction with the ACPI core and the drivers
between acpi_bus_add() and acpi_bus_start() calls.

Cheers,
Anil


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
