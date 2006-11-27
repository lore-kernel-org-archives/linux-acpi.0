From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device
	in sysfs
Date: Mon, 27 Nov 2006 14:35:21 +0800
Message-ID: <1164609321.5326.17.camel@localhost.localdomain>
References: <11643454612902-git-send-email-len.brown@intel.com>
	 <1164361231.5768.93.camel@localhost.localdomain>
	 <1164517810.5768.126.camel@localhost.localdomain>
	 <200611270110.27543.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12425 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1757082AbWK0Gbr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 01:31:47 -0500
In-Reply-To: <200611270110.27543.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Li Shaohua <shaohua.li@intel.com>

On Mon, 2006-11-27 at 01:10 -0500, Len Brown wrote:
> > Another way to fix this naming problem.
> > Many devices in ACPI namespace is meaningless. Only the devices with a
> > PNPID are physical devices and should be exported to userspace.
> > So we can only register these devices and use "PNPID:instance no" as its
> > name.
> > Add instance_no in struct acpi_device. Every time we fail to register an
> > ACPI device and get an error of "-EEXIST", loop acpi_device_list to get
> > the right instance_no and register again.
> 
> Yes, PNP-id's have definitions, and when we have the luxury of having
> devices with PNP-id's, we should use those, along with an instance number
> to handle the case of multiple devices of the PNPid.
> 
> Indeed, the question is if we should go so far as to translate the PNPid
> into English, or simply use the PNPid string.
> 
> eg "PNP0C0C" vs "button".
> 
> I vote for the PNPid, since it requires less maintenance:-)
> 
Yes.
For now, we can use "pnpid:instance_no" for devices with pnpid. For
devices without PNPid, we recognise them as "NO_PNPID:instance_no". Is
this OK?
> thanks,
> -Len
