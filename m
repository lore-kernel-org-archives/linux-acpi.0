From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [RFC]convert ACPI driver model to Linux driver model - takes 2
Date: Thu, 13 Oct 2005 14:43:47 -0600
Message-ID: <200510131443.47844.bjorn.helgaas@hp.com>
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
> convert devices in ACPI bus into Linux driver model.

This looks like a nice piece of work.

> Now the device 
> driver for ACPI bus device should be a 'struct acpi_phys_driver'. Old
> style driver (struct acpi_driver) now can't work for ACPI bus devices.

You now have both 'acpi_driver' and 'acpi_phys_driver' (and
'acpi_device' and 'acpi_phys_device').  What exactly is the
distinction?  Is the distinction necessary?  Can you just stuff
the generic device stuff into 'struct acpi_device' itself?

> I tried to convert one ACPI driver (link device driver) to the new
> model. It's quite easy.

I'd like to see the link device driver patch, just to help
me understand all this.

> +struct acpi_phys_driver {
> +//	struct list_head node;
> +	char name[80];
> +	char class[80];

Shouldn't these be "char *" instead of "char []"?

> +	struct module *owner;
> +	char *ids;
> +	int (*probe)(struct acpi_phys_device *dev);
> +	void (*remove) (struct acpi_phys_device *dev);
> +	int  (*suspend) (struct acpi_phys_device *dev, pm_message_t state);
> +	int  (*resume) (struct acpi_phys_device *dev);
> +	void (*shutdown) (struct acpi_phys_device *dev);
> +
> +	struct device_driver    phys_drv;

I think you should name this item "driver", not "phys_drv".


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
