From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/5] device wakeup event support
Date: Mon, 8 Sep 2008 19:41:10 -0700
Message-ID: <200809081941.10546.david-b@pacbell.net>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:28730 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751811AbYIIDDu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Sep 2008 23:03:50 -0400
In-Reply-To: <20080908091926.785882370@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: shaohua.li@intel.com
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

On Monday 08 September 2008, shaohua.li@intel.com wrote:
> This series add device wakeup event detection support. This is the base to
> implement runtime device suspend/resume, though we don't support it now.
> But David said USB is approaching to this. See this bugzilla
> http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.

Glad to see more attention here.  :)

Note that this issue is specific to systems using PCI (at core),
with additional nuances for PCI systems which use ACPI.

Device wakeup through USB works fine on various non-PCI and
non-ACPI embedded systems, without needing these patches.
It's done so for several years now...


> The current process to handle wakeup event is:
> 1. driver enable wakeup event line pme and suspend
> 2. NPME or ACPI receives wakeup event
> 3. NPME or ACPI call .wakeup_event() to clear and disable wakeup
>    event. Driver can do extra things in .wakeup_event() too. 
> 4. NPME or ACPI call generic wakeup event handler (device_receive_wakeup_event())
> 5. device resumes, and goto 1 for next round of suspend
> 
> There are somethings we need discuss:
> 1. is this generic for other platforms?
> 2. what should the generic wakeup event handler do?
> 
> Comments and suggestions are welcome!

My reaction re "generic" is that these mechanisms should
be specific to the busses and platforms involved; see my
comments on patch #1.

However this means that for PCI devices, or PCIE, this can
and should be generic enough to work on non-x86 systems.

It's not quite that generic yet, and there are interactions
between PCI/PCIE and ACPI that will need work.  But having
those layers clean is important; and you've got a decent
start on that.

Plus there are various other wake-capable devices, like
the PS2 devices and UART in /proc/acpi/wakeup on one of
my systems:

Device	S-state	  Status   Sysfs node
PCI0	  S4	 disabled  no-bus:pci0000:00
PS2M	  S4	 disabled  pnp:00:05
PS2K	  S4	 disabled  pnp:00:06
UAR1	  S4	 disabled  pnp:00:08
USB1	  S3	 disabled  pci:0000:00:03.0
USB2	  S3	 disabled  pci:0000:00:03.1
USB3	  S3	 disabled  	<-- BIOS bug: no such hardware
USB4	  S3	 disabled  pci:0000:00:03.3
S139	  S4	 disabled  	<-- BIOS bug: no such hardware
LAN	  S4	 disabled  pci:0000:00:04.0
MDM	  S4	 disabled  	<-- MDM and AUD are the same HW??
AUD	  S4	 disabled  pci:0000:00:02.7
SLPB	  S4	*enabled   

But getting a good start on the PCI and ACPI runtime wake
framework will help a lot.

- Dave
