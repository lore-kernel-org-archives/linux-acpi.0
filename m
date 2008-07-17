From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other GPEs)
 on Asus EeePC
Date: Thu, 17 Jul 2008 18:35:34 +0400
Message-ID: <487F58B6.5040309@suse.de>
References: <487D23C3.5070301@student.cs.york.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57911 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756263AbYGQOfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 10:35:37 -0400
In-Reply-To: <487D23C3.5070301@student.cs.york.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: alan-jenkins@tuffmail.co.uk
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Hi Alan,

Could you please test if your patch works with the last patch in #10919?

Thanks,
Alex.


Alan Jenkins wrote:
> It looks like this EC clears the SMI_EVT bit after every query, even if there
> are more events pending.  The workaround is to repeatedly query the EC until
> it reports that no events remain.
> 
> This fixes a regression in 2.6.26 (from 2.6.25.3).  Initially reported as
> "Asus Eee PC hotkeys stop working if pressed quickly" in bugzilla
> <http://bugzilla.kernel.org/show_bug.cgi?id=11089>.
> 
> The regression was caused by a recently added check for interrupt storms.
> The Eee PC triggers this check and switches to polling.  When multiple events
> arrive between polling intervals, only one is fetched from the EC.  This causes
> erroneous behaviour; ultimately events stop being delivered altogether when the
> EC buffer overflows.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> 
> ---
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 5622aee..2b4c5a2 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -459,14 +459,10 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
>  
>  EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
>  
> -static void acpi_ec_gpe_query(void *ec_cxt)
> +static void acpi_ec_gpe_run_handler(struct acpi_ec *ec, u8 value)
>  {
> -	struct acpi_ec *ec = ec_cxt;
> -	u8 value = 0;
>  	struct acpi_ec_query_handler *handler, copy;
>  
> -	if (!ec || acpi_ec_query(ec, &value))
> -		return;
>  	mutex_lock(&ec->lock);
>  	list_for_each_entry(handler, &ec->list, node) {
>  		if (value == handler->query_bit) {
> @@ -484,6 +480,18 @@ static void acpi_ec_gpe_query(void *ec_cxt)
>  	mutex_unlock(&ec->lock);
>  }
>  
> +static void acpi_ec_gpe_query(void *ec_cxt)
> +{
> +	struct acpi_ec *ec = ec_cxt;
> +	u8 value = 0;
> +
> +	if (!ec)
> +		return;
> +
> +	while (!acpi_ec_query(ec, &value))
> +		acpi_ec_gpe_run_handler(ec, value);
> +}
> +
>  static u32 acpi_ec_gpe_handler(void *data)
>  {
>  	acpi_status status = AE_OK;
> 
> 

