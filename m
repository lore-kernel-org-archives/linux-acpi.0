From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 06/12] ACPI: Add acpi_bus_generate_event4() function
Date: Fri, 17 Aug 2007 09:11:33 +0400
Message-ID: <46C52E05.2090404@gmail.com>
References: <20070816140322.19441.63139.stgit@z61m>	 <20070816140347.19441.31611.stgit@z61m> <1187317411.2920.9.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:20546 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755889AbXHQFLm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Aug 2007 01:11:42 -0400
Received: by ug-out-1314.google.com with SMTP id j3so309314ugf
        for <linux-acpi@vger.kernel.org>; Thu, 16 Aug 2007 22:11:41 -0700 (PDT)
In-Reply-To: <1187317411.2920.9.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Zhang Rui wrote:
> On Thu, 2007-08-16 at 18:03 +0400, Alexey Starikovskiy wrote:
>> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>>
>> acpi_bus_generate_event() takes two strings out of passed device object.
>> SBS needs to supply these strings directly.
>>
> This doesn't make sense.
> acpi_dev->dev.bus_id is the name we are using for ACPI device in sysfs.
> That's why acpi_dev->dev.bus_id is exported via netlink message rather
> than the acpi_dev.pnp.bus_id.
> BTW: what's wrong with the old acpi_sbs_generate_event thing?
There are up to 5 devices in SBS which could send a message.
>From ACPI point of view this is one device.
Copying strings before and after sending event seems to be mess to me.

Regards,
Alex.
