From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: Bug: linux/acpi may execute notify handler that has been
	removed
Date: Thu, 27 Sep 2007 12:54:07 +0800
Message-ID: <1190868847.22470.0.camel@sli10-conroe.sh.intel.com>
References: <1190863833.26892.63.camel@acpi-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35898 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbXI0FMl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Sep 2007 01:12:41 -0400
In-Reply-To: <1190863833.26892.63.camel@acpi-hp.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, rebort.moore@intel.com, astarikovskiy@suse.de

On Thu, 2007-09-27 at 11:30 +0800, Zhang Rui wrote:
> Hi, all,
> 
> I found a bug that linux/acpi may execute notify handler that
> has been removed.
> 
> When a system notify(0~0x7f) is received, linux/acpi will
> first invoke the generic system notify handler (acpi_bus_notify)
> and then invoke the per-device notify handler if present.
> 
> In my case, I add some code in acpi_bus_notify for battery
> hotplug support, so that the generic system notify handler will
> remove the battery device, including the per-device notify handler
> acpi_battery_notify() when receiving notification
> ACPI_NOTIFY_EJECT_REQUEST.
> But linux/acpi invokes the per-device notify handler soon and
> this breaks the system.
> 
> Further more, device hot-removal is not the only case to encounter
> this bug. For example, linux/acpi receives a notification and adds it
> in the workqueue, and then the driver(notify handler) is removed
> before kacpid_notify invoke it...
For the non-hotplug case, adding a flush work queue just after notify
handler is removed should be ok.

Thanks,
Shaohua
