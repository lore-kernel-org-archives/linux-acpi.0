From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
Date: Thu, 16 Oct 2008 08:51:42 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085803278477@orsmsx503.amr.corp.intel.com>
References: <1223885404.2735.183.camel@rzhang-dt>
 <4911F71203A09E4D9981D27F9D83085803194DE3@orsmsx503.amr.corp.intel.com>
 <1223947180.2735.228.camel@rzhang-dt>
 <alpine.LFD.1.10.0810151801290.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33961 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754283AbYJPPvq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 11:51:46 -0400
In-Reply-To: <alpine.LFD.1.10.0810151801290.3026@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>



>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Wednesday, October 15, 2008 3:21 PM
>To: Zhang, Rui
>Cc: Moore, Robert; linux-acpi
>Subject: RE: [PATCH 0/6] ACPI: acpi table management enhancement
>
>
>Bob,
>note that we already changed acpidump to get the inactive static
>tables.  We did this back when we were running into bugs with "invalid"
>XSDT's and found some machines needed to revert back to using the RSDTs.
>
>Indeed, while I think we nailed some of the major offenders,
>But I suspect we still have some bug compatibility detective work
>to do in that area.
>

I wasn't aware that acpidump can now get the tables from the RSDT also. This is good.

As I mentioned, I would like to eventually pull acpidump into the core ACPICA code and make it OS-independent at the same time.


>So what Rui is doing here in exposing inactive tables it to get
>/sys/firmware/acpi/tables to have the equal capability
>of the existing acpidump kvm reader.
>

I was pointing out that there is significant overhead in acquiring these unused tables. I'm not sure I understand exactly why this is desired, since acpidump already does this.


>One potential glitch I see with this is that the current acpidump
>puts the table address in the text file, so if there is any confusion
>about what tag is at what address, it is easy to refer back to
>the ascii acpidump.out file.
>when we expose the binary tables in user-space, this information is
>no longer present.  dunno if that is important or not.
>
>The other thing Rui is doing is exposing the dynamic tables --
>and that is totally new.
>We could get at those in the past by looking at the AML,
>or more recently, the dmesg, and asking the bug submitter
>to run acpidump with parameters to dump magic addresses.
>What we'd like to do is automate that so they can just
>send us the acpidump output once and that will pull
>in the dynamic tables with the static tables.
>I think this will be valuable.
>
>Unfortunately, dynamic tables will not be exposed in
>cases where we take a path through the AML such that
>they're not loaded -- so we'll still need the manual
>kvm reader method when that happens.


A good idea to expose the dynamically loaded tables. However, there isn't any easy way (that I know of) to know that you have exposed all such dynamic tables (as you point out). Probably you will always get the most important ones, though.


>
>Also, for the cases where we can't boot in ACPI mode at all,
>we'll still need the kvm reader to extract the static
>tables then.
>
>> >  will now get both the "active" and "inactive" tables?
>> yes.
>
>Rui,
>Rather than augmenting the names, such as SSDT_dynamic
>and MADT_inactive, maybe it would make more sense to
>use the original tags, but put them outside
>
>say, in:
>/sys/firmware/acpi/tables/inactive/
>/sys/firmware/acpi/tables/dynamic/
>
>what do you think?

I like the subdirectories.

>
>> > 2) In the FACS firmware waking vector case, we set the vector in both
>the "active" FACS and the "inactive" FACS.
>> Right.
>> >
>> > Again, please note that we have changed the ACPICA interface to set the
>firmware wake vector - splitting into two.
>> hmm, when will this change be shipped to Linux?
>> BTW: Rafael has already proposed a patch which always clears 64 bit wake
>> vector and uses the 32 bit one.
>> http://marc.info/?l=linux-acpi&m=122370808622832&w=2
>
>BTW, Rafael's patch above is staged for 2.6.28.
>
>thanks,
>-Len

The whole "two FACS tables" question is another issue that needs to be resolved. The issues involve the following:

Where is the 32-bit Firmware Waking Vector?
Where is the 64-bit Firmware Waking Vector?
Where is the Global Lock?

These questions boil down to: Is there one "real" FACS, or do we have to go back and forth between the two FACS tables?

Bob

