From: Len Brown <len.brown@intel.com>
Subject: Re: [2.6 patch] #ifdef ACPI_FUTURE_USAGE
	acpi_ut_create_pkg_state_and_push
Date: 27 Jan 2005 18:18:34 -0500
Message-ID: <1106867914.2395.2321.camel@d845pe>
References: <20050127110443.GF28047@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261295AbVA0XWC@vger.kernel.org>
In-Reply-To: <20050127110443.GF28047@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Thu, 2005-01-27 at 06:04, Adrian Bunk wrote:
> The prototype of the unused global function
> acpi_ut_create_pkg_state_and_push was already #ifdef
> ACPI_FUTURE_USAGE'd, but the actual function wasn't.
> 
> Most likely this was a bug in my patch that added
> ACPI_FUTURE_USAGE.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c.old      
> 2005-01-26 22:31:11.000000000 +0100
> +++ linux-2.6.11-rc2-mm1-full/drivers/acpi/utilities/utmisc.c  
> 2005-01-26 22:40:40.000000000 +0100
> @@ -872,7 +885,7 @@
>   * DESCRIPTION: Create a new state and push it
>   *
>  
> ******************************************************************************/
> -
> +#ifdef ACPI_FUTURE_USAGE
>  acpi_status
>  acpi_ut_create_pkg_state_and_push (
>         void                            *internal_object,
> @@ -894,7 +907,7 @@
>         acpi_ut_push_generic_state (state_list, state);
>         return (AE_OK);
>  }
> -
> +#endif  /*  ACPI_FUTURE_USAGE  */
> 
>  /*******************************************************************************
>   *
> 
> 
> 
