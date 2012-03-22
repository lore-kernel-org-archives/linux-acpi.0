From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/5] ACPI: ec: Do request_region outside WARN()
Date: Thu, 22 Mar 2012 02:08:20 -0400
Message-ID: <4F6AC1D4.1090602@kernel.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org> <1328545032-21373-2-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328545032-21373-2-git-send-email-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Applied.

thanks,
Len Brown, Intel Open Source Technology Center

On 02/06/2012 11:17 AM, Andi Kleen wrote:

> WARN() is not supposed to have side effects, so move the request_regions
> outside.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  drivers/acpi/ec.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index b19a18d..3268dcf 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -812,10 +812,10 @@ static int acpi_ec_add(struct acpi_device *device)
>  		first_ec = ec;
>  	device->driver_data = ec;
>  
> -	WARN(!request_region(ec->data_addr, 1, "EC data"),
> -	     "Could not request EC data io port 0x%lx", ec->data_addr);
> -	WARN(!request_region(ec->command_addr, 1, "EC cmd"),
> -	     "Could not request EC cmd io port 0x%lx", ec->command_addr);
> +	ret = !!request_region(ec->data_addr, 1, "EC data");
> +	WARN(!ret, "Could not request EC data io port 0x%lx", ec->data_addr);
> +	ret = !!request_region(ec->command_addr, 1, "EC cmd");
> +	WARN(!ret, "Could not request EC cmd io port 0x%lx", ec->command_addr);
>  
>  	pr_info(PREFIX "GPE = 0x%lx, I/O: command/status = 0x%lx, data = 0x%lx\n",
>  			  ec->gpe, ec->command_addr, ec->data_addr);
