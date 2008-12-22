From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH/RFC] ACPICA: disable ACPI 2.0 _GTS/_BFS support
Date: Mon, 22 Dec 2008 09:42:06 +0800
Message-ID: <1229910126.3990.37.camel@yakui_zhao.sh.intel.com>
References: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1318 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbYLVBcm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Dec 2008 20:32:42 -0500
In-Reply-To: <alpine.LFD.2.00.0812190421140.1988@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, 2008-12-19 at 17:23 +0800, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> Organization: Intel Open Source Technology Center
> 
> ACPI 2.0 defined two new methods in the suspend/resume sequence,
> _GTS (Going to Sleep) and _BFS (Back from Sleep)

Is the purpose of this patch that in course of suspend/resume the ACPI
object won't be evaluated again when irq is disabled? And this can avoid
the preemption point after evaluating the ACPI object.
   
   If so, this issue can be fixed by the patch
   http://bugzilla.kernel.org/attachment.cgi?id=19370&action=view


> 
> They are optional methods, but if the BIOS supplies them,
> the OS is supposed to evaluate them immediately before
> writing the register to sleep, and immediately after waking up --
> a time when interrupts are disabled.
> 
> The spec says that they must be self-contained
> methods, not calling any other methods, perhaps
> because that they are run under unique conditions?
> 
> These methodds are evaluated in Linux by
> acpi_evaluate_object(), which always kmalloc's
> a return structure to conserve stack space.
> But kmalloc with interrupts off is problematic --
> do we really want to insist on GFP_ATOMIC here?
> 
> Now, several years after ACPI 2.0 was released,
> we have yet to observe a single implementation of
> _GTS/_BFS in the field -- suggesting that they will
> never actually be deployed.
> 
> So lets keep Linux simple by removing this
> theoretical support for _GTS/_BFS, the only
> AML methods that mandated being evaluated
> with interrupts disabled.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/hardware/hwsleep.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/hardware/hwsleep.c b/drivers/acpi/hardware/hwsleep.c
> index 25dccdf..c209434 100644
> --- a/drivers/acpi/hardware/hwsleep.c
> +++ b/drivers/acpi/hardware/hwsleep.c
> @@ -289,6 +289,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
>  		return_ACPI_STATUS(status);
>  	}
>  
> +#ifdef	ACPI_20_GTS_BFS
>  	/* Execute the _GTS method */
>  
>  	arg_list.count = 1;
> @@ -300,6 +301,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>  		return_ACPI_STATUS(status);
>  	}
> +#endif
>  
>  	/* Get current value of PM1A control */
>  
> @@ -535,6 +537,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
>  		}
>  	}
>  
> +#ifdef	ACPI_20_GTS_BFS
>  	/* Execute the _BFS method */
>  
>  	arg_list.count = 1;
> @@ -546,6 +549,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
>  		ACPI_EXCEPTION((AE_INFO, status, "During Method _BFS"));
>  	}
> +#endif
>  
>  	return_ACPI_STATUS(status);
>  }

