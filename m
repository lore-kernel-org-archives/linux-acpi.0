From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device in sysfs
Date: Mon, 27 Nov 2006 01:10:27 -0500
Message-ID: <200611270110.27543.len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <1164361231.5768.93.camel@localhost.localdomain> <1164517810.5768.126.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44005 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1757073AbWK0GHb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 01:07:31 -0500
In-Reply-To: <1164517810.5768.126.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Li Shaohua <shaohua.li@intel.com>


> Another way to fix this naming problem.
> Many devices in ACPI namespace is meaningless. Only the devices with a
> PNPID are physical devices and should be exported to userspace.
> So we can only register these devices and use "PNPID:instance no" as its
> name.
> Add instance_no in struct acpi_device. Every time we fail to register an
> ACPI device and get an error of "-EEXIST", loop acpi_device_list to get
> the right instance_no and register again.

Yes, PNP-id's have definitions, and when we have the luxury of having
devices with PNP-id's, we should use those, along with an instance number
to handle the case of multiple devices of the PNPid.

Indeed, the question is if we should go so far as to translate the PNPid
into English, or simply use the PNPid string.

eg "PNP0C0C" vs "button".

I vote for the PNPid, since it requires less maintenance:-)

thanks,
-Len
