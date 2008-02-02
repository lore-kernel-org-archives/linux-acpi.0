From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/4] ACPI: Battery hotplug support
Date: Sat, 2 Feb 2008 00:19:03 -0500
Message-ID: <200802020019.03274.lenb@kernel.org>
References: <1200532763.2935.66.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42987 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761324AbYBBFT2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 00:19:28 -0500
In-Reply-To: <1200532763.2935.66.camel@acpi-sony.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, astarikovskiy@suse.de

Series applied to acpi-test

thanks,
-Len

On Wednesday 16 January 2008 20:19, Zhang Rui wrote:
> Hi, all,
> 
> This patch series is for battery hotplug support.
> Please refer to http://bugzilla.kernel.org/show_bug.cgi?id=2884
> 
> Patch 01 flushes kacpi_notify_wq before removing the notify handler
> 	 as well as the kacpid_wq.
> Patch 02 adds a new acpi execute type, OSL_DEVICE_HOTPLUG_HANDLER,
> 	 This is used for the device hotplug notify handler which will be
> 	 queued in keventd_wq so that it can flush the kacpi_notify_wq.
> Patch 03 support battery hotplug in the global system-level notify handler
> 	 acpi_bus_notify.
> Patch 04 fix the deadlock when pokiing the "eject" sysfs attribute
> 	 which is used to eject a device in user space.
> 
> I've tested this patch set on my t43 laptop and it works well.
> Any comment is appreciated. :)
> 
> Thanks,
> Rui
> 
