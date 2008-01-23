From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: battery: add sysfs serial number
Date: Wed, 23 Jan 2008 14:21:49 +0300
Message-ID: <4797234D.60901@suse.de>
References: <20080123101832.GB4718@stro.at> <47971E8E.9060006@suse.de> <20080123111552.GA14757@spring.luon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:49395 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751061AbYAWLWW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jan 2008 06:22:22 -0500
In-Reply-To: <20080123111552.GA14757@spring.luon.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sjoerd Simons <sjoerd@luon.net>
Cc: maximilian attems <max@stro.at>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

Sjoerd Simons wrote:
> On Wed, Jan 23, 2008 at 02:01:34PM +0300, Alexey Starikovskiy wrote:
>> maximilian attems wrote:
>>> got the following question:
>>> ~/src/hal$ egrep 'voltage_(max|min)_design' -r .
>>> ./hald/linux/device.c:  if (hal_util_get_int_from_file (path, "voltage_max_design", &voltage_design, 10)) {
>>>
>>> any particular reason the kernel is calling it
>>> cat /sys/class/power_supply/BAT0/voltage_min_design 14400000
>>>
>>> shall i send in a patch along the line:
>>> -       case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
>>> +       case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
>>>                 val->intval = battery->design_voltage * 1000;
>>>
>>> or is it hal beeing silly?
>>>
>> On most new batteries design voltage is less than current voltage, thus I've chosen VOLTAGE_MIN_DESIGN.
>> On older batteries, current voltage may become lower than design, so I 
>> think hal should not be very strict about how they relate to each other. 
> 
> I'll patch up hal to use voltage_min_design if there is no voltage_max_design
> available. Which should be fine as we already picked up the same value from
> procfs for this property.
> 
> What it does make me wonder about, is why there is a difference between MIN and
> MAX in the power_supply class. As this doesn't seem to have a strict meaning
> (or at least not for ACPI). So why not just voltage_design instead ?
Don't know, may be they had battery for which both min and max voltages are known and 
crossing each needs to be guarded...

Regards,
Alex. 
