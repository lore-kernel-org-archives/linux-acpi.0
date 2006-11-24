From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device
	in sysfs
Date: Fri, 24 Nov 2006 17:40:31 +0800
Message-ID: <1164361231.5768.93.camel@localhost.localdomain>
References: <11643454612902-git-send-email-len.brown@intel.com>
	 <11643454754138-git-send-email-len.brown@intel.com>
	 <11643454762691-git-send-email-len.brown@intel.com>
	 <200611240136.04511.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33596 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1757614AbWKXJhF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 04:37:05 -0500
In-Reply-To: <200611240136.04511.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Li Shaohua <shaohua.li@intel.com>

On Fri, 2006-11-24 at 01:36 -0500, Len Brown wrote:
> On Friday 24 November 2006 00:17, Len Brown wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> > 
> > Previously we used the device name in the DSDT, but would
> > crash upon encountering a duplicate.  Also, exposing
> > the DSDT device name to the user in a path isn't a
> > good idea, becauase it is arbitrary.
> > So just add two attributes for each device,
> > the full pathname in ACPI namespace and hardware_id.
> 
> While this addresses the potential name conflict of the previous version,
> I think this needs some work.
> 
> $ ls /sys/devices/0
> 1  10  2  3  4  5  57  6  7  8  9  bus  hid  path  power  subsystem  uevent
> 
> Assigning the unique numbers in a depth-first search
> leaves irritating gaps -- (see 10 and 57 above).
That's true.
But you know, ACPI namespace is a tree in nature. Depth-first is the
fastest way to traverse the ACPI namespace.
> Instance numbers need to be per-directory.
> 
instance numbers should be unique in the whole ACPI bus, as all of them
are linked to /sys/bus/acpi/devices/.
> Also, IMHO, the numbers by  themselves look a little strange,
> maybe dev0, dev1, dev%d etc. wouldn't look so strange?
> 
Yes, I can do that. :)
> Also, the ACPI spec has some pre-defined root name-spaces, and I think
> it makes sense to look up the device name against a small table of
> those reserved names and print something more interesting than
> a number.
> 
> eg. 
> _SB	system_bus
> _PR processors
> _TZ thermal_zones
> _SI system_indicators
> _GPE events
> 
Yeah. I can do that. But few devices can benefit from this. :(.


BTW: Maybe I can generate a patch to get the following result:
Five devices with the fixed name shown above if they are declared in the
BIOS
And add a prefix for every devices, the prefix is one of fixed names,
_SB _PR _TZ _SI _GPE. So devices are shown like _SB:dev001, _TZ:dev001,
_PR:dev033 etc.
But does this make sense? :(

The best way is to define a unique and meaning rule to name all the ACPI
devices. Unfortunately we haven't reached an agreement until now, but I
think we can leave this for further discussion.
> thanks,
> -Len
