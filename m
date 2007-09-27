From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: Bug: linux/acpi may execute notify handler that has been	removed
Date: Thu, 27 Sep 2007 10:24:45 +0400
Message-ID: <46FB4CAD.7050201@suse.de>
References: <1190863833.26892.63.camel@acpi-hp.sh.intel.com> <1190868847.22470.0.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:46488 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753067AbXI0GZN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Sep 2007 02:25:13 -0400
In-Reply-To: <1190868847.22470.0.camel@sli10-conroe.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

Shaohua Li wrote:
> On Thu, 2007-09-27 at 11:30 +0800, Zhang Rui wrote:
>> Hi, all,
>>
>> I found a bug that linux/acpi may execute notify handler that
>> has been removed.
>>
>> When a system notify(0~0x7f) is received, linux/acpi will
>> first invoke the generic system notify handler (acpi_bus_notify)
>> and then invoke the per-device notify handler if present.
>>
>> In my case, I add some code in acpi_bus_notify for battery
>> hotplug support, so that the generic system notify handler will
>> remove the battery device, including the per-device notify handler
>> acpi_battery_notify() when receiving notification
>> ACPI_NOTIFY_EJECT_REQUEST.
>> But linux/acpi invokes the per-device notify handler soon and
>> this breaks the system.
>>
>> Further more, device hot-removal is not the only case to encounter
>> this bug. For example, linux/acpi receives a notification and adds it
>> in the workqueue, and then the driver(notify handler) is removed
>> before kacpid_notify invoke it...
> For the non-hotplug case, adding a flush work queue just after notify
> handler is removed should be ok.
I think, the real problem with ACPI hotplug is that we know which devices might appear -- 
they are all enumerated in DSDT, but we don't add them until they appear.
If we do .add for all devices in DSDT, and then just .start/.stop them as they appear/disappear,
we will have to do much less work, and avoid a problem described above...

Regards,
Alex. 

