From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / scan: Clean up acpi_bus_get_parent()
Date: Thu, 31 Jan 2013 10:43:46 -0800
Message-ID: <CAE9FiQWiOAdDC15g+y1JRc7_tG=EzVckdNPYYJpWsftJAkEZsg@mail.gmail.com>
References: <1451967.YMyGeCCNtu@vostro.rjw.lan>
	<7667918.svVNymu9rt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7667918.svVNymu9rt@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 30, 2013 at 2:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make acpi_bus_get_parent() more straightforward and remove an
> unnecessary local variable ret from it.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/scan.c |   16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> Index: test/drivers/acpi/scan.c
> ===================================================================
> --- test.orig/drivers/acpi/scan.c
> +++ test/drivers/acpi/scan.c
> @@ -871,29 +871,23 @@ EXPORT_SYMBOL(acpi_bus_unregister_driver
>     -------------------------------------------------------------------------- */
>  static struct acpi_device *acpi_bus_get_parent(acpi_handle handle)
>  {
> +       struct acpi_device *device = NULL;
>         acpi_status status;
> -       int ret;
> -       struct acpi_device *device;
>
>         /*
>          * Fixed hardware devices do not appear in the namespace and do not
>          * have handles, but we fabricate acpi_devices for them, so we have
>          * to deal with them specially.
>          */
> -       if (handle == NULL)
> +       if (!handle)
>                 return acpi_root;
>
>         do {
>                 status = acpi_get_parent(handle, &handle);
> -               if (status == AE_NULL_ENTRY)
> -                       return NULL;
>                 if (ACPI_FAILURE(status))
> -                       return acpi_root;
> -
> -               ret = acpi_bus_get_device(handle, &device);
> -               if (ret == 0)
> -                       return device;
> -       } while (1);
> +                       return status == AE_NULL_ENTRY ? NULL : acpi_root;
> +       } while (acpi_bus_get_device(handle, &device));
> +       return device;
>  }

Acked-by: Yinghai Lu <yinghai@kernel.org>

>
>  acpi_status
>
