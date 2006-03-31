From: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [patch 12/26] ACPI: simplify scan.c coding
Date: Fri, 31 Mar 2006 14:14:10 -0700 (MST)
Message-ID: <33888.15.235.249.71.1143839650.squirrel@mail.atl.hp.com>
References: <200603282203.k2SM3iIk027683@shell0.pdx.osdl.net>
    <20060331210059.GB30044@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhub.hp.com ([192.151.27.10]:56208 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S932410AbWCaVOK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 31 Mar 2006 16:14:10 -0500
In-Reply-To: <20060331210059.GB30044@electric-eye.fr.zoreil.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: akpm@osdl.org, len.brown@intel.com, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com

> akpm@osdl.org <akpm@osdl.org> :
> [...]
>> diff -puN drivers/acpi/scan.c~acpi-simplify-scanc-coding
>> drivers/acpi/scan.c
>> --- devel/drivers/acpi/scan.c~acpi-simplify-scanc-coding	2006-03-28
>> 14:03:04.000000000 -0800
>> +++ devel-akpm/drivers/acpi/scan.c	2006-03-28 14:03:04.000000000 -0800
> [...]
>> @@ -639,21 +631,19 @@ EXPORT_SYMBOL(acpi_bus_register_driver);
>>   */
>>  int acpi_bus_unregister_driver(struct acpi_driver *driver)
>>  {
>> -	int error = 0;
>> -
>>  	ACPI_FUNCTION_TRACE("acpi_bus_unregister_driver");
>>
>> -	if (driver) {
>> -		acpi_driver_detach(driver);
>> +	if (!driver)
>> +		return_VALUE(-EINVAL);
>
> Afaiks driver can not be NULL and no one checks the return
> code of acpi_bus_unregister_driver. More cleanup in sight ?

Sure enough.  Other unregister_driver() interfaces are void,
and this probably should be, too.  Thanks.

