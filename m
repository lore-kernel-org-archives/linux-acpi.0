From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 10/15] acpi: Export acpi_bus_type
Date: Wed, 31 Aug 2016 00:47:39 +0200
Message-ID: <CAJZ5v0h92aJ_tc+-07-kaU-HYO+Q4U28Ly2kXYJi8vr9A-VXOQ@mail.gmail.com>
References: <20160830164910.1248-1-jeff.mcgee@intel.com> <20160830164910.1248-11-jeff.mcgee@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160830164910.1248-11-jeff.mcgee@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeff.mcgee@intel.com
Cc: isg-gms@eclists.intel.com, Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 30, 2016 at 6:49 PM,  <jeff.mcgee@intel.com> wrote:
> From: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
>
> Some modules, like i915.ko, needs to detect when certain ACPI features are
> active inorder to prevent corruption on contended resources.
> In particular, use of BIOS RapidStart Technology may corrupt the contents of
> the reserved graphics memory, due to unalarmed hibernation. In which case
> i915.ko cannot assume that it (reserved gfx memory) remains unmodified and
> must recreate the contents and importantly not use it to store unrecoverable
> user data.

The above doesn't explain why you need to export acpi_bus_type at all.

I suspect that this is in order to be able to do some hackish stuff on
it, so I'm not going to approve this patch as is.

> Signed-off-by: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Jeff McGee <jeff.mcgee@intel.com>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 4b22ea8..7461bab 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1269,6 +1269,7 @@ struct bus_type acpi_bus_type = {
>         .remove         = acpi_device_remove,
>         .uevent         = acpi_device_uevent,
>  };
> +EXPORT_SYMBOL_GPL(acpi_bus_type);
>
>  static void acpi_device_del(struct acpi_device *device)
>  {
> --

Thanks,
Rafael
