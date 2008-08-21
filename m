From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [patch 2/2] acpi: Avoid dropping rapid hotkey events (or other
 GPEs) on Asus EeePC
Date: Thu, 21 Aug 2008 16:12:43 +0400
Message-ID: <48AD5BBB.2050701@suse.de>
References: <200808202341.m7KNflv7005413@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:47239 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753936AbYHUMMy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Aug 2008 08:12:54 -0400
In-Reply-To: <200808202341.m7KNflv7005413@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: andi@firstfloor.org, linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, hmh@hmh.eng.br, maxi@daemonizer.de, stable@kernel.org

Hi Andrew,

As I understand, this patch is wrong according to comment #65 in bug #9998.

Regards,
Alex.

akpm@linux-foundation.org wrote:
> From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> 
> It looks like this EC clears the SMI_EVT bit after every query, even if
> there are more events pending.  The workaround is to repeatedly query the
> EC until it reports that no events remain.
> 
> This fixes a regression in 2.6.26 (from 2.6.25.3).  Initially reported as
> "Asus Eee PC hotkeys stop working if pressed quickly" in bugzilla
> <http://bugzilla.kernel.org/show_bug.cgi?id=11089>.
> 
> The regression was caused by a recently added check for interrupt storms. 
> The Eee PC triggers this check and switches to polling.  When multiple
> events arrive between polling intervals, only one is fetched from the EC. 
> This causes erroneous behaviour; ultimately events stop being delivered
> altogether when the EC buffer overflows.
> 
> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
> Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
> Cc: Maximilian Engelhardt <maxi@daemonizer.de>
> Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: <stable@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/ec.c |   18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff -puN drivers/acpi/ec.c~acpi-avoid-dropping-rapid-hotkey-events-or-other-gpes-on-asus-eeepc drivers/acpi/ec.c
> --- a/drivers/acpi/ec.c~acpi-avoid-dropping-rapid-hotkey-events-or-other-gpes-on-asus-eeepc
> +++ a/drivers/acpi/ec.c
> @@ -486,14 +486,10 @@ void acpi_ec_remove_query_handler(struct
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
> @@ -511,6 +507,18 @@ static void acpi_ec_gpe_query(void *ec_c
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
> _

