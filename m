From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] ACPI: Re-factor and remove ./drivers/acpi/atomicio.[ch]
Date: Thu, 3 Nov 2011 07:53:09 -0600
Message-ID: <CAErSpo7CTFTCQRPJtAqYM2VnhV4nOWX799YrwCBZTufGZ7rMEQ@mail.gmail.com>
References: <20110929215907.21126.24480.stgit@amt.stowe> <201110311133.31320.trenn@suse.de>
 <CAErSpo5X0smhAeoe6b7iEjGWqcZMxjoL82Mk4BqyqZZZp2_Feg@mail.gmail.com> <201111031016.52676.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53965 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1KCNxc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Nov 2011 09:53:32 -0400
Received: by ggnb2 with SMTP id b2so1338338ggn.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 Nov 2011 06:53:31 -0700 (PDT)
In-Reply-To: <201111031016.52676.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Myron Stowe <myron.stowe@redhat.com>, Len Brown <len.brown@intel.com>, bondd@us.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com

On Thu, Nov 3, 2011 at 3:16 AM, Thomas Renninger <trenn@suse.de> wrote:
> On Monday, October 31, 2011 04:51:07 PM Bjorn Helgaas wrote:
>> On Mon, Oct 31, 2011 at 4:33 AM, Thomas Renninger <trenn@suse.de> wr=
ote:
>
>> Seems like these are BIOS bugs. =A0Do we know for sure that Windows
>> consumes this information that seems to be wrong? =A0Have you had a
>> conversation with the vendor about whether the BIOS is at fault here=
?
> Such closed specifications between a major OS and specific HW vendors
> should be forbidden by law and I expect in some countries you'll win
> if you contest this contract in a high enough court...
> APEI is based on the Windows WHEA specification which only specific
> vendors can retrieve from Windows if they sign an NDA contract.
> I could imagine there you find details about the GAS structure usage
> in WHEA/APEI tables the way Windows like it.
>
> After looking at quite a lot APEI tables and their bit width, byte ac=
cess
> and mask values, I am pretty sure bit width is ignored on Windows.
> Or say, if these tables are used, access width is always correct whil=
e
> bit width is not.
>
>> If we make Linux ignore the bit_width, that might "fix" these boxes
>> with broken BIOSes, but at the cost of breaking a box that uses
>> bit_width correctly.
> None of the "broken bit width" boxes I looked at should break if
> access width is used.

Yes, but bit_width is a standard part of the ACPI generic address
structure, and there's nothing to prevent a future BIOS from using it
and expecting it to work as documented.  If we make Linux
ignore/override the bit_width now, we'll build a legacy of machines
that depend on the fact that we ignore it, and then we would have no
way to deal with future machines that might expect us to pay attention
to it.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
