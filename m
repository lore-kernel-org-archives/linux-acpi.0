From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] acpi:ipmi: Make IPMI user handler const
Date: Thu, 09 Feb 2017 15:02:26 +0100
Message-ID: <6437353.muxityAQuf@aspire.rjw.lan>
References: <1484055613-31286-1-git-send-email-minyard@acm.org> <1484055613-31286-3-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484055613-31286-3-git-send-email-minyard@acm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: minyard@acm.org
Cc: linux-kernel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Corey Minyard <cminyard@mvista.com>, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Lv Zheng <lv.zheng@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, January 10, 2017 07:40:13 AM minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> ipmi_create_user() now takes the user handlers as const, make
> it const in the ACPI IPMI code.
> 
> Cc: linux-acpi@vger.kernel.org
> Cc: Zhao Yakui <yakui.zhao@intel.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Please let me know if you want me to apply this.

Otherwise, feel free to add my ACK to it and route it whatever way you think
is appropriate.

> ---
>  drivers/acpi/acpi_ipmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
> index f77956c..747c2ba 100644
> --- a/drivers/acpi/acpi_ipmi.c
> +++ b/drivers/acpi/acpi_ipmi.c
> @@ -56,7 +56,7 @@ struct acpi_ipmi_device {
>  struct ipmi_driver_data {
>  	struct list_head ipmi_devices;
>  	struct ipmi_smi_watcher bmc_events;
> -	struct ipmi_user_hndl ipmi_hndlrs;
> +	const struct ipmi_user_hndl ipmi_hndlrs;
>  	struct mutex ipmi_lock;
>  
>  	/*
> 

Thanks,
Rafael
