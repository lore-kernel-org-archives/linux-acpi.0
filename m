From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPICA: support Generic Address Structure bit_offset in acpi_read/write
Date: Mon, 12 Dec 2011 16:39:45 +0100
Message-ID: <201112121639.45975.trenn@suse.de>
References: <20111111230347.20897.28797.stgit@bhelgaas.mtv.corp.google.com> <201111162058.09549.trenn@suse.de> <CAErSpo49CSmB8hNW0Cecfs8WkxMPTpeYV=5Fat-OiB-nC9gj5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58421 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab1LLPju (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Dec 2011 10:39:50 -0500
In-Reply-To: <CAErSpo49CSmB8hNW0Cecfs8WkxMPTpeYV=5Fat-OiB-nC9gj5g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, bondd@us.ibm.com, Myron Stowe <myron.stowe@redhat.com>

On Thursday, November 17, 2011 01:15:28 AM Bjorn Helgaas wrote:
...
> There's a lot of speculation above about Windows duplicating GAS
> parsing, using mask instead of bit_width, etc.  I don't think we have
> good evidence for it.  In general, my experience is that Windows has a
> pretty high-quality ACPI implementation (though obviously it sometimes
> interprets things differently than Linux), so I hesitate to assume
> special cases like this in Windows.
> 
> APEI support in BIOSes is immature, and I don't want to hard-code
> assumptions into Linux based on a few possibly defective BIOSes.
> Assumptions like that will constrain us in the future.
I agree.
But as long as we do not have more (detailed) info how things work
on Windows or how BIOS writers expect things to work, I recommend
to *not* merge the GAR parsing APEI parts into a generic layer.

Changing, blacklisting or working around in ACPICA is cumbersome and
if extra patches need to go into stable@ it's not nice to handle
if things are in ACPICA.

Also as the code is not much and only used at one single place,
I do not see the urgent need for generalizing it.

...
> You seem to have a nice collection of DSDT/APEI/etc tables.  Can you
> get any idea of how many of them contain GAS structures that would
> break under my proposal
> (https://docs.google.com/spreadsheet/ccc?key=0AjvKas55tQpqdElKVXM2TEFVcnI3SjVuZ1pqUENMN1E)?
Nice!
Imo all finally decalred "Illegal" rows should end up in a
"FIRMWARE BUG" messages, maybe some which could get
workarounded should also be marked as such.

-> ACPICA is still lacking a FW_BUG marker as Linux has.
Would an additional macro like:
include/acpi/acoutput.h:#define ACPI_ERROR(plist)               acpi_error plist
which may look like:
include/acpi/acoutput.h:#define ACPI_FW_BUG(plist)              acpi_fw_bug plist
and which starts with:
FIRMWARE BUG - ACPI...
be acceptable in the ACPICA sources?

It's not that I want to go through all messages and adjust
them. But it would be great to get a starting and convert a message
if it shows up in a kernel log buffer and clearly is a BIOS bug.


Some examples which would break:

Wrong bit width
---------------
bit width - access width (in bits and hex) ...
08        - 40    Bit width not equal Access width - Mask: FFFFFFFFFFFFFFFF
08        - 20    Bit width not equal Access width - Mask: 00000000FFFFFFFF
I've seen these on 2 totally different platforms,
might still be the same source (copy and pasted or whatever).
Above are:
Get Error Address Range
and
Get Error Address Length
which are both cut down to 8 bit right now.
Both should work fine when the mask and/or access width value
is used to determine the relevant bits instead of bit width.
-> This case definitely should issue a message pointing to broken
Firmware.

Not aligned bit width
---------------------
bit width - access width (in bits and hex) ...
03        - 20    Bit width not equal Access width - Mask: 0000000000000007
03        - 20    Bit width not equal Access width - Mask: 0000000000000007
03        - 20    Bit width not equal Access width - Mask: 0000000000000007
03        - 20    Bit width not equal Access width - Mask: 0000000000000007
18        - 20    Bit width not equal Access width - Mask: 0000000000FFFFFF
01        - 20    Bit width not equal Access width - Mask: 0000000000000001
Should get handled correctly with your approach.
I've only seen this on (older?) platforms of a specific vendor.
But on several, and if, clustered all through ERST.dsl.

bit width greater than access width
-----------------------------------
bit width - access width (in bits and hex) ...
40        - 10    Bit width not equal Access width - Mask: 000000000000FFFF
The bit width of 0x40 is weird, no idea what it should be good
for. But your approach should handle this correctly.
Is it worth a firmware warning message?


Other "not that normal" GARs
----------------------------
bit width - access width (in bits and hex) ...
20        - 10    Bit width not equal Access width - Mask: FFFFFFFFFFFFFFFF
Same as above, but with a 64 bit mask.
Might be a good candidate for finding out intended behavior
(if things are correctly (as programmers intended) used on Windows (if at all)).
Your approach would take 0x20 bits...
Hm, better do not count this one, may be an early BIOS (another
bug is in there, an action value marked as "reserved" in the spec
is used...).
I'll update the BIOS and boot a recent kernel if I find the
time.

Everything is zero
------------------
Not mentioned in your table. Only saw it once:
access, bit width, offset and mask value are all zero
-> May come from some code generating the GARs, should just
get ignored without any warning?

Hope that helps.

For now it would be great if the one or other patch
would show up in a acpi-next branch.
Not sure if I miss something, but no ACPI patches for 3.3 were
pushed into any (linux-next) tree yet?
I could imagine it's not that easy to merge the spec 5.0
parts and that's the reason nothing has shown up there yet?

Still, hopefully something shows up there soon, as Myron's
and Ying's patches need to get serialized and before this
does not happen it's not worth writing any code which
potentially conflicts with other pending patches.

   Thomas
