From: Sjoerd Simons <sjoerd@luon.net>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Wed, 23 Jan 2008 12:15:53 +0100
Message-ID: <20080123111552.GA14757@spring.luon.net>
References: <20080123101832.GB4718@stro.at> <47971E8E.9060006@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cube.ipv4.spacelabs.nl ([192.87.65.66]:59309 "EHLO
	cube.luon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518AbYAWLfv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 06:35:51 -0500
Content-Disposition: inline
In-Reply-To: <47971E8E.9060006@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: maximilian attems <max@stro.at>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

On Wed, Jan 23, 2008 at 02:01:34PM +0300, Alexey Starikovskiy wrote:
> maximilian attems wrote:
>> got the following question:
>> ~/src/hal$ egrep 'voltage_(max|min)_design' -r .
>> ./hald/linux/device.c:  if (hal_util_get_int_from_file (path, "voltage_max_design", &voltage_design, 10)) {
>>
>> any particular reason the kernel is calling it
>> cat /sys/class/power_supply/BAT0/voltage_min_design 14400000
>>
>> shall i send in a patch along the line:
>> -       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>> +       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>>                 val->intval = battery->design_voltage * 1000;
>>
>> or is it hal beeing silly?
>>
> On most new batteries design voltage is less than current voltage, thus I've chosen VOLTAGE_MIN_DESIGN.
> On older batteries, current voltage may become lower than design, so I 
> think hal should not be very strict about how they relate to each other. 

I'll patch up hal to use voltage_min_design if there is no voltage_max_design
available. Which should be fine as we already picked up the same value from
procfs for this property.

What it does make me wonder about, is why there is a difference between MIN and
MAX in the power_supply class. As this doesn't seem to have a strict meaning
(or at least not for ACPI). So why not just voltage_design instead ?

  Sjoerd
-- 
The solution to a problem changes the nature of the problem.
		-- Peer
