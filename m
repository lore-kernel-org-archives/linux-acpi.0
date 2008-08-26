From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: How can a patch be merged upstream?
Date: Tue, 26 Aug 2008 09:06:42 +0800
Message-ID: <1219712802.4116.32.camel@yakui_zhao.sh.intel.com>
References: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24792 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753157AbYHZAvi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Aug 2008 20:51:38 -0400
In-Reply-To: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Joshua C." <joshuacov@googlemail.com>
Cc: linux-acpi@vger.kernel.org, andi@firstfloor.org, lenb@kernel.org

On Mon, 2008-08-25 at 16:26 +0200, Joshua C. wrote:
> I (and others with acer aspire 5050series laptops) have a broken bios
> which resulted in kernel panic. Reported the bug
> http://bugzilla.kernel.org/show_bug.cgi?id=10237 and
> http://bugzilla.kernel.org/show_bug.cgi?id=8953 and a patch was
> written about it. Can/When will this be merged upstream? Any arguments
> against this as a hardware/platform solution?
Linux can't work normally while Windows can work on such broken BIOS. Of
course the issue is related with the broken BIOS. The _REG object of EC
device is incorrect, which causes that EC device can't be initialized
correctly. 
After this workaround patch is applied, Linux can also work. IMO this
workaround patch is reasonable. 

Thanks.
   Yakui
> Here is the patch from Zhao Yakui <yakui.zhao@intel.com>
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> 
> ---
>  drivers/acpi/ec.c |   15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/ec.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/ec.c
> +++ linux-2.6/drivers/acpi/ec.c
> @@ -835,8 +835,19 @@ static int ec_install_handlers(struct ac
>  						    &acpi_ec_space_handler,
>  						    NULL, ec);
>  	if (ACPI_FAILURE(status)) {
> -		acpi_remove_gpe_handler(NULL, ec->gpe, &acpi_ec_gpe_handler);
> -		return -ENODEV;
> +		if (status == AE_NOT_FOUND) {
> +			/*
> +			 * Maybe OS fails in evaluating the _REG object.
> +			 * The AE_NOT_FOUND error will be ignored and OS
> +			 * continue to initialize EC.
> +			 */
> +			printk(KERN_ERR "Fail in evaluating _REG object."
> +				" It is broken BIOS.\n");
> +		} else {
> +			acpi_remove_gpe_handler(NULL, ec->gpe,
> +				&acpi_ec_gpe_handler);
> +			return -ENODEV;
> +		}
>  	}
> 
>  	ec->handlers_installed = 1;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

