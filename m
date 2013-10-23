From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Resend PATCH 5/5] IA64/PCI/ACPI: Rework PCI root bridge ACPI
 resource conversion
Date: Wed, 23 Oct 2013 16:39:04 -0600
Message-ID: <20131023223904.GA18454@google.com>
References: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com>
 <1381493941-4650-6-git-send-email-tianyu.lan@intel.com>
 <20131016235541.GD17866@google.com>
 <525F7F0F.5010306@intel.com>
 <CAErSpo7P+n5c2uUoodT=LOjE3UH3LBcjifbj8reXzAeWydsoLA@mail.gmail.com>
 <52612D1C.4070701@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43604 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab3JWWjI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Oct 2013 18:39:08 -0400
Received: by mail-ie0-f177.google.com with SMTP id e14so2495986iej.36
        for <linux-acpi@vger.kernel.org>; Wed, 23 Oct 2013 15:39:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <52612D1C.4070701@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Yoknis, Mike" <mike.yoknis@hp.com>, "Pearson, Greg" <greg.pearson@hp.com>

[+cc Greg]

On Fri, Oct 18, 2013 at 08:44:12PM +0800, Lan Tianyu wrote:
> On 10/18/2013 04:33 AM, Bjorn Helgaas wrote:
>> On Thu, Oct 17, 2013 at 12:09 AM, Lan Tianyu <tianyu.lan@intel.com> =
wrote:
>>>On 2013=E5=B9=B410=E6=9C=8817=E6=97=A5 07:55, Bjorn Helgaas wrote:
>>>> On Fri, Oct 11, 2013 at 08:19:01PM +0800, tianyu.lan@intel.com wro=
te:

>>I wonder if it would make sense to make
>>acpi_dev_resource_address_space() ignore addr.translation_offset for
>>IO resources.  Or maybe ignore it if the _TTP (type translation) bit
>>is set?
>
> I wonder why current code doesn't check _TTP? The code in the
> add_io_space() seems to think _TTP is always set, right?

I think it's an oversight, and you should fix it.  I suggest that you
ignore the _TRA value when _TTP is set.  Obviously this only applies
to I/O port resources, since _TTP is only defined in the I/O Resource
=46lag (Table 6-185 in ACPI 5.0 spec).

>>Mike, is there any chance you could collect an acpidump from an
>>rx7620 or similar ia64 system?  In particular, I want to see a
>>multi-node system where we have several PCI domains, and whether it
>>sets the _TTP bits.

Greg collected an acpidump from an HP system that uses these I/O port
ranges. =C2=A0Unfortunately the system wasn't running Linux, so it's an=
 EFI
dump, not the usual one we get from the "pmtools" package.  But I
think it has the information we want.

It's huge, and I put some of the relevant parts of it here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D63581  Here's a sample
that shows the _TTP bit is set for the I/O aperture:

    Device E000 (\_SB_.N000.E000)
      Name _SEG (\_SB_.N000.E000._SEG)
        0x01
      Name _CRS (\_SB_.N000.E001._CRS)
        Buffer
          0x0092
          ByteList <0x88 0x0d 0x00 0x02 0x0e 0x00 0x00 0x00
                    0x00 0x00 0xff 0x00 0x00 0x00 0x00 0x01

                    0x8a 0x2b 0x00 0x01 0x0c 0x33 0x00 0x00
                    0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
                    0x00 0x00 0x00 0x00 0x00 0x00 0xff 0xff
                    0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
                    0x00 0xd0 0x00 0x04 0x00 0x00 0x00 0x00
                    0x01 0x00 0x00 0x00 0x00 0x00

Byte 0: 0x8a (QWORD address space descriptor)
Byte 3: Resource Type =3D 0x01 (I/O range)
Byte 5: Type Specific Flags =3D 0x33 (_TRS, _TTP, _RNG =3D 3)

          QWORD Address Space Descriptor:
             Type: I/O
             Flags:  Sparse, Translate, ISA I/O addresses, Non-ISA I/O =
addresses
             GRA: 0x0000000000000000
             MIN: 0x0000000000000000  MAX: 0x000000000000ffff
             TRA: 0x00000400d0000000  LEN: 0x0000000000010000
             MAX address fixed
             MIN address fixed
             Address positively decoded
             Device produces and consumes this resource

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
