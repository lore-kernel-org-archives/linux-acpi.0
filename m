From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 06/12] ACPI: Add acpi_bus_generate_event4() function
Date: Fri, 17 Aug 2007 09:48:04 +0400
Message-ID: <46C53694.1010802@suse.de>
References: <20070816140322.19441.63139.stgit@z61m>	 <20070816140347.19441.31611.stgit@z61m> <1187317411.2920.9.camel@acpi-hp.sh.intel.com> <46C52E05.2090404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55702 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753538AbXHQF57 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Aug 2007 01:57:59 -0400
In-Reply-To: <46C52E05.2090404@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Zhang Rui wrote:
>   
>> On Thu, 2007-08-16 at 18:03 +0400, Alexey Starikovskiy wrote:
>>     
>>> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>>>
>>> acpi_bus_generate_event() takes two strings out of passed device object.
>>> SBS needs to supply these strings directly.
>>>
>>>       
>> This doesn't make sense.
>>     
How much sense in sending different bus_id from the same device?
>> acpi_dev->dev.bus_id is the name we are using for ACPI device in sysfs.
>> That's why acpi_dev->dev.bus_id is exported via netlink message rather
>> than the acpi_dev.pnp.bus_id.
>> BTW: what's wrong with the old acpi_sbs_generate_event thing?
>>     
> There are up to 5 devices in SBS which could send a message.
> From ACPI point of view this is one device.
> Copying strings before and after sending event seems to be mess to me.

Regards,
Alex.

