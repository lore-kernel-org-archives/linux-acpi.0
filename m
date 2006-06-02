From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 10/13] Remove acpi_os_create_lock(), acpi_os_delete_lock()
Date: Fri, 2 Jun 2006 12:09:14 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A4634DE2@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12353 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751451AbWFBTJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jun 2006 15:09:16 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, adobriyan@gmail.com

This will not always be the case, in fact we are about to expand the use
of the spinlock interfaces.



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of akpm@osdl.org
> Sent: Thursday, June 01, 2006 8:19 PM
> To: Brown, Len
> Cc: linux-acpi@vger.kernel.org; akpm@osdl.org; adobriyan@gmail.com
> Subject: [patch 10/13] Remove acpi_os_create_lock(),
acpi_os_delete_lock()
> 
> 
> From: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Minimally intrusive patch to remove some overdesign in ACPI code.
Based
> on hch rant.
> 
> The only purpose of functions in question is to dynamically allocate
one
> global spinlock -- acpi_gbl_gpe_lock.  Instead, create it in .bss.
> 
> It's tempting to shoot acpi_os_release_lock() et al too.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/acpi/osl.c               |   30 -----------------------------
>  drivers/acpi/utilities/utmutex.c |    6 +++--
>  include/acpi/acpiosxf.h          |    4 ---
>  3 files changed, 4 insertions(+), 36 deletions(-)
> 
> diff -puN drivers/acpi/osl.c~remove-acpi_os_create_lock-
> acpi_os_delete_lock drivers/acpi/osl.c
> --- devel/drivers/acpi/osl.c~remove-acpi_os_create_lock-
> acpi_os_delete_lock	2006-06-01 20:17:08.000000000 -0700
> +++ devel-akpm/drivers/acpi/osl.c	2006-06-01 20:17:08.000000000
-0700
> @@ -668,36 +668,6 @@ void acpi_os_wait_events_complete(void *
> 
>  EXPORT_SYMBOL(acpi_os_wait_events_complete);
> 
> -/*
> - * Allocate the memory for a spinlock and initialize it.
> - */
> -acpi_status acpi_os_create_lock(acpi_handle * out_handle)
> -{
> -	spinlock_t *lock_ptr;
> -
> -	lock_ptr = kmalloc(sizeof(spinlock_t), GFP_KERNEL);
> -
> -	spin_lock_init(lock_ptr);
> -
> -	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Creating spinlock[%p].\n",
> lock_ptr));
> -
> -	*out_handle = lock_ptr;
> -
> -	return AE_OK;
> -}
> -
> -/*
> - * Deallocate the memory for a spinlock.
> - */
> -void acpi_os_delete_lock(acpi_handle handle)
> -{
> -	ACPI_DEBUG_PRINT((ACPI_DB_MUTEX, "Deleting spinlock[%p].\n",
> handle));
> -
> -	kfree(handle);
> -
> -	return;
> -}
> -
>  acpi_status
>  acpi_os_create_semaphore(u32 max_units, u32 initial_units,
acpi_handle *
> handle)
>  {
> diff -puN drivers/acpi/utilities/utmutex.c~remove-acpi_os_create_lock-
> acpi_os_delete_lock drivers/acpi/utilities/utmutex.c
> --- devel/drivers/acpi/utilities/utmutex.c~remove-acpi_os_create_lock-
> acpi_os_delete_lock	2006-06-01 20:17:08.000000000 -0700
> +++ devel-akpm/drivers/acpi/utilities/utmutex.c	2006-06-01
> 20:17:08.000000000 -0700
> @@ -51,6 +51,8 @@ static acpi_status acpi_ut_create_mutex(
> 
>  static acpi_status acpi_ut_delete_mutex(acpi_mutex_handle mutex_id);
> 
> +static spinlock_t __acpi_gbl_gpe_lock;
> +
> 
>
/***********************************************************************
**
> ******
>   *
>   * FUNCTION:    acpi_ut_mutex_initialize
> @@ -80,7 +82,8 @@ acpi_status acpi_ut_mutex_initialize(voi
>  		}
>  	}
> 
> -	status = acpi_os_create_lock(&acpi_gbl_gpe_lock);
> +	spin_lock_init(&__acpi_gbl_gpe_lock);
> +	acpi_gbl_gpe_lock = &__acpi_gbl_gpe_lock;
>  	return_ACPI_STATUS(status);
>  }
> 
> @@ -109,7 +112,6 @@ void acpi_ut_mutex_terminate(void)
>  		(void)acpi_ut_delete_mutex(i);
>  	}
> 
> -	acpi_os_delete_lock(acpi_gbl_gpe_lock);
>  	return_VOID;
>  }
> 
> diff -puN include/acpi/acpiosxf.h~remove-acpi_os_create_lock-
> acpi_os_delete_lock include/acpi/acpiosxf.h
> --- devel/include/acpi/acpiosxf.h~remove-acpi_os_create_lock-
> acpi_os_delete_lock	2006-06-01 20:17:08.000000000 -0700
> +++ devel-akpm/include/acpi/acpiosxf.h	2006-06-01
20:17:08.000000000 -
> 0700
> @@ -108,10 +108,6 @@ acpi_status acpi_os_wait_semaphore(acpi_
> 
>  acpi_status acpi_os_signal_semaphore(acpi_handle handle, u32 units);
> 
> -acpi_status acpi_os_create_lock(acpi_handle * out_handle);
> -
> -void acpi_os_delete_lock(acpi_handle handle);
> -
>  acpi_cpu_flags acpi_os_acquire_lock(acpi_handle handle);
> 
>  void acpi_os_release_lock(acpi_handle handle, acpi_cpu_flags flags);
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
