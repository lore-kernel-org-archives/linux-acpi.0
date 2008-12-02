From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH] ACPI: EC: Don't trust ECDT tables from ASUS
Date: Tue, 02 Dec 2008 12:38:09 +0300
Message-ID: <49350201.9010601@suse.de>
References: <20081201204706.32465.23231.stgit@thinkpad> <1228205657.4035.206.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:56778 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751305AbYLBJiJ (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 2 Dec 2008 04:38:09 -0500
In-Reply-To: <1228205657.4035.206.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: LenBrown <lenb@kernel.org>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>

Yakui,

I don't like explanations starting with "maybe". Also, IMHO, patch description should
offer _summary_ of the patch, not explanation of every line in it.
So, if you insist on having description apart from patch name, here is my take:

ASUSTek keeps feeding us with broken ECDT tables, which are very hard to workaround.
So, we end up always checking that ECDT from ASUS has the same info as DSDT, and
bark otherwise.

Regards,
Alex.
Zhao Yakui wrote:
> On Tue, 2008-12-02 at 04:47 +0800, Alexey Starikovskiy wrote:
> 
> It is very good that the check is limited to Asus Box.
> Can the following explanation be added so that we can know why the ECDT
> is not trusted?
>     On some Asus laptops there exists the ECDT table. But unfortunately
> the info defined in ECDT table is incorrect.
>     For example: incorrect EC I/O address, Incorrect EC GPE number
>     It causes that the EC device can't be initialized correctly.
>     Maybe it is appropriate that strict check about ECDT table is added
> for the Asus boxes. For the Asus box even when there exists the ECDT
> table, the EC device will be parsed from DSDT table and compared with
> that defined in ECDT table. If they are different, the BIOS bug will be
> reported and that parsed in DSDT table will be initialized.
> 
> Can this patch be split into two patches?
>    one is to add the strict check for Asus boxes.
>    another is to delete the DMI check that is added for some Asus
> laptops?
No, it will just confuse everyone...
> 
> Thanks.
>    Yakui.
> 
> 
>> References: http://bugzilla.kernel.org/show_bug.cgi?id=9399
>> 	    http://bugzilla.kernel.org/show_bug.cgi?id=11880
>>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> ---
>>
>>  drivers/acpi/ec.c |   72 +++++++++++++++++++++--------------------------------
>>  1 files changed, 29 insertions(+), 43 deletions(-)
>>
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 60db1b2..3927c05 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -121,31 +121,6 @@ static struct acpi_ec {
>>  	spinlock_t curr_lock;
>>  } *boot_ec, *first_ec;
>>  
>> -/* 
>> - * Some Asus system have exchanged ECDT data/command IO addresses.
>> - */
>> -static int print_ecdt_error(const struct dmi_system_id *id)
>> -{
>> -	printk(KERN_NOTICE PREFIX "%s detected - "
>> -		"ECDT has exchanged control/data I/O address\n",
>> -		id->ident);
>> -	return 0;
>> -}
>> -
>> -static struct dmi_system_id __cpuinitdata ec_dmi_table[] = {
>> -	{
>> -	print_ecdt_error, "Asus L4R", {
>> -	DMI_MATCH(DMI_BIOS_VERSION, "1008.006"),
>> -	DMI_MATCH(DMI_PRODUCT_NAME, "L4R"),
>> -	DMI_MATCH(DMI_BOARD_NAME, "L4R") }, NULL},
>> -	{
>> -	print_ecdt_error, "Asus M6R", {
>> -	DMI_MATCH(DMI_BIOS_VERSION, "0207"),
>> -	DMI_MATCH(DMI_PRODUCT_NAME, "M6R"),
>> -	DMI_MATCH(DMI_BOARD_NAME, "M6R") }, NULL},
>> -	{},
>> -};
>> -
>>  /* --------------------------------------------------------------------------
>>                               Transaction Management
>>     -------------------------------------------------------------------------- */
>> @@ -979,8 +954,8 @@ static const struct acpi_device_id ec_device_ids[] = {
>>  int __init acpi_ec_ecdt_probe(void)
>>  {
>>  	acpi_status status;
>> +	struct acpi_ec *saved_ec = NULL;
>>  	struct acpi_table_ecdt *ecdt_ptr;
>> -	acpi_handle dummy;
>>  
>>  	boot_ec = make_acpi_ec();
>>  	if (!boot_ec)
>> @@ -994,21 +969,16 @@ int __init acpi_ec_ecdt_probe(void)
>>  		pr_info(PREFIX "EC description table is found, configuring boot EC\n");
>>  		boot_ec->command_addr = ecdt_ptr->control.address;
>>  		boot_ec->data_addr = ecdt_ptr->data.address;
>> -		if (dmi_check_system(ec_dmi_table)) {
>> -			/*
>> -			 * If the board falls into ec_dmi_table, it means
>> -			 * that ECDT table gives the incorrect command/status
>> -			 * & data I/O address. Just fix it.
>> -			 */
>> -			boot_ec->data_addr = ecdt_ptr->control.address;
>> -			boot_ec->command_addr = ecdt_ptr->data.address;
>> -		}
>>  		boot_ec->gpe = ecdt_ptr->gpe;
>>  		boot_ec->handle = ACPI_ROOT_OBJECT;
>>  		acpi_get_handle(ACPI_ROOT_OBJECT, ecdt_ptr->id, &boot_ec->handle);
>> -		/* Add some basic check against completely broken table */
>> -		if (boot_ec->data_addr != boot_ec->command_addr)
>> +		/* Don't trust ECDT, which comes from ASUSTek */
>> +		if (!dmi_name_in_vendors("ASUS"))
>>  			goto install;
>> +		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
>> +		if (!saved_ec)
>> +			return -ENOMEM;
>> +		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
>>  	/* fall through */
>>  	}
>>  	/* This workaround is needed only on some broken machines,
>> @@ -1019,12 +989,28 @@ int __init acpi_ec_ecdt_probe(void)
>>  	/* Check that acpi_get_devices actually find something */
>>  	if (ACPI_FAILURE(status) || !boot_ec->handle)
>>  		goto error;
>> -	/* We really need to limit this workaround, the only ASUS,
>> -	 * which needs it, has fake EC._INI method, so use it as flag.
>> -	 * Keep boot_ec struct as it will be needed soon.
>> -	 */
>> -	if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI", &dummy)))
>> -		return -ENODEV;
>> +	if (saved_ec) {
>> +		/* try to find good ECDT from ASUSTek */
>> +		if (saved_ec->command_addr != boot_ec->command_addr ||
>> +		    saved_ec->data_addr != boot_ec->data_addr ||
>> +		    saved_ec->gpe != boot_ec->gpe ||
>> +		    saved_ec->handle != boot_ec->handle)
>> +			pr_info(PREFIX "ASUSTek keeps feeding us with broken "
>> +			"ECDT tables, which are very hard to workaround. "
>> +			"Trying to use DSDT EC info instead. Please send "
>> +			"output of acpidump to linux-acpi@vger.kernel.org\n");
>> +		kfree(saved_ec);
>> +		saved_ec = NULL;
>> +	} else {
>> +		/* We really need to limit this workaround, the only ASUS,
>> +		* which needs it, has fake EC._INI method, so use it as flag.
>> +		* Keep boot_ec struct as it will be needed soon.
>> +		*/
>> +		acpi_handle dummy;
>> +		if (ACPI_FAILURE(acpi_get_handle(boot_ec->handle, "_INI",
>> +							&dummy)))
>> +			return -ENODEV;
>> +	}
>>  install:
>>  	if (!ec_install_handlers(boot_ec)) {
>>  		first_ec = boot_ec;
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

