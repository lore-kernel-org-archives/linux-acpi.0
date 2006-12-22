From: Len Brown <lenb@kernel.org>
Subject: Re: sysfs regression on Supermicro X7DB8+
Date: Fri, 22 Dec 2006 00:09:20 -0500
Message-ID: <200612220009.20329.lenb@kernel.org>
References: <200612210341.08394.lenb@kernel.org> <200612211454.04757.lenb@kernel.org> <1166757145.12505.78.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41728 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945939AbWLVFKE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Dec 2006 00:10:04 -0500
In-Reply-To: <1166757145.12505.78.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, "linux-acpi@vger" <linux-acpi@vger.kernel.org>

On Thursday 21 December 2006 22:12, Zhang Rui wrote:
> > > > What is "PNPIDNON" (below) supposed to mean?
> > > > 
> > > For devices with PNPID, we use PNPID:instance_no as the bus_id.
> > > But for others without PNPID, we set PNPIDNON:instance_no as their
> > > bus_id instead.
> > 
> > There must be a better way to name a device that has no  PNPid   than PNPIDNON:#
> > 
> > How about "device:#"?
> Sounds good. Will do.
> > Also,  this for the first time exposes the internal fake ones
> > 
> > /* _HID definitions */
> > 
> > #define ACPI_POWER_HID                  "ACPI_PWR"
> > #define ACPI_PROCESSOR_HID              "ACPI_CPU"
> > #define ACPI_SYSTEM_HID                 "ACPI_SYS"
> > #define ACPI_THERMAL_HID                "ACPI_THM"
> > #define ACPI_BUTTON_HID_POWERF          "ACPI_FPB"
> > #define ACPI_BUTTON_HID_SLEEPF          "ACPI_FSB"
> > 
> > If we are going to expose these, then we should spend a moment to think about how
> > understandable they'll be appearing in the file system.  ACPI_FSB doesn't bring
> > "Fixed Function Sleep Button" to mind when I see it...
> > 
> > Any reason we can't re-use "ACPI0007" for ACPI_PROCESSOR_HID
> > It is already reserved in the spec.
> > 
> > BTW. anybody know what PNP0C08 is supposed to be?
> > Seems it is reserved OS use to describe generic ACPI resources
> > that are not associated with a particular device.
> > 
> > Note that while I don't think we are constrained here, standard PNP-id's must be of the form AAA####
> > where the A's are letters and the #'s are hex.  ACPI-id's must be of the form ACPI####
> > where #'s are again hex.  It would be nice if we could work within those constraints
> > and not conflict with the standard in case something is expecting those formats.
> > eg. IBM specific devices are IBM####, Toshiba are TOS####.
> > But the down-side is that the #### doesn't tell the reader much -- particularly
> > if it is non-standard.

> All these PNPids are from BIOS, and we expose them to userspace
> directly.

right, as we should.  I described the vendor specific HIDs here just as an
example of the format.  Eg. we could do LNX#### and fit within that
naming scheme if we wanted to -- but I like the English word scheme better.

> Now all ACPI devices are registered before any ACPI driver is found. So
> how can we recognize the platform specific devices?

We don't.
These are just like PNP#### -- the are only recognized if a driver binds
to that ID.


> > But if we are not going to stay within the standard format and we are going to blow the 8-character
> > convention, then I vote for strings that actually make sense to human,
> > say something like this:
> > 
> > #define ACPI_POWER_HID                  "power_resource"
> > #define ACPI_PROCESSOR_HID              "processor"
> > #define ACPI_SYSTEM_HID                 "system"
> > #define ACPI_THERMAL_HID                "thermal"
> > #define ACPI_BUTTON_HID_POWERF          "button_power_fixed"
> > #define ACPI_BUTTON_HID_SLEEPF          "button_sleep_fixed"
> That's true. I'll convert these fake PNPids to more interesting strings.

Okay, thanks.
 
> Then I have an idea about the other ones. We can also convert the PNPids
> reserved in the spec to such kind of strings.
> E.g.	"PNP0C0D,PNP0C0C,PNP0C0E"	"button"
> 	"ACPI0003"			"ac_adapter"
> 	"PNP0C0A"			"battery"
> ....
> We can use an array to maintain the name mapping between PNPid and
> bus_id.
> Like this:
> struct acpi_name_mapping {
>  char PNPid[9];	/*both fake PNPids and PNPids reserved by the spec*/
>  char bus_id[20]; /* names expose to userspace */
>  int instance_no;
> }
> static struct acpi_name_mapping acpi_name_mapping_table[] = {
> 	{"PNP0C0A", "battery",0},
> 	{"ACPI_PWER_HID", "powe_resource",0},
> 	....
> 	NULL,
> };
> Then we can expose such kind of strings to userspace instead of PNPids.
> Though it's more friendly, the load is heavy.
> The problem is whether it's worth doing.

While yes, it is sort of tempting to make all the buttons look like "button"
there is only a small list of button types and I think a user/application
can handle the real names.

The real deal killer to putting translation in the kernel is that even if we
could translate the official PNPid list in the kernel (itself a bad idea),
we could never grok the vendor specific Ids -- since even when we
know about them we usually don't even know what they are.

So lets stick to the plan of exposing the platform provided IDs
and manufacturing additional ones when we need them and
the platform doesn't supply them.

thanks,
-Len

