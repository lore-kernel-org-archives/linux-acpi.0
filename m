From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND patch 2.6.25] ACPI uses device_may_wakeup() policy inputs
Date: Mon, 28 Apr 2008 17:20:16 -0700
Message-ID: <200804281720.16774.david-b@pacbell.net>
References: <200803201408.33466.david-b@pacbell.net> <200804281520.05683.david-b@pacbell.net> <20080428225413.GD3489@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:22079 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753336AbYD2AqK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 20:46:10 -0400
In-Reply-To: <20080428225413.GD3489@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Thomas Renninger <trenn@suse.de>

On Monday 28 April 2008, Henrique de Moraes Holschuh wrote:
> On Mon, 28 Apr 2008, David Brownell wrote:
> > > Which calls for a new standard interface to let userpace control that,
> > > doesn't it?  Issues with wake-up devices are not uncommon, the user
> 
> [...]
> 
> > That "new standard interface" has been in the kernel for quite
> > some time now:  /sys/devices/.../power/wakeup attributes, which
> > default to "enabled" for wake-capable devices.  Set to "disabled"
> > if it's not behaving on your system for some reason.  It's part
> > of the driver model infrastructure.
> 
> Ok.  That answers my point.  Can we override the defaults with whatever
> information ACPI might have about them?

Userspace could do that, for the subset of wakeup-capable
PCI devices known to both Linux and ACPI.

I personally would not want to have a second framework
for managing wakeup events though.  I want to move away
from the ACPI stuff as quickly as possible.  Fortunately,
most Linux users have no idea that ACPI could even wake
up the system ... since drivers generally don't handle it,
it's disabled by default, and no userspace tools enable it.


> I certainly would not expect (or appreciate) that this:
> 
> $ cat /proc/acpi/wakeup 
> Device  S-state   Status   Sysfs node
> LID       S3    *enabled   
> SLPB      S3    *enabled   
> UART      S3     disabled  pnp:00:09
> EXP0      S4     disabled  pci:0000:00:1c.0
> EXP1      S4     disabled  
> EXP2      S4     disabled  pci:0000:00:1c.2
> EXP3      S4     disabled  
> PCI1      S4     disabled  pci:0000:00:1e.0
> USB0      S3     disabled  pci:0000:00:1d.0
> USB1      S3     disabled  pci:0000:00:1d.1
> USB3      S3     disabled  pci:0000:00:1d.3
> USB7      S3     disabled  pci:0000:00:1d.7
> AC9M      S4     disabled  
> 
> (which is mostly following what I told the BIOS to do), to suddely have
> more lines set to "enable" :-)

Actually, every one of those particular lines is the default set
up by the Linux ACPI code:  "never use wakeup unless you must".
Not AFAICT from BIOS; most BIOS wakeup settings I've seen relate
to the RTC, or sometimes the keyboard.  (Neither of which shows
in that list above...)

I don't believe ACPI looks at any messages from BIOS there other
than "does device DDDD have a wakeup method".  And as a rule,
no userspace code will ever change those values from "disabled"...

That said, none of those lines are changed by these two patches.

- Dave
