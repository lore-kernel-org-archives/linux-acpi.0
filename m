From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] [RFC] Patch [1/2] for acpi_memhotplug.c
Date: Thu, 22 Jun 2006 09:13:36 +0900
Message-ID: <20060622091336.be46e7a6.kamezawa.hiroyu@jp.fujitsu.com>
References: <971FCB6690CD0E4898387DBF7552B90E0378BEE7@orsmsx403.amr.corp.intel.com>
	<437F1766.8090705@jp.fujitsu.com>
	<1150853300.5873.49.camel@keithlap>
	<20060621114334.1b954854.kamezawa.hiroyu@jp.fujitsu.com>
	<1150863525.7865.6.camel@keithlap>
	<20060621194832.37124aae.kamezawa.hiroyu@jp.fujitsu.com>
	<1150915426.5830.21.camel@keithlap>
	<1150932228.9235.6.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:18075 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751244AbWFVAMi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Jun 2006 20:12:38 -0400
In-Reply-To: <1150932228.9235.6.camel@keithlap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: kmannth@us.ibm.com
Cc: prarit@redhat.com, linux-acpi@vger.kernel.org, robert.moore@intel.com, darnok@us.ibm.com, lhms-devel@lists.sourceforge.net

On Wed, 21 Jun 2006 16:23:47 -0700
keith mannthey <kmannth@us.ibm.com> wrote:
> Update.  I have moved to 2.6.17-rc6-mm2 to work with the development
> acpi_memhotplug driver there. I have added various debug statements and
> this is what I know. 
> 
Thanks, looks informative.

>   acpi_memory_get_device calls acpi_bus_add
>   acpi_bus_add calls acpi_add_single_object (fails)
>   acpi_add_single_object passes acpi_bus_get_flags
> 				finds the device present
> 				passes acpi_device_set_context
> 				calls acpi_device_register
> 				after calling acpi_bus_find_driver
> 				ends up 
> 				if (!result) *child = device;
> 				and returns. 
>    

Then, "acpi_device" itself is added, but no driver data.
acpi_add_single_object doesn't check return value of acpi_bus_find_driver(), 
as you know. So...
===
static int acpi_bus_find_driver(struct acpi_device *device)
{
<snip>
        list_for_each_safe(node, next, &acpi_bus_drivers) {
<snip>
                if (!acpi_bus_match(device, driver)) {
(*)-----------      result = acpi_bus_driver_init(device, driver);
                        if (!result)
                                goto Done;
                }
....
}
===
Next check point is:
- acpi_bus_driver_init() is called or not
- what acpi_bus_driver_init() returns

in acpi_bus_driver_init()
- driver->ops.add() is called or not
- what it retruns

int acpi_memory_device_add()
- it is called or not
- why this  fails.

If we can find why acpi_bus_driver_init() fails or is not called,
we can find the problem , I think.

-Kame


