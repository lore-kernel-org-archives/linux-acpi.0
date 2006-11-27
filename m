From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device in sysfs
Date: Mon, 27 Nov 2006 01:06:36 -0500
Message-ID: <200611270106.36732.len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <200611240136.04511.len.brown@intel.com> <1164361231.5768.93.camel@localhost.localdomain>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47555 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1757057AbWK0GDj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Nov 2006 01:03:39 -0500
In-Reply-To: <1164361231.5768.93.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, Li Shaohua <shaohua.li@intel.com>


> > While this addresses the potential name conflict of the previous version,
> > I think this needs some work.
> > 
> > $ ls /sys/devices/0
> > 1  10  2  3  4  5  57  6  7  8  9  bus  hid  path  power  subsystem  uevent
> > 
> > Assigning the unique numbers in a depth-first search
> > leaves irritating gaps -- (see 10 and 57 above).

> That's true.
> But you know, ACPI namespace is a tree in nature. Depth-first is the
> fastest way to traverse the ACPI namespace.

> > Instance numbers need to be per-directory.
> > 
> instance numbers should be unique in the whole ACPI bus, as all of them
> are linked to /sys/bus/acpi/devices/.

In sysfs, a directory is a kernel/user API.
A user-program will want to open directory entries by name,
and the names should make some sense.

The names in /sys/bus/acpi/devices/ and the names in /sys/devices
do not have to be the same.

> > Also, IMHO, the numbers by  themselves look a little strange,
> > maybe dev0, dev1, dev%d etc. wouldn't look so strange?
> > 
> Yes, I can do that. :)
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

No.  My point is that if it a _TZ then we know that it is a "thermal_zone"
an we can just print "thermal_zone".  There is no  reason to make
this cryptic by using the ACPI device names -- they have fixed definitions
and in these few cases we can take advantage of that.
 
> The best way is to define a unique and meaning rule to name all the ACPI
> devices. Unfortunately we haven't reached an agreement until now, but I
> think we can leave this for further discussion.

see next message.

