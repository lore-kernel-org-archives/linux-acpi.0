From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Wed, 23 Jan 2008 14:01:34 +0300
Message-ID: <47971E8E.9060006@suse.de>
References: <20080123101832.GB4718@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:41357 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752819AbYAWLCM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 06:02:12 -0500
In-Reply-To: <20080123101832.GB4718@stro.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: maximilian attems <max@stro.at>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, sjoerd@luon.net

maximilian attems wrote:
> got the following question:
> ~/src/hal$ egrep 'voltage_(max|min)_design' -r .
> ./hald/linux/device.c:  if (hal_util_get_int_from_file (path, "voltage_max_design", &voltage_design, 10)) {
> 
> any particular reason the kernel is calling it
> cat /sys/class/power_supply/BAT0/voltage_min_design 
> 14400000
> 
> shall i send in a patch along the line:
> -       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>                 val->intval = battery->design_voltage * 1000;
> 
> or is it hal beeing silly?
> 
On most new batteries design voltage is less than current voltage, thus I've chosen VOLTAGE_MIN_DESIGN.
On older batteries, current voltage may become lower than design, so I think hal should not be very 
strict about how they relate to each other. 

Alex.
