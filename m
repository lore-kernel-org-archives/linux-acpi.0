From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device
	in sysfs
Date: Sun, 26 Nov 2006 13:10:10 +0800
Message-ID: <1164517810.5768.126.camel@localhost.localdomain>
References: <11643454612902-git-send-email-len.brown@intel.com>
	 <11643454754138-git-send-email-len.brown@intel.com>
	 <11643454762691-git-send-email-len.brown@intel.com>
	 <200611240136.04511.len.brown@intel.com>
	 <1164361231.5768.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:41808 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S967298AbWKZFGm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 26 Nov 2006 00:06:42 -0500
In-Reply-To: <1164361231.5768.93.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Li Shaohua <shaohua.li@intel.com>

> > Also, the ACPI spec has some pre-defined root name-spaces, and I think
> > it makes sense to look up the device name against a small table of
> > those reserved names and print something more interesting than
> > a number.
> > 
> > eg. 
> > _SB	system_bus
> > _PR processors
> > _TZ thermal_zones
> > _SI system_indicators
> > _GPE events
> > 
> Yeah. I can do that. But few devices can benefit from this. :(.
> 
> 
> BTW: Maybe I can generate a patch to get the following result:
> Five devices with the fixed name shown above if they are declared in the
> BIOS
> And add a prefix for every devices, the prefix is one of fixed names,
> _SB _PR _TZ _SI _GPE. So devices are shown like _SB:dev001, _TZ:dev001,
> _PR:dev033 etc.
> But does this make sense? :(
> 
> The best way is to define a unique and meaning rule to name all the ACPI
> devices. Unfortunately we haven't reached an agreement until now, but I
> think we can leave this for further discussion.

Another way to fix this naming problem.
Many devices in ACPI namespace is meaningless. Only the devices with a
PNPID are physical devices and should be exported to userspace.
So we can only register these devices and use "PNPID:instance no" as its
name.
Add instance_no in struct acpi_device. Every time we fail to register an
ACPI device and get an error of "-EEXIST", loop acpi_device_list to get
the right instance_no and register again.

Thanks,
Ray
