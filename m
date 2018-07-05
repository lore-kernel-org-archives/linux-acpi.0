From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] Default to s2idle in all machines supporting LP S0.
Date: Thu, 05 Jul 2018 13:34:11 +0200
Message-ID: <3030490.HWdhQ4YSSa@aspire.rjw.lan>
References: <1529052618-370-1-git-send-email-tristiancelestin@fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529052618-370-1-git-send-email-tristiancelestin@fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tristian Celestin <tristiancelestin@fastmail.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, June 15, 2018 10:50:18 AM CEST Tristian Celestin wrote:
> The Dell Venue Pro 7140 supports the Low Power S0 Idle state, but does not
> support any of the _DSM functions that the current heuristic checks
> for. Since suspend-to-mem can not be safely performed on this machine,
> and since the bitfield check can't cover this case, it is safer
> to enable s2idle by default by checking for the presence of the _DSM
> alone and removing the bitfield check.
> 
> Signed-off-by: Tristian Celestin <tristiancelestin@fastmail.com>
> ---
>  drivers/acpi/sleep.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 974e584..d0ddd4d 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -718,9 +718,6 @@ static int acpi_suspend_begin_old(suspend_state_t pm_state)
>  #define ACPI_LPS0_ENTRY		5
>  #define ACPI_LPS0_EXIT		6
>  
> -#define ACPI_LPS0_SCREEN_MASK	((1 << ACPI_LPS0_SCREEN_OFF) | (1 << ACPI_LPS0_SCREEN_ON))
> -#define ACPI_LPS0_PLATFORM_MASK	((1 << ACPI_LPS0_ENTRY) | (1 << ACPI_LPS0_EXIT))
> -
>  static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
>  static char lps0_dsm_func_mask;
> @@ -924,17 +921,14 @@ static int lps0_device_attach(struct acpi_device *adev,
>  	if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
>  		char bitmask = *(char *)out_obj->buffer.pointer;
>  
> -		if ((bitmask & ACPI_LPS0_PLATFORM_MASK) == ACPI_LPS0_PLATFORM_MASK ||
> -		    (bitmask & ACPI_LPS0_SCREEN_MASK) == ACPI_LPS0_SCREEN_MASK) {
> -			lps0_dsm_func_mask = bitmask;
> -			lps0_device_handle = adev->handle;
> -			/*
> -			 * Use suspend-to-idle by default if the default
> -			 * suspend mode was not set from the command line.
> -			 */
> -			if (mem_sleep_default > PM_SUSPEND_MEM)
> -				mem_sleep_current = PM_SUSPEND_TO_IDLE;
> -		}
> +		lps0_dsm_func_mask = bitmask;
> +		lps0_device_handle = adev->handle;
> +		/*
> +		 * Use suspend-to-idle by default if the default
> +		 * suspend mode was not set from the command line.
> +		 */
> +		if (mem_sleep_default > PM_SUSPEND_MEM)
> +			mem_sleep_current = PM_SUSPEND_TO_IDLE;
>  
>  		acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
>  				  bitmask);
> 

Applied, thanks!
