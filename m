From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
Date: Wed, 1 Jul 2009 23:19:52 +0200
Message-ID: <200907012319.53021.trenn@suse.de>
References: <1246415391.24831.30.camel@minggr.sh.intel.com> <200907011135.26370.trenn@suse.de> <4911F71203A09E4D9981D27F9D8308582EA03B4A@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:39935 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752741AbZGAVTa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Jul 2009 17:19:30 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D8308582EA03B4A@orsmsx503.amr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Lin, Ming M" <ming.m.lin@intel.com>, Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, jdelvare@suse.de

On Wednesday 01 July 2009 05:29:57 pm Moore, Robert wrote:
> >-----Original Message-----
> >From: Thomas Renninger [mailto:trenn@suse.de]
> >Sent: Wednesday, July 01, 2009 2:35 AM
> >To: Lin, Ming M
> >Cc: Len Brown; Moore, Robert; Zhao, Yakui; linux-acpi
> >Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
> >acpi_os_validate_address interface"
> >
> >On Wednesday 01 July 2009 11:23:38 Lin Ming wrote:
> >> On Wed, 2009-07-01 at 16:56 +0800, Thomas Renninger wrote:
> >> > Hi Lin,
> >> >
> >> > thanks for adding me.
> >> > This is not "that" sever, but IMO this one should also be submitted
> >> > to 2.6.30 stable kernels as it is a riskless revert of a patch
> >> > fixing a regression.
> >> >
> >> > On Wednesday 01 July 2009 04:29:51 Lin Ming wrote:
> >> > >     Revert "ACPICA: Remove obsolete acpi_os_validate_address
> >
> >interface"
> >
> >> > >     This reverts commit f9ca058430333c9a24c5ca926aa445125f88df18.
> >> > >
> >> > >     The quick fix of bug 13620 would be to revert the change.
> >> > >     http://bugzilla.kernel.org/show_bug.cgi?id=13620
> >> > >
> >> > >     Also, see the commit df92e695998e1bc6e426a840eb86d6d1ee87e2a5
> >> > >     "ACPI: track opregion names to avoid driver resource conflicts."
> >> > >

< Cut out some badly formatted text >

Jean, for you info: We have two problems here, not sure you saw this:
1) The acpica method to tell the os which IO addresses might get used got reverted,
     thus the acpi_enforce_resources=strict/lax/no functionality does not exist any more.
2) Our, or say may part of the acpi_enforce_resources= implementation introduces a
     sever memleak. Opregion declarations can be inside of functions and can be called
     again and again. The list I introduced may increase forever if often called ACPI functions
     include OpRegion declarations...
> >> For example, the dynamic region which defined in a method,
> >>
> >> Method(m000)
> >> {
> >> 	OperationRegion (xxxx, SystemMemory, 0xFED11000, 0xFF)
> >> 	.....
> >> }
> >>
> >> If method m000 is called multiple times, then the region xxxx will be
> >> inserted to the resource list again and again.
> >>
> >> So we need item 2 above to delete the dynamic region from the resource
> >> list.
> >
> >Ouch, I thought OperationRegions must be declared in global namespace.
> >I agree, we have a memleak and this looks rather sever.

An idea for a quick fix which may be suitable for stable kernels (without
checking acpica code..):
Is it easily possible to check whether the Opregion is declared in global
namespace or inside a method at the place where acpi_os_validate_address is called
from acpica?
In the latter case it should not be called and we avoid the memleak and
could still detect most i2c/smbus/hwmon devices conflicts.

> >Grmpfl, that makes the resource conflict checking even more ugly.
> >Thanks for spotting this,
> >
> >     Thomas
>
> OperationRegions/Fields can be dynamically created/deleted in two ways:
> 1) Control method execution
> 2) Dynamic ACPI table load/unload (for example, hotplug)
>
> So, in order to track this, the resource list must also be dynamic, with
> the ability to add and delete entries.
>
> It begins to sound like the resource list is becoming a "mini-namespace"
> that consists of only ACPI field objects. Might it not be more efficient to
> simply query the existing ACPI namespace when you need to? A walk_namespace
> for field objects would give you the same information as the resource list,
> and it is automatically guaranteed to be current.
>
> However, the may be some more fundamental issues. I have not looked at
> exactly how the resource list is used, but since the list is dynamic, if
> the worry concerns address collisions between a driver and the AML
> interpreter, it may not be enough to simply check for this at the time the
> driver is loaded. You would really need to check before *every* I/O or
> memory access. Which does not sound feasible.
>
> I guess that I would like to understand the exact issue(s) that are behind
> the creation of the resource list in the first place. AFAIK, any AML code
> that reads/writes to operation regions usually assumes exclusive access to
> these regions. The ACPI Global Lock is used when exclusive access cannot be
> assumed.

Thinking a bit more about this problem is probably a good idea.
The resource checking  always was a workaround which may avoid loading of
drivers because Opregion declarations may never get used.
When I looked at DSDTs I had the problem that BIOSes declare all kind of
things like overlapping and double declarations. I initially wanted to
add things somehow to:
/proc/iomem and /proc/ioports, but I finally didn't see a way to do that.

    Thomas
