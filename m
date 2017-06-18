From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / scan: Fix enumeration for special SPI and I2C
 devices
Date: Sun, 18 Jun 2017 14:07:04 +0300
Message-ID: <20170618110704.GR629@lahna.fi.intel.com>
References: <20170615124049.19787-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:41454 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752976AbdFRLHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 18 Jun 2017 07:07:07 -0400
Content-Disposition: inline
In-Reply-To: <20170615124049.19787-1-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>

On Thu, Jun 15, 2017 at 03:40:49PM +0300, Jarkko Nikula wrote:
> -static void acpi_default_enumeration(struct acpi_device *device)
> +static bool acpi_is_spi_i2c_slave(struct acpi_device *device)
>  {
>  	struct list_head resource_list;
>  	bool is_spi_i2c_slave = false;
>  
> -	/*
> -	 * Do not enumerate SPI/I2C slaves as they will be enumerated by their
> -	 * respective parents.
> -	 */
>  	INIT_LIST_HEAD(&resource_list);
>  	acpi_dev_get_resources(device, &resource_list, acpi_check_spi_i2c_slave,
>  			       &is_spi_i2c_slave);
>  	acpi_dev_free_resource_list(&resource_list);
> -	if (!is_spi_i2c_slave) {
> +
> +	return is_spi_i2c_slave;
> +}

I wonder if it would be better idea flag the acpi_device and then check
that flag in acpi_default_enumeration()? Now you need to pass
spi_i2c_slave from many call sites which looks quite overkill.
