From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Mon, 31 Oct 2011 09:51:07 -0600
Message-ID: <CAErSpo5X0smhAeoe6b7iEjGWqcZMxjoL82Mk4BqyqZZZp2_Feg@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de>
 <CAErSpo7L1PNLo7TSuCPe3Az9ixSizQmoBWtynhHDZ-T9BhoNtw@mail.gmail.com> <201110311133.31320.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:1741 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933538Ab1JaPvb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Oct 2011 11:51:31 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p9VFpT24032057
	for <linux-acpi@vger.kernel.org>; Mon, 31 Oct 2011 08:51:29 -0700
Received: from qyk30 (qyk30.prod.google.com [10.241.83.158])
	by hpaq3.eem.corp.google.com with ESMTP id p9VFoX75012539
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Mon, 31 Oct 2011 08:51:28 -0700
Received: by qyk30 with SMTP id 30so9875981qyk.1
        for <linux-acpi@vger.kernel.org>; Mon, 31 Oct 2011 08:51:28 -0700 (PDT)
In-Reply-To: <201110311133.31320.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Mon, Oct 31, 2011 at 4:33 AM, Thomas Renninger <trenn@suse.de> wrote=
:
> On Friday 28 October 2011 17:14:39 Bjorn Helgaas wrote:
>> On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wr=
ote:
>> > There is another problem. Would be great to get some opinions/feed=
back
>> > on it already:
>> > APEI GAR entries seem to have invalid bit_width entries on some pl=
atforms.
>> > After looking at several tables, I expect that with APEI tables ac=
cess width
>> > (in bytes) should get used instead, Windows seem to ignore bit wid=
th fields,
>> > at least for APEI tables.
>>
>> I'm confused. =A0How can you tell that the bit_width is incorrect My
>> understanding is that the bit_width is the size of the *register*,
>> while the access_width is the size of access the processor must
>> generate on the bus. =A0The access_width may be larger, for example,=
 if
>> the hardware only supports 32-bit or 64-bit reads.
> This also is my understanding.
>> So I don't understand how you can derive bit_width from access_width=
=2E
> The problem is that Windows seem to ignore the bit width field, at le=
ast
> for APEI tables.
> There you also have the mask value and bit width information is not
> needed to determine the bits of interest.
> While mostly bit width information is correct, I compared quite some
> tables and especially IBM is adding some interesting values.
> But I've also seen wrong bit widths on Supermicro and others.
>
>
>> In the example below, I think we're supposed to do a 64-bit read, th=
en
>> extract 8 bits that contain the register of interest. =A0If we keep =
all
>> 64 bits, I don't see how that can be correct.
> Yep. But "Get Error Address Range" is supposed to return/contain an i=
omem address.
> Cutting it down to 8 bits produces below error when trying to
> reserve a memory region from the retrieved value/address at 0x3f.
> Using acpidump to evaluate the register's 8 byte shows:
> acpidump --addr 0x7F8A8032 --length 8
> 0x000000007f8a803f
> which perfectly fits into an unused e820 reserved memory region.
>
> Same for "Get Error Address Length" on this machine:
> [1D0h 0464 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Action :=
 0E (Get Error Address Length)
> [1D5h 0469 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Bit Width : 0=
8
> [1D7h 0471 =A01] =A0 =A0 =A0 =A0 Encoded Access Width : 03 (DWord Acc=
ess:32)
> [1D8h 0472 =A08] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address :=
 000000007F8A803A
> [1E8h 0488 =A08] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Mask=
 : 00000000FFFFFFFF
>
> Reading 0x7F8A803A you get:
> 0x2000
> which is exactly what you expect as "error memory length", but cut
> down to 8 bits it's wrong.
> Look at the mask value from which you could derive bit width (on APEI=
 tables
> only), it should be 0x16, but it's not needed (bit width info) and sh=
ould
> get ignored because it's sometimes wrong.
>
> The question remains whether Windows (which versions?) is only ignori=
ng bit
> width in their APEI implementation (this is what I currently expect).
> For now, as we have separate APEI GAR checking it should be fine to
> only ignore bit width there. But keeping an eye open and check
> other ACPI tables containing GAR structures out there in the field
> is certainly a good idea.

Seems like these are BIOS bugs.  Do we know for sure that Windows
consumes this information that seems to be wrong?  Have you had a
conversation with the vendor about whether the BIOS is at fault here?

If we make Linux ignore the bit_width, that might "fix" these boxes
with broken BIOSes, but at the cost of breaking a box that uses
bit_width correctly.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
