From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
 acpi_os_validate_address interface"
Date: Wed, 1 Jul 2009 08:29:57 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308582EA03B4A@orsmsx503.amr.corp.intel.com>
References: <1246415391.24831.30.camel@minggr.sh.intel.com>
 <200907011056.36545.trenn@suse.de>
 <1246440218.24831.41.camel@minggr.sh.intel.com>
 <200907011135.26370.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38364 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289AbZGAP3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2009 11:29:55 -0400
In-Reply-To: <200907011135.26370.trenn@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, "Lin, Ming M" <ming.m.lin@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>



>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Wednesday, July 01, 2009 2:35 AM
>To: Lin, Ming M
>Cc: Len Brown; Moore, Robert; Zhao, Yakui; linux-acpi
>Subject: Re: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
>acpi_os_validate_address interface"
>
>On Wednesday 01 July 2009 11:23:38 Lin Ming wrote:
>> On Wed, 2009-07-01 at 16:56 +0800, Thomas Renninger wrote:
>> > Hi Lin,
>> >
>> > thanks for adding me.
>> > This is not "that" sever, but IMO this one should also be submitted
>> > to 2.6.30 stable kernels as it is a riskless revert of a patch
>> > fixing a regression.
>> >
>> > On Wednesday 01 July 2009 04:29:51 Lin Ming wrote:
>> > >     Revert "ACPICA: Remove obsolete acpi_os_validate_address
>interface"
>> > >
>> > >     This reverts commit f9ca058430333c9a24c5ca926aa445125f88df18.
>> > >
>> > >     The quick fix of bug 13620 would be to revert the change.
>> > >     http://bugzilla.kernel.org/show_bug.cgi?id=13620
>> > >
>> > >     Also, see the commit df92e695998e1bc6e426a840eb86d6d1ee87e2a5
>> > >     "ACPI: track opregion names to avoid driver resource conflicts."
>> > >
>> > >     But there are problems we need to address:
>> > >
>> > >     1. We need to enhance the mechanism of avoiding driver resource
>> > >     conflicts
>> > >        to base a "resource" on Field definitions instead of Operation
>Region
>> > >        definitions.
>> > Good idea, this could avoid some false positive detected region
>conflicts.
>> > >
>> > >     2. For dynamic region, we need an interface to call when an
>operation
>> > >     region (field) is deleted,
>> > >        in order to delete it from the resource list.
>> > >
>> > >     3. If the same region is created and added to resource list over
>and
>> > >     over again,
>> > >        this is have the potential to be a memory leak by growing the
>list
>> > >        every time
>> > Region or field or both?
>>
>> Currently, it's region.
>> If we change the mechanism to base on "Field", as item 1 above, then
>> it's field.
>>
>> > How can this happen, can you show a little ASL snippet or explain this
>a
>bit
>> > more detailed, please. I do not fully understand what is meant in 3.
>>
>> For example, the dynamic region which defined in a method,
>>
>> Method(m000)
>> {
>> 	OperationRegion (xxxx, SystemMemory, 0xFED11000, 0xFF)
>> 	.....
>> }
>>
>> If method m000 is called multiple times, then the region xxxx will be
>> inserted to the resource list again and again.
>>
>> So we need item 2 above to delete the dynamic region from the resource
>> list.
>Ouch, I thought OperationRegions must be declared in global namespace.
>I agree, we have a memleak and this looks rather sever.
>Grmpfl, that makes the resource conflict checking even more ugly.
>Thanks for spotting this,
>
>     Thomas


OperationRegions/Fields can be dynamically created/deleted in two ways:
1) Control method execution
2) Dynamic ACPI table load/unload (for example, hotplug)

So, in order to track this, the resource list must also be dynamic, with the ability to add and delete entries.

It begins to sound like the resource list is becoming a "mini-namespace" that consists of only ACPI field objects. Might it not be more efficient to simply query the existing ACPI namespace when you need to? A walk_namespace for field objects would give you the same information as the resource list, and it is automatically guaranteed to be current.

However, the may be some more fundamental issues. I have not looked at exactly how the resource list is used, but since the list is dynamic, if the worry concerns address collisions between a driver and the AML interpreter, it may not be enough to simply check for this at the time the driver is loaded. You would really need to check before *every* I/O or memory access. Which does not sound feasible.

I guess that I would like to understand the exact issue(s) that are behind the creation of the resource list in the first place. AFAIK, any AML code that reads/writes to operation regions usually assumes exclusive access to these regions. The ACPI Global Lock is used when exclusive access cannot be assumed.

Bob

