From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [07/12] acpi: sysfs convert
Date: Thu, 28 Sep 2006 14:06:08 +0800
Message-ID: <1159423568.14331.34.camel@localhost.localdomain>
References: <1158918128.11985.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6762 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1161019AbWI1GEa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Sep 2006 02:04:30 -0400
In-Reply-To: <1158918128.11985.74.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, shaohua.li@intel.com

On Fri, 2006-09-22 at 17:42 +0800, Zhang Rui wrote:
> From: Patrick Mochel <mochel@linux.intel.com>
> From: Li Shaohua <shaohua.li@intel.com>
> 
> Setup new sysfs framework
> 
> 1.	Remove /sys/firmware/acpi
> 2.	Add ACPI device in device tree.
> 
> NOTE:	_EJ0 is now a property of device in device tree.
File "eject" for every device that has _EJ0 method is moved from
/sys/firmware to /sys/devices.
Operation on this file is exactly the same as before.
i.e. echo 1 to "eject" will cause hot removal of this device.
> 	Corresponding changes should be made in userspace for hot removal.
>
