From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: sysfs regression on Supermicro X7DB8+
Date: Thu, 21 Dec 2006 17:50:50 +0800
Message-ID: <1166694650.12505.15.camel@localhost.localdomain>
References: <200612210341.08394.lenb@kernel.org>
	 <200612210428.33389.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45176 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965182AbWLUJqU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 Dec 2006 04:46:20 -0500
In-Reply-To: <200612210428.33389.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thu, 2006-12-21 at 04:28 -0500, Len Brown wrote:
> lenb@supermicro:~> ls /sys/bus/acpi/drivers
> ACPI AC Adapter Driver           ACPI PCI Root Bridge Driver
> ACPI Battery Driver              ACPI Power Resource Driver
> ACPI Button Driver               ACPI Processor Driver
> ACPI container driver            ACPI Thermal Zone Driver
> ACPI Embedded Controller Driver  hpet
> ACPI Fan Driver                  motherboard
> ACPI PCI Interrupt Link Driver
> lenb@supermicro:~>
> 
> Seems with the exception of motherboard and hpet, we have the description
> confused with the .name.  I'll fix this.
> 
Yes, Thomas mentioned it about half a month ago.
And I think it should be fixed in another patch separated from the sysfs
branch. And short names like "ac", "fan", seems to be more convenient.

> What is "PNPIDNON" (below) supposed to mean?
> 
For devices with PNPID, we use PNPID:instance_no as the bus_id.
But for others without PNPID, we set PNPIDNON:instance_no as their
bus_id instead.
> 
> 
> supermicro:~ # ls /sys/bus/acpi/devices
> ACPI_CPU:00  ACPI_THM:00  PNP0800:00  PNP0C0F:03   PNPIDNON:04  PNPIDNON:0e
> ACPI_CPU:01  INT0800:00   PNP0A03:00  PNP0C0F:04   PNPIDNON:05  PNPIDNON:0f
> ACPI_CPU:02  PNP0000:00   PNP0A05:00  PNP0C0F:05   PNPIDNON:06  PNPIDNON:10
> ACPI_CPU:03  PNP0100:00   PNP0B00:00  PNP0C0F:06   PNPIDNON:07  PNPIDNON:11
> ACPI_CPU:04  PNP0200:00   PNP0C02:00  PNP0C0F:07   PNPIDNON:08  PNPIDNON:12
> ACPI_CPU:05  PNP0303:00   PNP0C04:00  PNP0F13:00   PNPIDNON:09  PNPIDNON:13
> ACPI_CPU:06  PNP0401:00   PNP0C0C:00  PNPIDNON:00  PNPIDNON:0a  PNPIDNON:14
> ACPI_CPU:07  PNP0501:00   PNP0C0F:00  PNPIDNON:01  PNPIDNON:0b  PNPIDNON:15
> ACPI_FPB:00  PNP0501:01   PNP0C0F:01  PNPIDNON:02  PNPIDNON:0c
> ACPI_SYS:00  PNP0700:00   PNP0C0F:02  PNPIDNON:03  PNPIDNON:0d
> 
> supermicro:~# ls /sys/bus/acpi/devices/PNPIDNON*
> PNPIDNON:00:
> path  PNP0A03:00  power  subsystem  uevent
> 
> PNPIDNON:01:
> path  PNPIDNON:02  PNPIDNON:07  power  subsystem  uevent
> 
> PNPIDNON:02:
> path  PNPIDNON:03  PNPIDNON:06  power  subsystem  uevent
> 
> PNPIDNON:03:
> path  PNPIDNON:04  PNPIDNON:05  power  subsystem  uevent
> 
> PNPIDNON:04:
> path  power  subsystem  uevent
> 
> PNPIDNON:05:
> path  power  subsystem  uevent
> 
> PNPIDNON:06:
> path  power  subsystem  uevent
> 
> PNPIDNON:07:
> path  power  subsystem  uevent
> 
> PNPIDNON:08:
> path  power  subsystem  uevent
> 
> PNPIDNON:09:
> path  power  subsystem  uevent
> 
> PNPIDNON:0a:
> path  power  subsystem  uevent
> 
> PNPIDNON:0b:
> path  power  subsystem  uevent
> 
> PNPIDNON:0c:
> path  power  subsystem  uevent
> 
> PNPIDNON:0d:
> path  power  subsystem  uevent
> 
> PNPIDNON:0e:
> path  power  subsystem  uevent
> 
> PNPIDNON:0f:
> path  power  subsystem  uevent
> 
> PNPIDNON:10:
> INT0800:00  PNP0200:00  PNP0C02:00  PNP0C0F:02  PNP0C0F:06  uevent
> path        PNP0800:00  PNP0C04:00  PNP0C0F:03  PNP0C0F:07
> PNP0000:00  PNP0A05:00  PNP0C0F:00  PNP0C0F:04  power
> PNP0100:00  PNP0B00:00  PNP0C0F:01  PNP0C0F:05  subsystem
> 
> PNPIDNON:11:
> path  PNPIDNON:12  power  subsystem  uevent
> 
> PNPIDNON:12:
> path  PNPIDNON:13  PNPIDNON:14  power  subsystem  uevent
> 
> PNPIDNON:13:
> path  power  subsystem  uevent
> 
> PNPIDNON:14:
> path  power  subsystem  uevent
> 
> PNPIDNON:15:
> path  power  subsystem  uevent
