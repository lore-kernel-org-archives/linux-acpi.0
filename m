From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Remove useless initializers
Date: Mon, 03 Jun 2013 21:43:40 +0200
Message-ID: <1820850.sPxyHXMgLn@vostro.rjw.lan>
References: <20130603182024.16039.34089.stgit@bhelgaas-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:57494 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757999Ab3FCTej (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Jun 2013 15:34:39 -0400
In-Reply-To: <20130603182024.16039.34089.stgit@bhelgaas-glaptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Monday, June 03, 2013 12:20:24 PM Bjorn Helgaas wrote:
> These local variables are all initialized at their first use, so there's
> no point in initializing them earlier.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Queued up for 3.11, thanks Bjorn!

Rafael


> ---
>  drivers/acpi/bus.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 292de3c..a5bb33b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -91,8 +91,7 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
>  
>  int acpi_bus_get_device(acpi_handle handle, struct acpi_device **device)
>  {
> -	acpi_status status = AE_OK;
> -
> +	acpi_status status;
>  
>  	if (!device)
>  		return -EINVAL;
> @@ -162,7 +161,7 @@ EXPORT_SYMBOL(acpi_bus_private_data_handler);
>  
>  int acpi_bus_get_private_data(acpi_handle handle, void **data)
>  {
> -	acpi_status status = AE_OK;
> +	acpi_status status;
>  
>  	if (!*data)
>  		return -EINVAL;
> @@ -361,7 +360,7 @@ extern int event_is_open;
>  int acpi_bus_generate_proc_event4(const char *device_class, const char *bus_id, u8 type, int data)
>  {
>  	struct acpi_bus_event *event;
> -	unsigned long flags = 0;
> +	unsigned long flags;
>  
>  	/* drop event on the floor if no one's listening */
>  	if (!event_is_open)
> @@ -400,7 +399,7 @@ EXPORT_SYMBOL(acpi_bus_generate_proc_event);
>  
>  int acpi_bus_receive_event(struct acpi_bus_event *event)
>  {
> -	unsigned long flags = 0;
> +	unsigned long flags;
>  	struct acpi_bus_event *entry = NULL;
>  
>  	DECLARE_WAITQUEUE(wait, current);
> @@ -593,7 +592,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
>  
>  static int __init acpi_bus_init_irq(void)
>  {
> -	acpi_status status = AE_OK;
> +	acpi_status status;
>  	union acpi_object arg = { ACPI_TYPE_INTEGER };
>  	struct acpi_object_list arg_list = { 1, &arg };
>  	char *message = NULL;
> @@ -640,7 +639,7 @@ u8 acpi_gbl_permanent_mmap;
>  
>  void __init acpi_early_init(void)
>  {
> -	acpi_status status = AE_OK;
> +	acpi_status status;
>  
>  	if (acpi_disabled)
>  		return;
> @@ -714,8 +713,8 @@ void __init acpi_early_init(void)
>  
>  static int __init acpi_bus_init(void)
>  {
> -	int result = 0;
> -	acpi_status status = AE_OK;
> +	int result;
> +	acpi_status status;
>  	extern acpi_status acpi_os_initialize1(void);
>  
>  	acpi_os_initialize1();
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
