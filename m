From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Fri, 28 Oct 2011 09:14:39 -0600
Message-ID: <CAErSpo7L1PNLo7TSuCPe3Az9ixSizQmoBWtynhHDZ-T9BhoNtw@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110280349.26410.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:56231 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab1J1PPG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Oct 2011 11:15:06 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p9SFF2TU002299
	for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 08:15:03 -0700
Received: from vws14 (vws14.prod.google.com [10.241.21.142])
	by hpaq1.eem.corp.google.com with ESMTP id p9SFEa1P003253
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 08:15:00 -0700
Received: by vws14 with SMTP id 14so6310357vws.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Oct 2011 08:15:00 -0700 (PDT)
In-Reply-To: <201110280349.26410.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Thu, Oct 27, 2011 at 7:49 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> There is another problem. Would be great to get some opinions/feedbac=
k
> on it already:
> APEI GAR entries seem to have invalid bit_width entries on some platf=
orms.
> After looking at several tables, I expect that with APEI tables acces=
s width
> (in bytes) should get used instead, Windows seem to ignore bit width =
fields,
> at least for APEI tables.

I'm confused.  How can you tell that the bit_width is incorrect?  My
understanding is that the bit_width is the size of the *register*,
while the access_width is the size of access the processor must
generate on the bus.  The access_width may be larger, for example, if
the hardware only supports 32-bit or 64-bit reads.  So I don't
understand how you can derive bit_width from access_width.

In the example below, I think we're supposed to do a 64-bit read, then
extract 8 bits that contain the register of interest.  If we keep all
64 bits, I don't see how that can be correct.

> ...
> Comparing different Generic Adress Register definitions of
> different vendors it came out that bit width (at least in APEI
> tables) is sometimes wrong or used different compared to older
> ACPI BIOS definitions (e.g. older FACP tables).
> It looks like Windows ignores the bit width field in
> latest implementations. Either in APEI table parts only
> (I'd say more likely) or in other ACPI parts as well.
>
> Worst case is that an address value to be read from a GAR structure
> can have a 8 bit width definition resulting in:
> ERST: Can not request iomem region <0x =A0 =A0 =A0 =A0 =A0 =A0 =A03f-=
0x =A0 =A0 =A0 =A0 =A0 =A0 =A03f>
> while the access width is correct:
> [1B0h 0432 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Action :=
 0D (Get Error Address Range)
> [1B4h 0436 12] =A0 =A0 =A0 =A0 =A0 =A0 =A0Register Region : <Generic =
Address Structure>
> [1B4h 0436 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Space ID : 0=
0 (SystemMemory)
> [1B5h 0437 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Bit Width : 0=
8
> [1B6h 0438 =A01] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Bit Offset : 00
> [1B7h 0439 =A01] =A0 =A0 =A0 =A0 Encoded Access Width : 04 (QWord Acc=
ess:64)
> [1B8h 0440 =A08] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Address :=
 000000007F8A8032

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
