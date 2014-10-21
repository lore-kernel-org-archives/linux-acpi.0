From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 5/5] ACPI/EC: Cleanup coding style.
Date: Tue, 21 Oct 2014 15:28:54 +0200
Message-ID: <3800233.k8O1O1ikkG@vostro.rjw.lan>
References: <cover.1413267704.git.lv.zheng@intel.com> <3a29a6449a21e632f67aceb495ec111a3f16bbd2.1413267704.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53904 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932170AbaJUNIa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Oct 2014 09:08:30 -0400
In-Reply-To: <3a29a6449a21e632f67aceb495ec111a3f16bbd2.1413267704.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

On Tuesday, October 14, 2014 02:24:01 PM Lv Zheng wrote:
> This patch cleans up the following coding style issues that are detected by
> scripts/checkpatch.pl:
>  ERROR: code indent should use tabs where possible
>  ERROR: "foo * bar" should be "foo *bar"
>  WARNING: Missing a blank line after declarations
>  WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
>  WARNING: void function return statements are not generally useful
>  WARNING: else is not generally useful after a break or return
>  WARNING: break is not useful after a goto or return
>  WARNING: braces {} are not necessary for single statement blocks
>  WARNING: line over 80 characters
>  WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
> No functional changes.
> 
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/ec.c |   58 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index d993df6..5f4e6c6 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -128,12 +128,13 @@ static int EC_FLAGS_SKIP_DSDT_SCAN; /* Not all BIOS survive early DSDT scan */
>  static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/resume */
>  
>  /* --------------------------------------------------------------------------
> -                             Transaction Management
> -   -------------------------------------------------------------------------- */
> + *                           Transaction Management
> + * -------------------------------------------------------------------------- */
>  
>  static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
>  {
>  	u8 x = inb(ec->command_addr);
> +
>  	pr_debug("EC_SC(R) = 0x%2.2x "
>  		 "SCI_EVT=%d BURST=%d CMD=%d IBF=%d OBF=%d\n",
>  		 x,
> @@ -148,6 +149,7 @@ static inline u8 acpi_ec_read_status(struct acpi_ec *ec)
>  static inline u8 acpi_ec_read_data(struct acpi_ec *ec)
>  {
>  	u8 x = inb(ec->data_addr);
> +
>  	pr_debug("EC_DATA(R) = 0x%2.2x\n", x);
>  	return x;
>  }
> @@ -189,6 +191,7 @@ static int ec_transaction_completed(struct acpi_ec *ec)
>  {
>  	unsigned long flags;
>  	int ret = 0;
> +
>  	spin_lock_irqsave(&ec->lock, flags);
>  	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_COMPLETE))
>  		ret = 1;
> @@ -288,6 +291,7 @@ static int ec_poll(struct acpi_ec *ec)
>  {
>  	unsigned long flags;
>  	int repeat = 5; /* number of command restarts */
> +
>  	while (repeat--) {
>  		unsigned long delay = jiffies +
>  			msecs_to_jiffies(ec_delay);
> @@ -320,6 +324,7 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
>  {
>  	unsigned long tmp;
>  	int ret = 0;
> +
>  	if (EC_FLAGS_MSI)
>  		udelay(ACPI_EC_MSI_UDELAY);
>  	/* start transaction */
> @@ -347,6 +352,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
>  {
>  	int status;
>  	u32 glk;
> +
>  	if (!ec || (!t) || (t->wlen && !t->wdata) || (t->rlen && !t->rdata))
>  		return -EINVAL;
>  	if (t->rdata)
> @@ -374,7 +380,7 @@ static int acpi_ec_transaction(struct acpi_ec *ec, struct transaction *t)
>  	/* check if we received SCI during transaction */
>  	ec_check_sci_sync(ec, acpi_ec_read_status(ec));
>  	if (test_bit(EC_FLAGS_GPE_STORM, &ec->flags)) {
> -		msleep(1);
> +		msleep(20);

This is a functional change, so I've dropped it from the patch (it didn't apply for
me anyway).  Please send it as a separate patch with an appropriate changelog if
you want to make it.

>  		/* It is safe to enable the GPE outside of the transaction. */
>  		acpi_enable_gpe(NULL, ec->gpe, TRUE);
>  	} else if (t->irq_count > ec_storm_threshold) {
> @@ -410,7 +416,7 @@ static int acpi_ec_burst_disable(struct acpi_ec *ec)
>  				acpi_ec_transaction(ec, &t) : 0;
>  }
>  
> -static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 * data)
> +static int acpi_ec_read(struct acpi_ec *ec, u8 address, u8 *data)
>  {
>  	int result;
>  	u8 d;
> @@ -446,10 +452,9 @@ int ec_read(u8 addr, u8 *val)
>  	if (!err) {
>  		*val = temp_data;
>  		return 0;
> -	} else
> -		return err;
> +	}
> +	return err;
>  }
> -
>  EXPORT_SYMBOL(ec_read);
>  
>  int ec_write(u8 addr, u8 val)
> @@ -463,22 +468,21 @@ int ec_write(u8 addr, u8 val)
>  
>  	return err;
>  }
> -
>  EXPORT_SYMBOL(ec_write);
>  
>  int ec_transaction(u8 command,
> -		   const u8 * wdata, unsigned wdata_len,
> -		   u8 * rdata, unsigned rdata_len)
> +		   const u8 *wdata, unsigned wdata_len,
> +		   u8 *rdata, unsigned rdata_len)
>  {
>  	struct transaction t = {.command = command,
>  				.wdata = wdata, .rdata = rdata,
>  				.wlen = wdata_len, .rlen = rdata_len};
> +
>  	if (!first_ec)
>  		return -ENODEV;
>  
>  	return acpi_ec_transaction(first_ec, &t);
>  }
> -
>  EXPORT_SYMBOL(ec_transaction);
>  
>  /* Get the handle to the EC device */
> @@ -488,7 +492,6 @@ acpi_handle ec_get_handle(void)
>  		return NULL;
>  	return first_ec->handle;
>  }
> -
>  EXPORT_SYMBOL(ec_get_handle);
>  
>  /*
> @@ -552,13 +555,14 @@ void acpi_ec_unblock_transactions_early(void)
>  		clear_bit(EC_FLAGS_BLOCKED, &first_ec->flags);
>  }
>  
> -static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 * data)
> +static int acpi_ec_query_unlocked(struct acpi_ec *ec, u8 *data)
>  {
>  	int result;
>  	u8 d;
>  	struct transaction t = {.command = ACPI_EC_COMMAND_QUERY,
>  				.wdata = NULL, .rdata = &d,
>  				.wlen = 0, .rlen = 1};
> +
>  	if (!ec || !data)
>  		return -EINVAL;
>  	/*
> @@ -584,6 +588,7 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
>  {
>  	struct acpi_ec_query_handler *handler =
>  	    kzalloc(sizeof(struct acpi_ec_query_handler), GFP_KERNEL);
> +
>  	if (!handler)
>  		return -ENOMEM;
>  
> @@ -596,12 +601,12 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
>  	mutex_unlock(&ec->mutex);
>  	return 0;
>  }
> -
>  EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);
>  
>  void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
>  {
>  	struct acpi_ec_query_handler *handler, *tmp;
> +
>  	mutex_lock(&ec->mutex);
>  	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
>  		if (query_bit == handler->query_bit) {
> @@ -611,12 +616,12 @@ void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
>  	}
>  	mutex_unlock(&ec->mutex);
>  }
> -
>  EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
>  
>  static void acpi_ec_run(void *cxt)
>  {
>  	struct acpi_ec_query_handler *handler = cxt;
> +
>  	if (!handler)
>  		return;
>  	pr_debug("##### Query(0x%02x) started #####\n", handler->query_bit);
> @@ -660,6 +665,7 @@ static int acpi_ec_sync_query(struct acpi_ec *ec, u8 *data)
>  static void acpi_ec_gpe_query(void *ec_cxt)
>  {
>  	struct acpi_ec *ec = ec_cxt;
> +
>  	if (!ec)
>  		return;
>  	mutex_lock(&ec->mutex);
> @@ -694,8 +700,8 @@ static u32 acpi_ec_gpe_handler(acpi_handle gpe_device,
>  }
>  
>  /* --------------------------------------------------------------------------
> -                             Address Space Management
> -   -------------------------------------------------------------------------- */
> + *                           Address Space Management
> + * -------------------------------------------------------------------------- */
>  
>  static acpi_status
>  acpi_ec_space_handler(u32 function, acpi_physical_address address,
> @@ -726,27 +732,26 @@ acpi_ec_space_handler(u32 function, acpi_physical_address address,
>  	switch (result) {
>  	case -EINVAL:
>  		return AE_BAD_PARAMETER;
> -		break;
>  	case -ENODEV:
>  		return AE_NOT_FOUND;
> -		break;
>  	case -ETIME:
>  		return AE_TIME;
> -		break;
>  	default:
>  		return AE_OK;
>  	}
>  }
>  
>  /* --------------------------------------------------------------------------
> -                               Driver Interface
> -   -------------------------------------------------------------------------- */
> + *                             Driver Interface
> + * -------------------------------------------------------------------------- */
> +
>  static acpi_status
>  ec_parse_io_ports(struct acpi_resource *resource, void *context);
>  
>  static struct acpi_ec *make_acpi_ec(void)
>  {
>  	struct acpi_ec *ec = kzalloc(sizeof(struct acpi_ec), GFP_KERNEL);
> +
>  	if (!ec)
>  		return NULL;
>  	ec->flags = 1 << EC_FLAGS_QUERY_PENDING;
> @@ -769,9 +774,8 @@ acpi_ec_register_query_methods(acpi_handle handle, u32 level,
>  
>  	status = acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);
>  
> -	if (ACPI_SUCCESS(status) && sscanf(node_name, "_Q%x", &value) == 1) {
> +	if (ACPI_SUCCESS(status) && sscanf(node_name, "_Q%x", &value) == 1)
>  		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
> -	}
>  	return AE_OK;
>  }
>  
> @@ -780,7 +784,6 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  {
>  	acpi_status status;
>  	unsigned long long tmp = 0;
> -
>  	struct acpi_ec *ec = context;
>  
>  	/* clear addr values, ec_parse_io_ports depend on it */
> @@ -808,6 +811,7 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>  static int ec_install_handlers(struct acpi_ec *ec)
>  {
>  	acpi_status status;
> +
>  	if (test_bit(EC_FLAGS_HANDLERS_INSTALLED, &ec->flags))
>  		return 0;
>  	status = acpi_install_gpe_handler(NULL, ec->gpe,
> @@ -1105,7 +1109,8 @@ int __init acpi_ec_ecdt_probe(void)
>  		boot_ec->data_addr = ecdt_ptr->data.address;
>  		boot_ec->gpe = ecdt_ptr->gpe;
>  		boot_ec->handle = ACPI_ROOT_OBJECT;
> -		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
> +		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id,
> +				&boot_ec->handle);
>  		/* Don't trust ECDT, which comes from ASUSTek */
>  		if (!EC_FLAGS_VALIDATE_ECDT)
>  			goto install;
> @@ -1189,6 +1194,5 @@ static void __exit acpi_ec_exit(void)
>  {
>  
>  	acpi_bus_unregister_driver(&acpi_ec_driver);
> -	return;
>  }
>  #endif	/* 0 */
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
