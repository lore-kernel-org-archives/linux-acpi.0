From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Mon, 31 Oct 2011 11:33:30 +0100
Message-ID: <201110311133.31320.trenn@suse.de>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de> <CAErSpo7L1PNLo7TSuCPe3Az9ixSizQmoBWtynhHDZ-T9BhoNtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56938 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440Ab1JaJdN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 31 Oct 2011 05:33:13 -0400
In-Reply-To: <CAErSpo7L1PNLo7TSuCPe3Az9ixSizQmoBWtynhHDZ-T9BhoNtw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Friday 28 October 2011 17:14:39 Bjorn Helgaas wrote:
> On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wrote:
> > There is another problem. Would be great to get some opinions/feedback
> > on it already:
> > APEI GAR entries seem to have invalid bit_width entries on some platforms.
> > After looking at several tables, I expect that with APEI tables access width
> > (in bytes) should get used instead, Windows seem to ignore bit width fields,
> > at least for APEI tables.
> 
> I'm confused.  How can you tell that the bit_width is incorrect My
> understanding is that the bit_width is the size of the *register*,
> while the access_width is the size of access the processor must
> generate on the bus.  The access_width may be larger, for example, if
> the hardware only supports 32-bit or 64-bit reads.
This also is my understanding.
> So I don't understand how you can derive bit_width from access_width.
The problem is that Windows seem to ignore the bit width field, at least
for APEI tables.
There you also have the mask value and bit width information is not
needed to determine the bits of interest.
While mostly bit width information is correct, I compared quite some
tables and especially IBM is adding some interesting values.
But I've also seen wrong bit widths on Supermicro and others.


> In the example below, I think we're supposed to do a 64-bit read, then
> extract 8 bits that contain the register of interest.  If we keep all
> 64 bits, I don't see how that can be correct.
Yep. But "Get Error Address Range" is supposed to return/contain an iomem address.
Cutting it down to 8 bits produces below error when trying to
reserve a memory region from the retrieved value/address at 0x3f.
Using acpidump to evaluate the register's 8 byte shows:
acpidump --addr 0x7F8A8032 --length 8
0x000000007f8a803f
which perfectly fits into an unused e820 reserved memory region.

Same for "Get Error Address Length" on this machine:
[1D0h 0464  1]                       Action : 0E (Get Error Address Length)
[1D5h 0469  1]                    Bit Width : 08
[1D7h 0471  1]         Encoded Access Width : 03 (DWord Access:32)
[1D8h 0472  8]                      Address : 000000007F8A803A
[1E8h 0488  8]                         Mask : 00000000FFFFFFFF

Reading 0x7F8A803A you get:
0x2000
which is exactly what you expect as "error memory length", but cut
down to 8 bits it's wrong.
Look at the mask value from which you could derive bit width (on APEI tables
only), it should be 0x16, but it's not needed (bit width info) and should
get ignored because it's sometimes wrong.

The question remains whether Windows (which versions?) is only ignoring bit
width in their APEI implementation (this is what I currently expect).
For now, as we have separate APEI GAR checking it should be fine to
only ignore bit width there. But keeping an eye open and check
other ACPI tables containing GAR structures out there in the field
is certainly a good idea.

Another "wrong" GAR definition I've found (only once) is that all fields
(bit width, byte access, ...) are zero, similar to optional FADT GAR structures.
I didn't runtime test it, but currently this should pass an error
and invalidate the whole table (for example should result in erst_disable=1).
Additional logic is needed to ignore and not use this serialization command
as if it does not exist.

  Thomas

> > ...
> > Comparing different Generic Adress Register definitions of
> > different vendors it came out that bit width (at least in APEI
> > tables) is sometimes wrong or used different compared to older
> > ACPI BIOS definitions (e.g. older FACP tables).
> > It looks like Windows ignores the bit width field in
> > latest implementations. Either in APEI table parts only
> > (I'd say more likely) or in other ACPI parts as well.
> >
> > Worst case is that an address value to be read from a GAR structure
> > can have a 8 bit width definition resulting in:
> > ERST: Can not request iomem region <0x              3f-0x              3f>
> > while the access width is correct:
> > [1B0h 0432  1]                       Action : 0D (Get Error Address Range)
> > [1B4h 0436 12]              Register Region : <Generic Address Structure>
> > [1B4h 0436  1]                     Space ID : 00 (SystemMemory)
> > [1B5h 0437  1]                    Bit Width : 08
> > [1B6h 0438  1]                   Bit Offset : 00
> > [1B7h 0439  1]         Encoded Access Width : 04 (QWord Access:64)
> > [1B8h 0440  8]                      Address : 000000007F8A8032
> 
> Bjorn
