From: maximilian attems <max@stro.at>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Wed, 23 Jan 2008 11:18:32 +0100
Message-ID: <20080123101832.GB4718@stro.at>
References: <479632AB.2030709@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from baikonur.stro.at ([213.239.196.228]:45499 "EHLO
	baikonur.stro.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbYAWKSh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 05:18:37 -0500
Content-Disposition: inline
In-Reply-To: <479632AB.2030709@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, sjoerd@luon.net

[ added debian hal maintainer on cc ]

On Tue, 22 Jan 2008, Alexey Starikovskiy wrote:

> maximilian attems wrote:
>> while checking the missing bits of ACPI_SYSFS_POWER versus
>> ACPI_PROCFS_POWER i also noticed capacity granularity.
>> is that used by anyone?
> IMHO, nobody cares about it.

ack, will add if someone cries.

>> if yes i can send another patch for that too.
> SBS (sbs.c) has cycle_count field, which might be useful too, so you might 
> want to show it as well.

i see, need to testboot to see if my first try went right.

>> want to switch debian to ACPI_SYSFS_POWER.
> Good luck!

done on the linux side.
thanks. :)

got the following question:
~/src/hal$ egrep 'voltage_(max|min)_design' -r .
./hald/linux/device.c:  if (hal_util_get_int_from_file (path, "voltage_max_design", &voltage_design, 10)) {

any particular reason the kernel is calling it
cat /sys/class/power_supply/BAT0/voltage_min_design 
14400000

shall i send in a patch along the line:
-       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
+       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
                val->intval = battery->design_voltage * 1000;

or is it hal beeing silly?

-- 
maks
