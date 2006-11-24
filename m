From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 13/13] ACPI: use unique number as bus_id of ACPI device in sysfs
Date: Fri, 24 Nov 2006 01:36:04 -0500
Message-ID: <200611240136.04511.len.brown@intel.com>
References: <11643454612902-git-send-email-len.brown@intel.com> <11643454754138-git-send-email-len.brown@intel.com> <11643454762691-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:26073 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S934444AbWKXGd5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 01:33:57 -0500
In-Reply-To: <11643454762691-git-send-email-len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>

On Friday 24 November 2006 00:17, Len Brown wrote:
> From: Zhang Rui <rui.zhang@intel.com>
> 
> Previously we used the device name in the DSDT, but would
> crash upon encountering a duplicate.  Also, exposing
> the DSDT device name to the user in a path isn't a
> good idea, becauase it is arbitrary.
> So just add two attributes for each device,
> the full pathname in ACPI namespace and hardware_id.

While this addresses the potential name conflict of the previous version,
I think this needs some work.

$ ls /sys/devices/0
1  10  2  3  4  5  57  6  7  8  9  bus  hid  path  power  subsystem  uevent

Assigning the unique numbers in a depth-first search
leaves irritating gaps -- (see 10 and 57 above).
Instance numbers need to be per-directory.

Also, IMHO, the numbers by  themselves look a little strange,
maybe dev0, dev1, dev%d etc. wouldn't look so strange?

Also, the ACPI spec has some pre-defined root name-spaces, and I think
it makes sense to look up the device name against a small table of
those reserved names and print something more interesting than
a number.

eg. 
_SB	system_bus
_PR processors
_TZ thermal_zones
_SI system_indicators
_GPE events

thanks,
-Len
