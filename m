From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 10/11] acpi: Export acpi_bus_type
Date: Fri, 15 Jan 2016 15:51:58 +0100
Message-ID: <19135964.pq7BquODL6@vostro.rjw.lan>
References: <1452752207-30382-1-git-send-email-ankitprasad.r.sharma@intel.com> <1452752207-30382-11-git-send-email-ankitprasad.r.sharma@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452752207-30382-11-git-send-email-ankitprasad.r.sharma@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ankitprasad.r.sharma@intel.com
Cc: intel-gfx@lists.freedesktop.org, akash.goel@intel.com, shashidhar.hiremath@intel.com, tvrtko.ursulin@linux.intel.com, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, January 14, 2016 11:46:46 AM ankitprasad.r.sharma@intel.com wrote:
> From: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
> 
> Some modules, like i915.ko, needs to detect when certain ACPI features
> are active inorder to prevent corruption on contended resources.
> In particular, use of BIOS RapidStart Technology may corrupt the contents
> of the reserved graphics memory, due to unalarmed hibernation. In which
> case i915.ko cannot assume that it (reserved gfx memory) remains
> unmodified and must recreate teh contents and importantly not use it to
> store unrecoverable user data.
> 
> Signed-off-by: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/acpi/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a212cef..69509c7 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -814,6 +814,7 @@ struct bus_type acpi_bus_type = {
>  	.remove		= acpi_device_remove,
>  	.uevent		= acpi_device_uevent,
>  };
> +EXPORT_SYMBOL_GPL(acpi_bus_type);
>  
>  /* --------------------------------------------------------------------------
>                               Initialization/Cleanup
> 

No.

I see no reason whatsoever for doing this.

Thanks,
Rafael
