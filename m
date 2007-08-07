From: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ACPI: thinkpad-acpi: change thinkpad-acpi
	input default and kconfig help
Date: Tue, 7 Aug 2007 15:10:50 -0400
Message-ID: <200708071510.50741.lenb@kernel.org>
References: <1186338045352-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1186338045352-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Michael S. Tsirkin" <mst-LDSdmyG8hGV8YrgS2mwiifqBs+8SCbDb@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
-Len

On Sunday 05 August 2007 14:20, Henrique de Moraes Holschuh wrote:
> The current kconfig help text was misleading users.  Also, the default for
> an input-layer-optimized support caused way too many problems without
> up-to-date userspace in place.
> 
> So, rework the help text, and change the default to N.  Note that
> distributions are supposed to enable this option as soon as they update HAL
> to a version that handles the thinkpad-acpi new input layer interface.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
> Cc: Michael S. Tsirkin <mst-LDSdmyG8hGV8YrgS2mwiifqBs+8SCbDb@public.gmane.org>
> Cc: Hugh Dickins <hugh-DTz5qymZ9yRBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/misc/Kconfig |   22 +++++++++++++++-------
>  1 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index aaaa61e..518d5d3 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -200,14 +200,22 @@ config THINKPAD_ACPI_BAY
>  config THINKPAD_ACPI_INPUT_ENABLED
>  	bool "Enable input layer support by default"
>  	depends on THINKPAD_ACPI
> -	default y
> +	default n
>  	---help---
> -	  Enables hot key handling over the input layer by default.  If unset,
> -	  the driver does not enable any hot key handling by default, and also
> -	  starts up with a mostly empty keymap.
> -
> -	  If you are not sure, say Y here.  Say N to retain the deprecated
> -	  behavior of ibm-acpi, and thinkpad-acpi for kernels up to 2.6.21.
> +	  This option enables thinkpad-acpi hot key handling over the input
> +	  layer at driver load time.  When it is unset, the driver does not
> +	  enable hot key handling by default, and also starts up with a mostly
> +	  empty keymap.
> +
> +	  This option should be enabled if you have a new enough HAL or other
> +	  userspace support that properly handles the thinkpad-acpi event
> +	  device.  It auto-tunes the hot key support to those reported by the
> +	  firmware and enables it automatically.
> +
> +	  If unsure, say N here to retain the old behaviour of ibm-acpi, and
> +	  thinkpad-acpi up to kernel 2.6.21: userspace will have to enable and
> +	  set up the thinkpad-acpi hot key handling using the sysfs interace
> +	  after loading the driver.
>  
>  
>  endif # MISC_DEVICES

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
