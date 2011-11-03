From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH -v1] acpi: Fix possible recursive locking in hwregs.c
Date: Thu, 03 Nov 2011 20:02:50 +0800
Message-ID: <1320321770.2813.10.camel@hp6530s>
References: <1320317323.5711.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320317323.5711.5.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rakib Mullick <rakib.mullick@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2011-11-03 at 18:48 +0800, Rakib Mullick wrote:
> Calling pm-suspend might trigger a recursive lock in it's code path. In function acpi_hw_clear_acpi_status, 

As I replied at https://lkml.org/lkml/2011/9/22/6, I still don't think
there is a recursive lock.

Or do you have a real test case to trigger the recursive lock you
mentioned?

Lin Ming

> acpi_os_acquire_lock holds the lock acpi_gbl_hardware_lock before calling acpi_hw_register_write(), then 
> without releasing acpi_gbl_hardware_lock, this function calls acpi_ev_walk_gpe_list, which tries to hold 
> acpi_gbl_gpe_lock and thus might causes possible recursive lock.
> 
> Following patch fixes this scenario by just releasing acpi_gbl_hardware_lock before calling acpi_ev_walk_gpe_list.
> 
>  Changes since v0(https://lkml.org/lkml/2011/9/21/355):
> 	- Fix changelog, thanks to Lin Ming.
> 
> Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
> Cc: Lin Ming <ming.m.lin@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Len Brown <len.brown@intel.com>
> ---
> 
> diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> index 55accb7..e3110ac 100644
> --- a/drivers/acpi/acpica/hwregs.c
> +++ b/drivers/acpi/acpica/hwregs.c
> @@ -269,6 +269,9 @@ acpi_status acpi_hw_clear_acpi_status(void)
>  
>  	status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
>  					ACPI_BITMASK_ALL_FIXED_STATUS);
> +
> +	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
> +
>  	if (ACPI_FAILURE(status)) {
>  		goto unlock_and_exit;
>  	}
> @@ -278,7 +281,6 @@ acpi_status acpi_hw_clear_acpi_status(void)
>  	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
>  
>        unlock_and_exit:
> -	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
>  	return_ACPI_STATUS(status);
>  }
>  
> 
> 
