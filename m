From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ACPI / scan: Fix enumeration for special SPI and I2C
 devices
Date: Mon, 19 Jun 2017 13:14:23 +0300
Message-ID: <5d5cfe3c-28c0-456a-287b-6bdcbe0e6690@linux.intel.com>
References: <20170615124049.19787-1-jarkko.nikula@linux.intel.com>
 <20170618110704.GR629@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59906 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbdFSKO1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jun 2017 06:14:27 -0400
In-Reply-To: <20170618110704.GR629@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

Hi

On 06/18/2017 02:07 PM, Mika Westerberg wrote:
> On Thu, Jun 15, 2017 at 03:40:49PM +0300, Jarkko Nikula wrote:
>> -static void acpi_default_enumeration(struct acpi_device *device)
>> +static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
>>  {
>>  	struct list_head resource_list;
>>  	bool is_spi_i2c_slave = false;
>>
>> -	/*
>> -	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
>> -	 * respective parents.
>> -	 */
>>  	INIT_LIST_HEAD(&resource_list);
>>  	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
>>  			       &is_spi_i2c_slave);
>>  	acpi_dev_free_resource_list(&resource_list);
>> -	if (!is_spi_i2c_slave) {
>> +
>> +	return is_spi_i2c_slave;
>> +}
>
> I wonder if it would be better idea flag the acpi_device and then check
> that flag in acpi_default_enumeration()? Now you need to pass
> spi_i2c_slave from many call sites which looks quite overkill.
>
Sounds a good idea. At quick look we probably can have such flag in 
struct acpi_device_flags since there are already bunch of reserved bits 
and no need to enlarge struct acpi_device.

-- 
Jarkko
